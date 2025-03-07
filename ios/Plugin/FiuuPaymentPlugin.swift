import Foundation
import Capacitor
import UIKit

@objc(FiuuPaymentPlugin)
public class FiuuPaymentPlugin: CAPPlugin {
    var call: CAPPluginCall?
    var molPayLib: MOLPayLib?

    @objc func startPayment(_ call: CAPPluginCall) {
        guard let paymentDetails = call.options as? [String: Any] else {
            call.reject("Missing or invalid payment details")
            return
        }

        self.call = call

        var paymentDetailsMutable = paymentDetails
        paymentDetailsMutable["is_submodule"] = "YES"
        paymentDetailsMutable["module_id"] = "fiuu-capacitor-xdk-ios"
        paymentDetailsMutable["wrapper_version"] = "0"

        DispatchQueue.main.async {
            self.molPayLib = MOLPayLib(delegate: self, andPaymentDetails: paymentDetailsMutable)

            if let viewController = self.bridge?.viewController, let molPayLib = self.molPayLib {
                viewController.present(molPayLib, animated: true, completion: nil)
            } else {
                self.call?.reject("Unable to present MOLPayLib")
            }
        }
    }
}

// MARK: - MOLPayLibDelegate
extension FiuuPaymentPlugin: MOLPayLibDelegate {
    public func onFinishedDeepLink() {
        print("MOLPay deep link finished")
    }

    public func transactionResult(_ result: [AnyHashable: Any]!) {
        guard let resultDict = result as? [String: Any] else { return }

        DispatchQueue.main.async {
            self.molPayLib?.dismiss(animated: true, completion: {
                self.call?.resolve([
                    "status": "Payment Completed",
                    "data": resultDict
                ])
                self.call = nil
            })
        }
    }
}
