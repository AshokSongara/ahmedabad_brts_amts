package com.ahmedabad_brts_amts.Model.Request;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.List;

public class HMACRequest {
    @SerializedName("customerDetails")
    @Expose
    public CustomerDetails customerDetails;
    @SerializedName("productData")
    @Expose
    public ProductData productData;
    @SerializedName("resultURL")
    @Expose
    public String resultURL;
    @SerializedName("transactionDetails")
    @Expose
    public TransactionDetails transactionDetails;

    public static class CustomerDetails{
        @SerializedName("billingAddress")
        @Expose
        public BillingAddress billingAddress;
        @SerializedName("customerId")
        @Expose
        public String customerId;
        @SerializedName("emailId")
        @Expose
        public String emailId;
        @SerializedName("hostedIds")
        @Expose
        public List<String> hostedIds = null;
        @SerializedName("mobileNo")
        @Expose
        public Integer mobileNo;
        @SerializedName("name")
        @Expose
        public Name name;
        @SerializedName("shippingAddress")
        @Expose
        public ShippingAddress shippingAddress;
    }

    public static class ProductData{
        @SerializedName("discountPrice")
        @Expose
        public Integer discountPrice;
        @SerializedName("price")
        @Expose
        public Integer price;
        @SerializedName("productDescription")
        @Expose
        public String productDescription;
        @SerializedName("productId")
        @Expose
        public String productId;
        @SerializedName("quantity")
        @Expose
        public Integer quantity;
        @SerializedName("shippingFee")
        @Expose
        public Integer shippingFee;
        @SerializedName("txnAmount")
        @Expose
        public Integer txnAmount;
    }

    public static class TransactionDetails{
        @SerializedName("amount")
        @Expose
        public String amount;
        @SerializedName("clientTransactionId")
        @Expose
        public String clientTransactionId;
        @SerializedName("currencyCode")
        @Expose
        public String currencyCode;
        @SerializedName("transactionType")
        @Expose
        public String transactionType;
    }

    public static class BillingAddress{
        @SerializedName("city")
        @Expose
        public String city;
        @SerializedName("country")
        @Expose
        public String country;
        @SerializedName("state")
        @Expose
        public String state;
        @SerializedName("stree2")
        @Expose
        public String stree2;
        @SerializedName("street1")
        @Expose
        public String street1;
        @SerializedName("zipcode")
        @Expose
        public Integer zipcode;
    }

    public static class Name{
        @SerializedName("firstName")
        @Expose
        public String firstName;
        @SerializedName("lastName")
        @Expose
        public String lastName;
        @SerializedName("middleName")
        @Expose
        public String middleName;
        @SerializedName("suffix")
        @Expose
        public String suffix;
    }

    public static class ShippingAddress{
        @SerializedName("city")
        @Expose
        public String city;
        @SerializedName("country")
        @Expose
        public String country;
        @SerializedName("state")
        @Expose
        public String state;
        @SerializedName("stree2")
        @Expose
        public String stree2;
        @SerializedName("street1")
        @Expose
        public String street1;
        @SerializedName("zipcode")
        @Expose
        public Integer zipcode;
    }

}
