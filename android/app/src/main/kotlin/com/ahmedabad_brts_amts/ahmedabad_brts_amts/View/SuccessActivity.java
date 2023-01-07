package com.ahmedabad_brts_amts.ahmedabad_brts_amts.View;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.ahmedabad_brts_amts.ahmedabad_brts_amts.R;

public class SuccessActivity extends AppCompatActivity {
    private TextView paymentstatus;
    private TextView checkout;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_success);

        checkout        = findViewById(R.id.checkout);
        paymentstatus   = findViewById(R.id.paymentstatus);

        Intent intent = getIntent();
        String value = intent.getStringExtra("key");
        paymentstatus.setText(value);

        String payMessage = "";
        if(paymentstatus!=null) {

            paymentstatus.setText(value);
        }

        checkout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent myIntent = new Intent(SuccessActivity.this, MainActivity.class);
                SuccessActivity.this.startActivity(myIntent);
                finish();
            }
        });
    }
}
