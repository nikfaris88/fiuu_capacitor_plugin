#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

CAP_PLUGIN(FiuuPaymentPlugin, "FiuuPaymentPlugin",
    CAP_PLUGIN_METHOD(startPayment, CAPPluginReturnPromise);
);
