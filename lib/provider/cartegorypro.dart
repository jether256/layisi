import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CategoryProvider with ChangeNotifier{

  late String ID;
  late String Title;
  late String Status;
  late String Pic;

  selectedCategory(id,title,status,pic){
    ID=id;
    Title=title;
    Status=status;
    Pic=pic;
    notifyListeners();
  }

}