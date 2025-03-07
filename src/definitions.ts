export interface PaymentDetails {
  mp_username: string;
  mp_password: string;
  mp_merchant_ID: string;
  mp_app_name: string;
  mp_verification_key: string;
  mp_order_ID: string;
  mp_amount: string;
  mp_currency: string;
  mp_country: string;
  mp_channel: string;
  mp_bill_description: string;
  mp_bill_name: string;
  mp_bill_email: string;
  mp_bill_mobile: string;
}

export interface FiuuPaymentPlugin {
  startMolpay(details: PaymentDetails): Promise<{ result: any }>;
}
