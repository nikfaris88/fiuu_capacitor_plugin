import Foundation
import Capacitor
import UIKit

@objc(FiuuPaymentPlugin)
public class FiuuPaymentPlugin: CAPPlugin {

    var call: CAPPluginCall?

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

        sendPaymentDetailsToFiuu(paymentDetailsMutable)
    }

    private func sendPaymentDetailsToFiuu(_ paymentDetails: [String: Any]) {
        // Assuming this function should send data to another handler (modify if needed)
        print("Sending payment details to FiuuPayment system: \(paymentDetails)")

        self.call?.resolve([
            "status": "Payment initiated",
            "data": paymentDetails
        ])
    }
}
