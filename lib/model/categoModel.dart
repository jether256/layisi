
class CategoryModel {
  final String ID;
 final  String title;
  final String imagee;
 final  String status;
 final  String time;

  CategoryModel({
     required this.ID,
     required this.title,
     required this.imagee,
     required this.status,
    required this.time,
  });

  factory CategoryModel.fromJson(data) {
    return CategoryModel(
      ID: data['ID'],
      title: data['title'],
      imagee: data['imagee'],
      status: data['status'],
      time: data['time'],
    );
  }





}
