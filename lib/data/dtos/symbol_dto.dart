class Symbols {
  bool? success;
  Map<String, dynamic>? symbols;

  Symbols({this.success, this.symbols});

  Symbols.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    symbols = json['symbols'] != null
        ? json['symbols'] as Map<String, dynamic>
        : null;
  }
}
