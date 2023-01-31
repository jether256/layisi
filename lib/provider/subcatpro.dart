import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SubProvider with ChangeNotifier{
  late String iD;
  late String Cat_id;
  late String Sub;

  selectedSub(id,cat_id,sub){
    iD=id;
    Cat_id=cat_id;
    Sub=sub;
    notifyListeners();
  }


}