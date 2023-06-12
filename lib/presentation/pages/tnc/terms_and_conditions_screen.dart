import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground2,
      body: SafeArea(
        child: Column(
          children: [
            CustomToolbar(
              title: "tnc",
              showOption: false,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Privacy & Payment Policy ',
                        style: satoshiRegular.copyWith(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      SizedBox(height: 35.sp),
                      // Section 1: Introduction
                      mainTitle(
                        'Terms & Conditions: ',
                      ),
                      SizedBox(height: 28.sp),
                      withoutBulletPoint(
                          'Internet is an amazing tool. It has the power to change the way we live, and we’re starting to see that potential today. With only a few mouse-clicks, you can follow the news, look up facts, buy goods and services, and communicate with others from around the world. It’s important to AMC to help our citizens retain their privacy when they take advantage of all the Internet has to offer.'),
                      SizedBox(height: 25.sp),
                      withoutBulletPoint(
                          'We believe your business is no one else’s. Your privacy is important to you…. And to us. So we’ll protect the information you share with us. To protect your privacy, AMC follows different principles in accordance with world- wide practices for customer privacy and data protection. '),

                      SizedBox(height: 8.sp),
                      bulletPoint(
                          'AMC will not be responsible for any claims, losses, damages and actions that user may Initiate in relation to the online Payment Gateway. '),
                      bulletPoint(
                          'The information provided during the online transaction will only be used for online ticketing. We will take all precautions to ensure that Information is not disclosed to any third parties. '),
                      bulletPoint(
                          'AMC shall ensure all steps to maintain secrecy and confidentiality of its users but shall not be liable in case of any damages whatsoever caused on account of breach of security/confidentiality due to reason beyond the control of AMC. '),
                      bulletPoint(
                          'AMC will be in no way held responsible or liable for delay, failure and or untimely delivery of payment confirmation due to but not limited to network congestions, network failure, systems failure or any others reasons beyond the reasonable control of AMC or its service provider. '),
                      bulletPoint(
                          'AMC has the absolute discretion to amend or supplement any of the Terms of Service (Terms & Conditions) at any time, without prior notice. '),
                      bulletPoint(
                          'All disputes shall be subject to the jurisdiction of Ahmedabad and shall be governed by the laws in India. '),
                      SizedBox(height: 16.sp),
                      // Section 3: Security
                      mainTitle(
                        'Security',
                      ),
                      SizedBox(height: 8.sp),
                      withoutBulletPoint(
                          'AMC has taken strong measures to protect the security of your personal information and to ensure that your choices for its intended use are honoured. We take strong precautions to protect your data from loss, misuse, unauthorized access or disclosure, alteration, or destruction. We guarantee your e-commerce transactions to be 100% safe and secure. When you place orders or access your personal account information are encrypted, before it’s sent over the Internet. Your personal information is never shared outside the AMC without your permission, except under conditions explained above. Inside AMC, data is stored in password- controlled servers with limited access. You also have a significant role in protecting your information. No one can see or edit your personal Information without knowing your user name and password, so do not share these with others. '),

                      SizedBox(height: 16.sp),
                      // Section 4: Enforcement
                      mainTitle(
                        'Enforcement',
                      ),
                      SizedBox(height: 8.sp),
                      withoutBulletPoint(
                          'If for some reason you believe AMC has not adhered to these principles, please notify us by e-mail at “EMAIL ADDRESS”, and we will do our best to determine and correct the problem promptly. Be certain the words Privacy Policy are in the Subject line. '),
                      SizedBox(height: 16.sp),
                      // Section 5: Data Privacy Policy
                      mainTitle(
                        'Data Privacy Policy',
                      ),
                      SizedBox(height: 8.sp),
                      withoutBulletPoint(
                          'Our data privacy policy strictly conforms as per the regulations set down in accordance to the protection of data collected from people visiting our website. AMC treats all personal data obtained via internet and our website carefully and confidentially so that no physical/mental harm is instilled up on the person, with regard to the collected data. Personal data that has possibly been known to us will be kept secret, privacy will be respected and information will be used exclusively for the purpose for which it was made known to us. Without seeking approval of the respective person, this data will neither be made accessible to third parties, nor transferred to them in any form or manner.'),
                      SizedBox(height: 16.sp),
                      // Section 6: General Obligations
                      mainTitle(
                        'General Obligations',
                      ),
                      SizedBox(height: 8.sp),
                      withoutBulletPoint(
                          'You shall access AMC Payment Portal web site only for lawful purposes and you shall be responsible for complying with all applicable laws, statutes and regulations in connection with the use of AMC web site. This Website is for your personal and non-commercial use. You shall not modify, copy, distribute, transmit, display, perform, reproduce, publish, license, create derivative works from, transfer or sell any information, or services obtained from this Website. You shall not create a hypertext link to the Website or ‘frame’ the Website, except with the express advance written permission of the AMC.'),
                       SizedBox(height: 16.sp),
                      // Section 7: Cancellation/Refund Policy
                      mainTitle('Cancellation/Refund Policy'),
                      SizedBox(height: 8.sp),
                      bulletPoint(
                          'AMC will not be responsible for any claims, losses, damages and actions that user may Initiate in relation to the online Payment Gateway. '),
                      bulletPoint(
                          'The information provided during the online transaction will only be used for online ticketing. We will take all precautions to ensure that information is not disclosed to any third parties. '),
                      bulletPoint(
                          'After the online payment, a reference number will be generated. Please note the reference number and quote in any queries about the payment.'),
                      bulletPoint(
                          'In case the transactions fail at Payment Gateway, AMC will not be responsible for such transactions. '),
                      bulletPoint(
                          'In case transaction succeeds at Payment Gateway but the ticket is not generated because AMC didn’t receive the transaction as successful from Payment Gateway, Refund would be initiated subsequent to the reconciliation process. '),
                      bulletPoint(
                          'In case of refund, the time take for credit depends and bank and varies from bank to bank and AMC has no control over it. '),
                      bulletPoint(
                          'Users will be responsible for entering correct station details for Which ticket amount is to be paid. '),
                      bulletPoint(
                          'AMC will not be liable in case of incorrect station details are entered by passenger and wrong ticket is generated by Mobile App/Website. '),
                      bulletPoint(
                          'AMC will not be responsible in case of wrong email address entered by passenger or the ticket is not received on email because of mail server issues. '),
                      bulletPoint(
                          'During maintenance activity or in case of any system issues, if the app or website is not available for ticketing, AMC will not be liable in case of such failures. '),
                      bulletPoint(
                          'Notwithstanding anything contained herein, where AMC has reason to believe that any transaction, have been fraudulently made (hereinafter referred to as a “suspect Transaction”), AMC shall be entitled to reject such transactions.'),
                      SizedBox(height: 28.sp),
                      withoutBulletPoint('By Default, all failure Transactions are automatically refunded as per the standard policy. However, for the same to reflect in your account it may take specific time as per the standard policy. Generally, refunds will be reflected within a standard number of Days in Case of Net Banking/Debit Card Transaction &a standard number of Days (Next Billing Cycle) for Credit Card Transactions. In case of excess payment, the amount will be settled as per the rules of the respective departmental services. '),

                      SizedBox(height: 16.sp),
                      // Section 8: Complaints Procedure
                      mainTitle(
                        'Complaints Procedure',
                      ),
                      SizedBox(height: 8.sp),
                      withoutBulletPoint(
                          'You can reach us on the contact details given in the ‘Contacts’ link given in the login page. '),
                      SizedBox(height: 28.sp),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget bulletPoint(String text) {
  return Padding(
    padding:  EdgeInsets.symmetric(vertical: 10.sp),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: satoshiRegular.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.black),
        ),
        SizedBox(width: 5.sp,),
        Expanded(
          child: Text(
            text,
            style: satoshiRegular.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
        ),
      ],
    ),
  );
}

Widget withoutBulletPoint(String text) {
  return Padding(
    padding:  EdgeInsets.symmetric(horizontal: 8.sp),
    child: Text(
      text,
      style: satoshiRegular.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black),
    ),
  );
}

Widget mainTitle(String title) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.sp),
    child: Text( 
      title,
      style: satoshiRegular.copyWith(
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.lightBlue),
    ),
  );
}
