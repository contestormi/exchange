class Rates {
  bool? success;
  int? timestamp;
  String? base;
  String? date;
  Map<String, dynamic>? rates;

  Rates({this.success, this.timestamp, this.base, this.date, this.rates});

  Rates.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    timestamp = json['timestamp'];
    base = json['base'];
    date = json['date'];
    rates =
        json['rates'] != null ? json['rates'] as Map<String, dynamic> : null;
  }
}
