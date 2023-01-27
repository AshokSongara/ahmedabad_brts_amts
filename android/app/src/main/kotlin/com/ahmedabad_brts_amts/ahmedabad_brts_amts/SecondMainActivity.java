package com.ahmedabad_brts_amts.ahmedabad_brts_amts;

import android.content.Intent;
import android.os.Bundle;
import android.util.Base64;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.ahmedabad_brts_amts.Constant;
import com.ahmedabad_brts_amts.Model.Request.EncHMACRequest;
import com.ahmedabad_brts_amts.Model.Request.HMACRequest;
import com.ahmedabad_brts_amts.Model.Response.HMACResponse;
import com.ahmedabad_brts_amts.Model.Response.PaymentCallResponse;
import com.ahmedabad_brts_amts.Model.Response.TokenResponse;
import com.ahmedabad_brts_amts.Network.ApiInterface;
import com.ahmedabad_brts_amts.Network.RetrofitApiClient;
import com.firstdata.fdsdk.FDPaymentSDK;
import com.firstdata.fdsdk.common.FDSdkResponse;
import com.google.gson.Gson;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class SecondMainActivity extends AppCompatActivity {
    private ProgressBar mProgressBar;
    private Button button;
    private Button btnCheckout;
    private TextView textView;
    private String sessionToken = "";
    private FDPaymentSDK fdPaymentSDK;
    private String randomkey;
    private ApiInterface apiService;

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mProgressBar    = findViewById(R.id.progressBar);
        mProgressBar.setVisibility(View.GONE);

        button          = findViewById(R.id.button);
        button.setVisibility(View.GONE);
        btnCheckout          = findViewById(R.id.btncheckout);
        textView        = findViewById(R.id.textView);
        textView.setVisibility(View.GONE);
        apiService = RetrofitApiClient.getClient().create(ApiInterface.class);

        btnCheckout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                initiateApiCall();
            }
        });

    }

    @Override
    protected void onStart() {
        super.onStart();
    }

    @Override
    protected void onPostResume() {
        super.onPostResume();
    }

    private void initiateApiCall() {
        mProgressBar.setVisibility(View.VISIBLE);
        textView.setVisibility(View.VISIBLE);
        textView.setText("Generate HMAC");
        button.setVisibility(View.GONE);
        btnCheckout.setVisibility(View.GONE);

        randomkey = generateString();


        hmacApiCall();
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        try {
            super.onActivityResult(requestCode, resultCode, data);
            Intent myIntent = new Intent(SecondMainActivity.this, SuccessActivity.class);
            String value = data.getStringExtra(FDSdkResponse.FD_PAYMENT_RESULT);

            Gson gson = new Gson();
            PaymentCallResponse paymentCallResponse = gson.fromJson(value, PaymentCallResponse.class);
            String response = paymentCallResponse.response;
            Log.e("Nithin", "Came inside here response"+ response);

            myIntent.putExtra("key", value);
            ClearData();


            SecondMainActivity.this.startActivity(myIntent);
            finish();

        } catch (Exception ex) {
            Toast.makeText(SecondMainActivity.this, ex.toString(), Toast.LENGTH_SHORT).show();
        }

    }

    private void ClearData() {
        textView.setText("");
        textView.setVisibility(View.GONE);
        button.setVisibility(View.GONE);
        btnCheckout.setVisibility(View.VISIBLE);
    }

    private void hmacApiCall() {
        HMACRequest hmacRequest = getHmacRequest();

        Call<HMACResponse> call = apiService.getHMACData(Constant.MerchantId, hmacRequest);
        call.enqueue(new Callback<HMACResponse>() {
            @Override
            public void onResponse(Call<HMACResponse> call, Response<HMACResponse> response) {
                textView.setText("Generate Session Token");
                tokenApiCall( response.body().hmac);
            }

            @Override
            public void onFailure(Call<HMACResponse>call, Throwable t) {
                //Error Response from hmacApiCall
                mProgressBar.setVisibility(View.GONE);
            }
        });
    }


    private void tokenApiCall(final String hMac) {

        EncHMACRequest encHMACRequest = new EncHMACRequest();
        encHMACRequest.encryptData = getEncryptDataReq(getHMACString());

        Call<TokenResponse> call = apiService.getTokenResponse(hMac, Constant.MerchantId, encHMACRequest);
        call.enqueue(new Callback<TokenResponse>() {
            @Override
            public void onResponse(Call<TokenResponse>call, Response<TokenResponse> response) {

                sessionToken = response.body().response.sessionTokenId;

                fdPaymentSDK = new FDPaymentSDK(sessionToken, Constant.PageId, SecondMainActivity.this);
                fdPaymentSDK.initSDK();
                textView.setVisibility(View.GONE);
                mProgressBar.setVisibility(View.GONE);
            }

            @Override
            public void onFailure(Call<TokenResponse>call, Throwable t) {
                mProgressBar.setVisibility(View.GONE);
            }
        });
    }

    private HMACRequest getHmacRequest() {
        String jsonData = getHMACString();
        Gson gson = new Gson();
        HMACRequest mHMACData =  gson.fromJson(jsonData, HMACRequest.class);
        return mHMACData;
    }


    private String generateString() {
        String uuid = Long.toHexString(Double.doubleToLongBits(Math.random()));
        return  uuid;
    }

    private String getHMACString() {
        String jsonData = "{\"customerDetails\":{\"billingAddress\":{\"city\":\"Mumbai\",\"country\":\"India\",\"state\":\"Maharashtra\",\"stree2\":\"Sai Nagar\",\"street1\":\"Ghodbandar Rode\",\"zipcode\":400000},\"customerId\":\"ABC123\",\"emailId\":\"prashanth@gmail.com\",\"hostedIds\":[\"KRS1220ESFFTR8490\"],\"mobileNo\":1234567890,\"name\":{\"firstName\":\"ABC\",\"lastName\":\"XYZ\",\"middleName\":\"DEF\",\"suffix\":\"ADX\"},\"shippingAddress\":{\"city\":\"Mumbai\",\"country\":\"India\",\"state\":\"Maharashtra\",\"stree2\":\"Sai nagar\",\"street1\":\"Ghodbandar Rode\",\"zipcode\":4000000}},\"productData\":{\"discountPrice\":0,\"price\":1,\"productDescription\":\"Water Bottle\",\"productId\":\"P123\",\"quantity\":1,\"shippingFee\":20,\"txnAmount\":120},\"resultURL\":\"https://test.fdconnect.com/FirstPayL2Services/merchantSuccessPage.jsp\",\"transactionDetails\":{\"amount\":\"1\",\"clientTransactionId\":";
        jsonData = jsonData.concat("\""+randomkey+"\",");
        jsonData = jsonData.concat("\"currencyCode\":\"INR\",\"transactionType\":\"sale\"}}");
        return jsonData;
    }

    private String getEncryptDataReq(String jsonData) {
        String cipherText =  aesEncrypt(jsonData, "CNy+HimxmI4PmrJWrpLarBfbo6jIY/CHcezg2VQ8u5o=", "9T4hd3Nx0b0sMgYuyWLCTg==");


       // String cipherText = aesEncrypt(jsonData, "mjgpueRomVg1b31C4ZgErmFxznlc/DBP6+hv8sbU6+g=", "JCuPw0RB3uY5tvXHTQp4vQ==") ;
        return cipherText;
    }

    private String aesEncrypt(String jsonData, String secretKey,  String ivValue) {
        try {
            byte[] ivEncoded = Base64.decode(ivValue, Base64.DEFAULT);
            byte[] encoded = Base64.decode(secretKey, Base64.DEFAULT);

            IvParameterSpec iv = new IvParameterSpec(ivEncoded);
            SecretKeySpec secretKeySpec = new SecretKeySpec(encoded, "AES");

            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
            cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, iv);

            byte[] encrypted = cipher.doFinal(jsonData.getBytes());
            return Base64.encodeToString(encrypted, Base64.DEFAULT).replace("\n", "");
        } catch ( Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }


}
