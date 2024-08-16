class AvailableDateModel {
  final String date;

  AvailableDateModel({required this.date});

  factory AvailableDateModel.fromJson(Map<String, dynamic> json) {
    return AvailableDateModel(date: json['date']);
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
    };
  }

  factory AvailableDateModel.fromMap(Map<String, dynamic> map) {
    return AvailableDateModel(date: map['date']);
  }
}
