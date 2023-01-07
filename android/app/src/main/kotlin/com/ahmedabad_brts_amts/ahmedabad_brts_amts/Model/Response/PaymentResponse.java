package com.ahmedabad_brts_amts.ahmedabad_brts_amts.Model.Response;


import com.ahmedabad_brts_amts.ahmedabad_brts_amts.Model.Request.DecryptMerchantRequest;

public class PaymentResponse {
    public String MerchantTxnId;
    public String TransactionStatus;
    public String TransactionStatusCode;
    public DecryptMerchantRequest decryptMerchantResponse;
    public String transactionId;
}
