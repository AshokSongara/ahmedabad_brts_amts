package com.ahmedabad_brts_amts.ahmedabad_brts_amts.Model.Response;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class HMACResponse {
    @SerializedName("hmac")
    @Expose
    public String hmac;
}
