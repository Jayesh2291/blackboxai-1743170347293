import 'package:stripe_payment/stripe_payment.dart';

class PaymentService {
  static void init() {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: "pk_test_your_publishable_key",
        merchantId: "Test",
        androidPayMode: 'test',
      ),
    );
  }

  static Future<PaymentMethod> createPaymentMethod(
    String cardNumber, 
    int expMonth, 
    int expYear, 
    String cvc
  ) async {
    return await StripePayment.createPaymentMethod(
      PaymentMethodRequest(
        card: PaymentMethodCard(
          number: cardNumber,
          expMonth: expMonth,
          expYear: expYear,
          cvc: cvc,
        ),
      ),
    );
  }

  static Future<PaymentIntentResult> confirmPayment(
    String paymentMethodId, 
    int amount,
    String currency
  ) async {
    return await StripePayment.confirmPaymentIntent(
      PaymentIntent(
        clientSecret: 'your_client_secret',
        paymentMethodId: paymentMethodId,
        amount: amount,
        currency: currency,
      ),
    );
  }
}