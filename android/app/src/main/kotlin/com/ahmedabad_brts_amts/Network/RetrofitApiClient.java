package com.ahmedabad_brts_amts.Network;

import okhttp3.OkHttpClient;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class RetrofitApiClient {
   // public static final String BASE_URL = "https://www.test.fdconnect.com/FDConnectL3Services/";
    public static final String BASE_URL = "https://test.fdconnect.com/FirstPayL2Services/";
    private static Retrofit retrofit = null;


    public static Retrofit getClient() {

        OkHttpClient okHttpClient = UnsafeOkHttpClient.getUnsafeOkHttpClient();


        if (retrofit==null) {
            retrofit = new Retrofit.Builder()
                    .baseUrl(BASE_URL)
                    .client(okHttpClient)
                    .addConverterFactory(GsonConverterFactory.create())
                    .build();
        }
        return retrofit;
    }
}