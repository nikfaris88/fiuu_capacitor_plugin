import Foundation
import Capacitor
import UIKit

@objc(FiuuPaymentPlugin)
public class FiuuPaymentPlugin: CAPPlugin, MOLPayLibDelegate {
    public func onFinishedDeepLink() {
    }
    
    var molpay: MOLPayLib?
    var call: CAPPluginCall?

    @objc func startPayment(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            guard let paymentDetails = call.options as? [String: Any] else {
                call.reject("Missing or invalid payment details")
                return
            }

            self.call = call

            var paymentDetailsMutable = paymentDetails
            paymentDetailsMutable["is_submodule"] = "YES"
            paymentDetailsMutable["module_id"] = "fiuu-capacitor-xdk-ios"
            paymentDetailsMutable["wrapper_version"] = "0"

            guard let window = UIApplication.shared.windows.first else {
                call.reject("Unable to access main window")
                return
            }

            self.molpay = MOLPayLib(delegate: self, andPaymentDetails: paymentDetailsMutable)

            let navController = UINavigationController(rootViewController: self.molpay!)
            navController.modalPresentationStyle = .fullScreen

            window.rootViewController?.present(navController, animated: true, completion: nil)
        }
    }

    public func transactionResult(_ result: [AnyHashable: Any]!) {
        guard let resultDict = result as? [String: Any] else { return }

        DispatchQueue.main.async {
            self.molpay?.dismiss(animated: true) {
                self.call?.resolve([
                    "status": "Payment Completed",
                    "data": resultDict
                ])
                self.call = nil
            }
        }
    }
}
