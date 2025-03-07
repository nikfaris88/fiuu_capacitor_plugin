#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Register FiuuPaymentPlugin with all its methods
CAP_PLUGIN(FiuuPaymentPlugin, "FiuuPaymentPlugin",
    CAP_PLUGIN_METHOD(startPayment, CAPPluginReturnPromise);
);
