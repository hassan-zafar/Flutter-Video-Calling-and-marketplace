// import 'dart:convert';

// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:stripe_payment/stripe_payment.dart';

// class StripeTransactionResponse {
//   String message;
//   bool success;
//   StripeTransactionResponse({required this.message, required this.success});
// }

// class StripeService {
//   static String apiBase = 'https://api.stripe.com/v1';
//   static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
//   static Uri paymentApiUri = Uri.parse(paymentApiUrl);
//   static String secret = 'sk_test_8GTwLzJSVp3pESPT5v9digto008HoEGzhC';

//   static Map<String, String> headers = {
//     'Authorization': 'Bearer ${StripeService.secret}',
//     'Content-type': 'application/x-www-form-urlencoded'
//   };

//   static init() {
//     StripePayment.setOptions(StripeOptions(
//         publishableKey: 'pk_test_kzDoJjW1QHf4c043OUs6KTdM00MRm43UQ6',
//         merchantId: 'Test',
//         androidPayMode: 'test'));
//     // StripePayment.setOptions(StripeOptions(
//     //     publishableKey: 'pk_test_kzDoJjW1QHf4c043OUs6KTdM00MRm43UQ6'));
//     // StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest())
//     //     .catchError((e) {
//     //   print('ERROR ${e.toString()}');
//     // }).then((paymentMethod) {
//     //   print(paymentMethod.toString());
//     // });
//   }

//   static Future<Map<String, dynamic>?> createPaymentIntent(
//       String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {"amount": amount, "currency": currency};
//       var response =
//           await http.post(paymentApiUri, headers: headers, body: body);
//       return jsonDecode(response.body);
//     } catch (error) {
//       print('error occured in the payment intent $error ');
//     }
//     return null;
//   }

//   static Future<StripeTransactionResponse> payWithNewCard(
//       {required String amount, required String currency}) async {
//     try {
//       var paymentMethod = await StripePayment.paymentRequestWithCardForm(
//           CardFormPaymentRequest());
//       var paymentIntent =
//           await StripeService.createPaymentIntent(amount, currency);
//       var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
//           clientSecret: paymentIntent!['client_secret'],
//           paymentMethodId: paymentMethod.id));
//       if (response.status == 'succeeded') {
//         return StripeTransactionResponse(
//             message: 'Transaction successful', success: true);
//       } else {
//         return StripeTransactionResponse(
//             message: 'Transaction failed', success: false);
//       }
//     } on PlatformException catch (error) {
//       return StripeService.getPlatformExceptionErrorResult(error);
//     } catch (error) {
//       return StripeTransactionResponse(
//           message: 'Transaction failed : $error', success: false);
//     }
//   }

//   static getPlatformExceptionErrorResult(err) {
//     String message = 'Something went wrong';
//     if (err.code == 'cancelled') {
//       message = 'Transaction cancelled';
//     }

//     return new StripeTransactionResponse(message: message, success: false);
//   }
// }

// // class StripeTransactionResponse {
// //   String? message;
// //   bool? success;
// //   StripeTransactionResponse({this.message, this.success});
// // }

// // class StripeService {
// //   static String apiBase = 'https://api.stripe.com/v1';
// //   static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
// //   static Uri paymentApiUri = Uri.parse(paymentApiUrl);

// //   static String secret =
// //       'sk_test_51HEKkjIEmWkp6b7SkKDMW5Z66ibqf7Lwu09L9e9jydsxf16FNAaDeYncbxjB5M20dfQc46MeO3Rmf2HQZ25WVzw400FuIAF6cR';
// //   static Map<String, String> headers = {
// //     'Authorization': 'Bearer ${StripeService.secret}',
// //     'Content-Type': 'application/x-www-form-urlencoded'
// //   };
// //   static init() {
// //     StripePayment.setOptions(StripeOptions(
// //         publishableKey:
// //             "pk_test_51HEKkjIEmWkp6b7ScGJgzPctYP1DknJpw4c8ikwLRdBiDgZPHkq0GnGsNnSnqNtFlngW1oJftKzopNdMVqmUsaWb00J1DNBegr",
// //         merchantId: "Test",
// //         androidPayMode: 'test'));
// //   }

//   // static Future<StripeTransactionResponse> payViaExistingCard(
//   //     {String amount, String currency, CreditCard card}) async {
//   //   try {
//   //     var paymentMethod = await StripePayment.createPaymentMethod(PaymentMethodRequest(card: card));
//   //     var paymentIntent = await StripeService.createPaymentIntent(amount, currency);
//   //     var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
//   //         clientSecret: paymentIntent['client_secret'], paymentMethodId: paymentMethod.id));
//   //     if (response.status == 'succeeded') {
//   //       return new StripeTransactionResponse(message: 'Transaction successful', success: true);
//   //     } else {
//   //       return new StripeTransactionResponse(message: 'Transaction failed', success: false);
//   //     }
//   //   } on PlatformException catch (err) {
//   //     return StripeService.getPlatformExceptionErrorResult(err);
//   //   } catch (err) {
//   //     return new StripeTransactionResponse(
//   //         message: 'Transaction failed: ${err.toString()}', success: false);
//   //   }
//   // }

// //   static Future<StripeTransactionResponse> payWithNewCard(
// //       {required String amount, required String currency}) async {
// //     try {
// //       var paymentMethod = await StripePayment.paymentRequestWithCardForm(
// //           CardFormPaymentRequest());
// //       var paymentIntent =
// //           await StripeService.createPaymentIntent(amount, currency);
// //       var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
// //           clientSecret: paymentIntent!['client_secret'],
// //           paymentMethodId: paymentMethod.id));
// //       if (response.status == 'succeeded') {
// //         return new StripeTransactionResponse(
// //             message: 'Transaction successful', success: true);
// //       } else {
// //         return new StripeTransactionResponse(
// //             message: 'Transaction failed', success: false);
// //       }
// //     } on PlatformException catch (err) {
// //       return StripeService.getPlatformExceptionErrorResult(err);
// //     } catch (err) {
// //       return new StripeTransactionResponse(
// //           message: 'Transaction failed: ${err.toString()}', success: false);
// //     }
// //   }

// //   static getPlatformExceptionErrorResult(err) {
// //     String message = 'Something went wrong';
// //     if (err.code == 'cancelled') {
// //       message = 'Transaction cancelled';
// //     }

// //     return new StripeTransactionResponse(message: message, success: false);
// //   }

// //   static Future<Map<String, dynamic>?> createPaymentIntent(
// //       String amount, String currency) async {
// //     try {
// //       Map<String, dynamic> body = {
// //         'amount': amount,
// //         'currency': currency,
// //         'payment_method_types[]': 'card'
// //       };
// //       var response = await http.post(StripeService.paymentApiUri,
// //           body: body, headers: StripeService.headers);
// //       return jsonDecode(response.body);
// //     } catch (err) {
// //       print('err charging user: ${err.toString()}');
// //     }
// //     return null;
// //   }
// // }


// // import 'dart:convert';

// // import 'package:flutter/services.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:stripe_payment/stripe_payment.dart';
