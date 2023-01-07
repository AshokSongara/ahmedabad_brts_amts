package com.ahmedabad_brts_amts.ahmedabad_brts_amts.Model.Response;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class TokenResponse {
    @SerializedName("response")
    @Expose
    public Response response;

    public static class Response{
        @SerializedName("sessionTokenId")
        @Expose
        public String sessionTokenId;
    }
}
