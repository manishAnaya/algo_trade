import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static final _inrFull = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );
  static final _inrWhole = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );
  static final _pct = NumberFormat('+0.00;-0.00');

  /// ₹1,23,456.78
  static String full(double v) => _inrFull.format(v);

  /// ₹1,23,456
  static String whole(double v) => _inrWhole.format(v);

  /// Compact: ₹12.5L, ₹1.2Cr, ₹45K
  static String compact(double v) {
    final abs = v.abs();
    final sign = v < 0 ? '-' : '';
    if (abs >= 1e7) return '$sign₹${(abs / 1e7).toStringAsFixed(2)}Cr';
    if (abs >= 1e5) return '$sign₹${(abs / 1e5).toStringAsFixed(2)}L';
    if (abs >= 1e3) return '$sign₹${(abs / 1e3).toStringAsFixed(1)}K';
    return '$sign₹${abs.toStringAsFixed(0)}';
  }

  /// +12.34% or -5.67%
  static String percent(double v) => '${_pct.format(v)}%';

  /// +₹1,234.56 or -₹567.89
  static String signed(double v) => '${v >= 0 ? '+' : ''}${full(v)}';
}
