import 'package:http/http.dart' as http;
import 'package:policesystem/cashier/cashier_model/cashier_model.dart';

Future<List<Payment>> fetchPayment() async {
  Uri url = Uri.parse("http://127.0.0.1:8000/api/payments");

  final response = await http.get(url);
  return PaymentFromJson(response.body);
}
