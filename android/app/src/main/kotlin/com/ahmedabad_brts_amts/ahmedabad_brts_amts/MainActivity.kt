package com.ahmedabad_brts_amts.ahmedabad_brts_amts

import android.content.Intent
import android.util.Base64
import android.util.Log
import android.widget.Toast
import com.ahmedabad_brts_amts.Constant
import com.ahmedabad_brts_amts.Model.Request.EncHMACRequest
import com.ahmedabad_brts_amts.Model.Request.HMACRequest
import com.ahmedabad_brts_amts.Model.Response.HMACResponse
import com.ahmedabad_brts_amts.Model.Response.PaymentCallResponse
import com.ahmedabad_brts_amts.Model.Response.TokenResponse
import com.ahmedabad_brts_amts.Network.ApiInterface
import com.ahmedabad_brts_amts.Network.RetrofitApiClient
import com.firstdata.fdsdk.FDPaymentSDK
import com.firstdata.fdsdk.common.FDSdkResponse.FD_PAYMENT_RESULT
import com.google.gson.Gson
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.lang.Double
import java.lang.Long
import javax.crypto.Cipher
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.SecretKeySpec
import kotlin.Exception
import kotlin.Int
import kotlin.String
import kotlin.Throwable
import kotlin.let


class MainActivity : FlutterActivity() {
    private var sessionToken = ""
    private var fdPaymentSDK: FDPaymentSDK? = null
    private var randomkey: String? = null
    private var apiService: ApiInterface? = null
    private val CHANNEL = "nativeChannel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result? ->
                if (call.method == "setToast") {
                    apiService = RetrofitApiClient.getClient().create(ApiInterface::class.java)
                    Toast.makeText(context, "Called here", Toast.LENGTH_SHORT).show()
                    initiateApiCall()
//                    val myText = call.argument<String>("myText")
//                    val myIntent = Intent(
//                        this@MainActivity,
//                        SecondMainActivity::class.java
//                    )
//                    this@MainActivity.startActivity(myIntent)
                }
            }

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent) {
        try {
            super.onActivityResult(requestCode, resultCode, data)
            val myIntent = Intent(
                this@MainActivity,
                SuccessActivity::class.java
            )
            val value = data.getStringExtra(FD_PAYMENT_RESULT)
            val gson = Gson()
            val paymentCallResponse: PaymentCallResponse =
                gson.fromJson(value, PaymentCallResponse::class.java)
            val response: String = paymentCallResponse.response
            Log.e("Nithin", "Came inside here response$response")

            myIntent.putExtra("key", value)
            this@MainActivity.startActivity(myIntent)
            // finish()
        } catch (ex: java.lang.Exception) {
            Toast.makeText(this@MainActivity, ex.toString(), Toast.LENGTH_SHORT).show()
        }
    }

    private fun initiateApiCall() {
        randomkey = generateString()
        hmacApiCall()
    }

    private fun generateString(): String? {
        return Long.toHexString(Double.doubleToLongBits(Math.random()))
    }


    private fun hmacApiCall() {
        val hmacRequest: HMACRequest = getHmacRequest()!!
        val call: Call<HMACResponse> =
            apiService!!.getHMACData(Constant.MerchantId, hmacRequest)
        call.enqueue(object : Callback<HMACResponse?> {
            override fun onResponse(call: Call<HMACResponse?>, response: Response<HMACResponse?>) {
                print("#####Generate Session Token")
                response.body()?.hmac?.let { tokenApiCall(it) }
            }

            override fun onFailure(call: Call<HMACResponse?>, t: Throwable) {
                //Error Response from hmacApiCall
                print("#####onFailure")
            }
        })
    }

    private fun getHmacRequest(): HMACRequest? {
        val jsonData = getHMACString()
        val gson = Gson()
        return gson.fromJson(jsonData, HMACRequest::class.java)
    }

    private fun tokenApiCall(hMac: String) {
        val encHMACRequest = EncHMACRequest()
        encHMACRequest.encryptData = getHMACString()?.let { getEncryptDataReq(it) }
        val call: Call<TokenResponse> =
            apiService!!.getTokenResponse(hMac, Constant.MerchantId, encHMACRequest)
        call.enqueue(object : Callback<TokenResponse?> {

            override fun onResponse(
                call: Call<TokenResponse?>,
                response: Response<TokenResponse?>
            ) {
                sessionToken = response.body()?.response!!.sessionTokenId
                fdPaymentSDK = FDPaymentSDK(sessionToken, Constant.PageId, activity)
                fdPaymentSDK!!.initSDK()
            }

            override fun onFailure(call: Call<TokenResponse?>, t: Throwable) {
                print("#####onFailure tokenApiCall")
            }
        })
    }

    private fun getHMACString(): String? {
        var jsonData =
            "{\"customerDetails\":{\"billingAddress\":{\"city\":\"Mumbai\",\"country\":\"India\",\"state\":\"Maharashtra\",\"stree2\":\"Sai Nagar\",\"street1\":\"Ghodbandar Rode\",\"zipcode\":400000},\"customerId\":\"ABC123\",\"emailId\":\"prashanth@gmail.com\",\"hostedIds\":[\"KRS1220ESFFTR8490\"],\"mobileNo\":1234567890,\"name\":{\"firstName\":\"ABC\",\"lastName\":\"XYZ\",\"middleName\":\"DEF\",\"suffix\":\"ADX\"},\"shippingAddress\":{\"city\":\"Mumbai\",\"country\":\"India\",\"state\":\"Maharashtra\",\"stree2\":\"Sai nagar\",\"street1\":\"Ghodbandar Rode\",\"zipcode\":4000000}},\"productData\":{\"discountPrice\":0,\"price\":1,\"productDescription\":\"Water Bottle\",\"productId\":\"P123\",\"quantity\":1,\"shippingFee\":20,\"txnAmount\":120},\"resultURL\":\"https://test.fdconnect.com/FirstPayL2Services/merchantSuccessPage.jsp\",\"transactionDetails\":{\"amount\":\"1\",\"clientTransactionId\":"
        jsonData = "$jsonData\"$randomkey\","
        jsonData = "$jsonData\"currencyCode\":\"INR\",\"transactionType\":\"sale\"}}"
        return jsonData
    }

    private fun getEncryptDataReq(jsonData: String): String? {


        // String cipherText = aesEncrypt(jsonData, "mjgpueRomVg1b31C4ZgErmFxznlc/DBP6+hv8sbU6+g=", "JCuPw0RB3uY5tvXHTQp4vQ==") ;
        return aesEncrypt(
            jsonData,
            "CNy+HimxmI4PmrJWrpLarBfbo6jIY/CHcezg2VQ8u5o=",
            "9T4hd3Nx0b0sMgYuyWLCTg=="
        )
    }

    private fun aesEncrypt(jsonData: String, secretKey: String, ivValue: String): String? {
        try {
            val ivEncoded = Base64.decode(ivValue, Base64.DEFAULT)
            val encoded = Base64.decode(secretKey, Base64.DEFAULT)
            val iv = IvParameterSpec(ivEncoded)
            val secretKeySpec = SecretKeySpec(encoded, "AES")
            val cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING")
            cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, iv)
            val encrypted = cipher.doFinal(jsonData.toByteArray())
            return Base64.encodeToString(encrypted, Base64.DEFAULT).replace("\n", "")
        } catch (ex: Exception) {
            ex.printStackTrace()
        }
        return null
    }

}


