class User{
  int? id;
  String name;
  String email;
  String phone;
  String password;
  User({this.id , required this.name , required this.email , required this.phone , required this.password});

  // Chuyển user thành map
  Map<String , dynamic> toMap(){
    return {
      'id' : id,
      'name' : name,
      'email': email,
      'phone' : phone,
      'password':password,
    };
  }
  // Tạo user từ map
  factory User.fromMap(Map<String , dynamic> map){
    return User(
        id:map['id'],
        name: map['name'],
        email: map['email'],
        phone: map['phone'],
        password: map['password'],
    );
  }
}