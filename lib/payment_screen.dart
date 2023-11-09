import 'package:flutter/material.dart';
import 'package:flutter_upi/flutter_upi.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPI Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                initiateUpiPayment();
              },
              child: Text('Pay using UPI'),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {

                launchGooglePay();
              },
              child: Image.asset('images/google-pay-logo.png', width: 100, height: 100),
            ),
          ],
        ),
      ),
    );
  }

  void initiateUpiPayment() async {
    UpiTransactionResponse? transactionResponse = await FlutterUpi.initiateTransaction(
      amount: '1.00',
      merchantCode: 'your_merchant_code',
      transactionRef: 'unique_transaction_id',
      transactionNote: 'Payment for Something',
      receiverName: 'Receiver Name',
      receiverUpiAddress: 'receiver@upi',
    );

    if (transactionResponse != null && transactionResponse.status == 'success') {
      // Payment was successful
      // Handle the success scenario here
    } else {
      // Payment failed or was canceled
      // Handle the failure scenario here
    }
  }

  void launchGooglePay() async {
    final googlePayUrl = 'https://pay.google.com/gp/v/gpc/your_upi'; 

    if (await canLaunch(googlePayUrl)) {
      await launch(googlePayUrl);
    } else {
      // Handle the case where Google Pay app cannot be launched
    }
  }
}

