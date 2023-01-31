class Address {
  final int id;
  final String adres;


  Address({required this.id, required this.adres, title});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      adres: json['address'],

    );
  }
}