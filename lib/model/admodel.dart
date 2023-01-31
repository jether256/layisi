
class AdvertModel {
  final String ID;
  final  String user_id;
  final String 	category;
  final  String subcategory	;
  final  String image;
  final  String img1;
  final  String img2;
  final  String img3;
  final  String img4;
  final  String random;
  final  String name;
  final  String phone;
  final  String brand;
  final  String type;
  final  String year;
  final  String price;
  final  String fuel;
  final  String trans;
  final  String km;
  final  String owners;
  final  String title;
  final  String bedrooms;
  final  String bathrooms;
  final  String fun;
  final  String con;
  final  String sqft;
  final  String carpet;
  final  String floors;
  final  String crip;
  final  String adu;
  final  String lon;
  final  String lat;
  final  String noti;
  final  String ad;
  final  String date;

  AdvertModel({
    required this.ID,
    required this.user_id,
    required this.category,
    required this.subcategory,
    required this.image,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.img4,
    required this.random,
    required this.name,
    required this.phone,
    required this.brand,
    required this.type,
    required this.year,
    required this.price,
    required this.fuel,
    required this.trans,
    required this.km,
    required this.owners,
    required this.title,
    required this.bedrooms,
    required this.bathrooms,
    required this.fun,
    required this.con,
    required this.sqft,
    required this.carpet,
    required this.floors,
    required this.crip,
    required this.adu,
    required this.lon,
    required this.lat,
    required this.noti,
    required this.ad,
    required this.date,
  });

  factory AdvertModel.fromJson(data) {
    return AdvertModel(
      ID: data['ID'],
      user_id: data['user_id'],
      category: data['category'],
      subcategory: data['subcategory'],
      image: data['image'],
      img1: data['img1'],
      img2: data['img2'],
      img3: data['img3'],
      img4: data['img4'],
      random: data['random'],
      name: data['name'],
      phone: data['phone'],
      brand: data['brand'],
      type: data['type'],
      year: data['year'],
      price: data['price'],
      fuel: data['fuel'],
      trans: data['trans'],
      km: data['km'],
      owners: data['owners'],
      title: data['title'],
      bedrooms: data['bedrooms'],
      bathrooms: data['bathrooms'],
      fun: data['fun'],
      con: data['con'],
      sqft: data['sqft'],
      carpet: data['carpet'],
      floors: data['floors'],
      crip: data['crip'],
      adu: data['adu'],
      lon: data['lon'],
      lat: data['lat'],
      noti: data['noti'],
      ad: data['ad'],
      date: data['date'],
    );
  }





}
