package com.fiuu.plugin.capacitor;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import androidx.activity.result.ActivityResult;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.ActivityCallback;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.molpay.molpayxdk.MOLPayActivity;
import com.molpay.molpayxdk.googlepay.ActivityGP;

import java.util.HashMap;
import org.json.JSONException;
import org.json.JSONObject;

@CapacitorPlugin(name = "FiuuPaymentPlugin")
public class FiuuPaymentPlugin extends Plugin {

    @PluginMethod
    public void startPayment(PluginCall call) {
        Activity activity = getActivity();

        if (activity == null) {
            call.reject("Activity is null");
            return;
        }

        try {
            // Extract payment details from PluginCall
            HashMap<String, Object> paymentDetails = new HashMap<>();
            JSONObject data = call.getData();

            for (int i = 0; i < data.names().length(); i++) {
                String key = data.names().getString(i);
                Object value = data.get(key);
                paymentDetails.put(key, value);
            }

            // Start MOLPayActivity
            Intent intent;
            if (!paymentDetails.containsKey(MOLPayActivity.mp_channel)) {
                intent = new Intent(activity, com.molpay.molpayxdk.googlepay.ActivityGP.class);
            } else {
                intent = new Intent(activity, MOLPayActivity.class);
            }

            intent.putExtra(MOLPayActivity.MOLPayPaymentDetails, paymentDetails);
            startActivityForResult(call, intent, "handlePaymentResult");

        } catch (JSONException e) {
            call.reject("Error parsing payment details: " + e.getMessage());
        } catch (Exception e) {
            call.reject("Error in start payment: " + e.getMessage());
        }
    }

    @ActivityCallback
    private void handlePaymentResult(PluginCall call, ActivityResult result) {
        Log.d("TAG", "plugincall: " + call);

        Intent data = result.getData(); // Extract Intent from ActivityResult
        if (data != null && data.hasExtra(MOLPayActivity.MOLPayTransactionResult)) {
            String transactionResult = data.getStringExtra(MOLPayActivity.MOLPayTransactionResult);
            JSObject response = new JSObject();
            response.put("result", transactionResult);
            call.resolve(response);
        } else {
            call.reject("Payment failed or was canceled");
        }
    }
}
