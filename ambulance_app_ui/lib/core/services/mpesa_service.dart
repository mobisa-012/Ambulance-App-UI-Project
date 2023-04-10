import 'dart:convert';

import 'package:http/http.dart' as http;

class MpesaService {
  static const String consumerKey = 'PDGOKqUZnxrrOj903SVafCQmarS7QHwJ';
  static const String consumerSecret = 'Z7JnnQfVCw51Tuqn';
  static const String baseUrl = 'https://sandbox.safaricom.co.ke';
  static const String oauthEndpoint =
      '/oauth/v1/generate?grant_type=client_credentials';
  static const String paymentEndpoint = '/mpesa/stkpush/v1/processrequest';

  static Future generateAccessToke() async {
    String credentials =
        base64.encode(utf8.encode('$consumerKey:$consumerSecret'));
    var response = await http.post('$baseUrl$oauthEndpoint' as Uri,
        headers: {'Authorization': 'Basic $credentials'});
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['access_token'];
    }
    return null;
  }

  static Future initiatePayment(
      String phone, String amount, String description) async {
    String accessToken = await generateAccessToke();
    var response = await http.post('$baseUrl$paymentEndpoint' as Uri,
        headers: {'Authorization': 'Bearer $accessToken'},
        body: json.encode({
          'BusinessShortCode': 'your_business_short_code',
          'Password': 'your-password',
          'Timestamp': 'your-timestamp',
          'TransactionType': 'CustomerPayBillOnline',
          'Amount': amount,
          'PartyA': phone,
          'PartyB': 'your-business-short-code',
          'PhoneNumber': phone,
          'CallBackURL': 'your-callback-url',
          'AccountReference': 'your-account-reference',
          'TransactionDesc': description
        }));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['CheckoutRequestID'];
    }
    return null;
  }
}
