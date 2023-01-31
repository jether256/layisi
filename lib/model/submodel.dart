class SubCatModel {
  final String id;
  final String catid;
  final String subcat;


  SubCatModel({
    required this.id,
    required this.catid,
    required this.subcat,
  });

  // factory  SubCatModel.fromJson(json) {
  //   return  SubCatModel(
  //     id: json['id'],
  //     catid: json['cat_id'],
  //     subcat: json['subcat'],
  //   );
  // }



  factory SubCatModel.fromJson( data) {
    return SubCatModel(
      id: data['id'],
      catid: data['cat_id'],
      subcat:data['subcat'],
    );
  }

}
