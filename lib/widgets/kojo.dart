

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';




class Londa extends StatefulWidget {


  static const  String id='register';

  const Londa({Key? key}) : super(key: key);

  @override
  _LondaState createState() => _LondaState();
}

class _LondaState extends State<Londa> {

  late File _image = File('');

  final picker = ImagePicker();




  @override
  Widget build(BuildContext context) {

    return Dialog(
      child: Column(
        children: [
          AppBar(
            elevation: 1,
            backgroundColor:Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text('Upload images',style: TextStyle(color: Colors.black),),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  height: 120,
                  width:MediaQuery.of(context).size.width,
                  child: FittedBox(
                    child:_image == null ? Icon(
                      CupertinoIcons.photo_on_rectangle,
                      color: Colors.grey,
                    ): Image.file(_image),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: NeumorphicButton(
                        //onPressed:getImage,
                          onPressed: (){
                            imageFromGallery();
                            Navigator.pop(context);
                          },

                          style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                          child:Text('upload image',textAlign: TextAlign.center,style: TextStyle(color:Colors.white),)
                      ),
                    ),
                  ],
                )
              ],

            ),
          ),
        ],
      ),
    );

  }

  imageFromGallery()async{
    var imageFromGall = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(imageFromGall != null){
        _image = File(imageFromGall.path);
        print("this is from gallery");
      }else{
        print("image form gallery dont have any data");
      }
    });
  }


}
