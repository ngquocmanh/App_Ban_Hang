class Booking {
  int? id;
  int? userId;
  final String name;
  final String phone;
  final String soBan;
  final String bookingdate;
  final String bookingtime;

  Booking({
    this.id,
    this.userId,
    required this.name,
    required this.phone,
    required this.soBan,
    required this.bookingdate,
    required this.bookingtime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'phone': phone,
      'soBan': soBan,
      'bookingdate': bookingdate,
      'bookingtime': bookingtime,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      userId: map['userId'],
      name: map['name'],
      phone: map['phone'],
      soBan: map['soBan'],
      bookingdate: map['bookingdate'],
      bookingtime: map['bookingtime'],
    );
  }
}
