class BookingModel {
  final int id;
  final String date;
  final String email;
  final String contact;

  BookingModel({required this.id, required this.date, required this.email, required this.contact});

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['_id'],
      date: json['date'],
      email: json['email'],
      contact: json['phonenumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'email': email,
      'contact': contact,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'],
      date: map['date'],
      email: map['email'],
      contact: map['contact'],
    );
  }
}
