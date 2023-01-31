class UserModel {
  final String id;
  final String name;
  final String email;
  final String pass;
  final String number;
  final String pic;
  final String lon;
  final String lat;
  final String add;
  final String city;
  final String count;
  final String status;
  final String create;
  final String log;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.pass,
    required this.number,
    required this.pic,
    required this.lon,
    required this.lat,
    required this.add,
    required this.city,
    required this.count,
    required this.status,
    required this.create,
    required this.log,
  });

  factory UserModel.fromJson(json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      number: json['number'],
      pass: json['password'],
      pic: json['pic'],
      lon: json['lon'],
      lat: json['lat'],
      add: json['address'],
      city: json['city'],
      count: json['country'],
      status: json['status'],
      create: json['create_date'],
      log: json['last_log'],
    );
  }
}
