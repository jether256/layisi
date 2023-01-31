class Add {

  final String id;
 final String name;
 final String email;
final  String number;
 final String password;
final  String pic;
final  String address;
final  String city;
final  String country;
 final String status;


  Add({required this.id,
    required this.name,
    required this.email,
    required this.number,
    required this.password,
    required this.pic,
    required this.address,
    required this.city,
    required this.country,
    required this.status,
  });

  factory Add.fromJson(Map<String, dynamic> json) => Add(
      id: json['id'],
      name: json['name'].toString(),
      email: json['email'].toString(),
      number: json['number'].toString(),
      password: json['password'].toString(),
      pic: json['pic'].toString(),
      address: json['address'].toString(),
      city: json['city'].toString(),
      country: json['country'].toString(),
      status: json['status'].toString(),
    );


  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email":email,
    "number":number,
    "password":password,
    "address":address,
    "city":city,
    "country":country,
    "status":status,
  };

  }