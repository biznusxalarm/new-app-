import 'package:intl/intl.dart';

class PriceFormatter {
  PriceFormatter._();

  static final NumberFormat _currency =
      NumberFormat.currency(locale: 'en_IN', symbol: '₹');

  static String format(num value) => _currency.format(value);
}
