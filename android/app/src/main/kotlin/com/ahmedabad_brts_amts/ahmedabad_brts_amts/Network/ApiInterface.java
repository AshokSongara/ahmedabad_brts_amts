package com.ahmedabad_brts_amts.ahmedabad_brts_amts.Network;
import com.ahmedabad_brts_amts.ahmedabad_brts_amts.Constant;
import com.ahmedabad_brts_amts.ahmedabad_brts_amts.Model.Request.DecryptMerchantRequest;
import com.ahmedabad_brts_amts.ahmedabad_brts_amts.Model.Request.EncHMACRequest;
import com.ahmedabad_brts_amts.ahmedabad_brts_amts.Model.Request.HMACRequest;
import com.ahmedabad_brts_amts.ahmedabad_brts_amts.Model.Response.DecryptMerchantResponse;
import com.ahmedabad_brts_amts.ahmedabad_brts_amts.Model.Response.HMACResponse;
import com.ahmedabad_brts_amts.ahmedabad_brts_amts.Model.Response.TokenResponse;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.Header;
import retrofit2.http.Headers;
import retrofit2.http.POST;

public interface ApiInterface {

    @POST(Constant.API_GET_HMAC)
    Call<HMACResponse> getHMACData(@Header("merchantId") String merchantId, @Body HMACRequest jsonData);

    @POST(Constant.API_GET_TOKEN)
    Call<TokenResponse> getTokenResponse(@Header("HMAC") String hmac, @Header("merchantId") String merchantId, @Body EncHMACRequest jsonData);

    @Headers("Content-Type: application/json")
    @POST(Constant.API_DECRYPT_RESPONSE)
    Call<DecryptMerchantResponse> getDecryptResponse(@Body DecryptMerchantRequest jsonStr);

}
