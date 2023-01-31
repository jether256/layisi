import 'package:flutter/material.dart';

class ImagesProvider with ChangeNotifier{

  late String Image;
  late String Image1;
  late String Image2;
  late String Image3;
  late String Image4;




  getselectedImagess(image,image1,image2,
      image3,image4){
    Image=image;
    Image1=image1;
    Image2=image2;
    Image3=image3;
    Image4=image4;

    notifyListeners();
  }
}