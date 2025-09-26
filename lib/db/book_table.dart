class Booking{
  int? id;
  String name;
  String phone;
  String soBan;
  String bookingdate;
  String bookingtime;

  Booking({ this.id,required this.name, required this.phone , required this.soBan , required this.bookingdate , required this.bookingtime});
// Chuyển đối tượng Booking thành map
  Map<String , dynamic> toMap(){
    return {
      'id ' : id,
      'name' : name,
      'phone' : phone,
      'soBan' : soBan,
      'bookingdate' : bookingdate,
      'bookingtime' : bookingtime,
    };
  }
// Chuyển đối tượng Booking từ Map
  factory Booking.fromMap(Map<String , dynamic> map){
    return Booking(
        id: map['id'],
        name: map['name'],
        phone: map['phone'],
        soBan: map['soBan'],
        bookingdate: map['bookingdate'],
        bookingtime: map['bookingtime']);
  }

  Booking copyWith({
    int? id,
    String? name,
    String? phone,
    String? soBan,
    String? bookingdate,
    String? bookingtime,
  }) {
    return Booking(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      soBan: soBan ?? this.soBan,
      bookingdate: bookingdate ?? this.bookingdate,
      bookingtime: bookingtime ?? this.bookingtime,
    );
  }
}