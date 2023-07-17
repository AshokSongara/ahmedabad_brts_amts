import 'package:flutter/material.dart';

class TransactionResponseScreen extends StatefulWidget {
  String? tId;
  String? tAmount;
  String? tDT;
  String? merchantTId;
  String? payMethod;
  String? status;
   TransactionResponseScreen({Key? key, this.tId,this.tAmount,this.tDT,this.merchantTId,this.payMethod,this.status }) : super(key: key);

  @override
  State<TransactionResponseScreen> createState() => _TransactionResponseScreenState();
}

class _TransactionResponseScreenState extends State<TransactionResponseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Response'),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDataRow('Transaction\nStatus', widget.status ?? ""),
            _buildDataRow('Transaction\nID', widget.tId ?? ""),
            _buildDataRow('Transaction\nAmount', widget.tAmount ?? ""),
            _buildDataRow('Transaction\nDate & Time', widget.tDT ?? ""),
            _buildDataRow('Merchant\nTransaction ID', widget.merchantTId ?? ""),
            _buildDataRow('Payment Method', widget.payMethod ?? ""),
            SizedBox(height: 25,),
            Center(
              child: Text(
                " Note: Please don't press back button",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.red,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String title, String data) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: 25,),
          Expanded(
            flex: 3,
            child: Text(
              data,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
