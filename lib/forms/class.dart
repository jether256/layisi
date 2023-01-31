import 'package:flutter/material.dart';


class FormClass{

  Widget appBar({required String subTitle, required String catID, required String subID}){
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
      shape: Border(
        bottom: BorderSide(color: Colors.grey.shade300),
      ),
      automaticallyImplyLeading: false,
      title: Text('$subTitle',style: TextStyle(color: Colors.black,fontSize: 14),),
    );
  }
}