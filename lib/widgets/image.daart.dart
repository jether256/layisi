import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:galleryimage/galleryimage.dart';

import 'package:http/http.dart' as http;
import 'package:layisi/shared/sharedpref.dart';

class ImagePicke extends StatefulWidget {


  static const  String id='register';

  const ImagePicke({Key? key}) : super(key: key);

  @override
  _ImagePickeState createState() => _ImagePickeState();
}

class _ImagePickeState extends State<ImagePicke> {
  String id1 = "";



  @override
  void initState() {
    // TODO: implement initState
    super.initState(); // this must always be first
    imageFromGallery();

    showGallery();

    Future id = SharedPreference().getUserId();
    id.then((data) async {
      id1 = data;
      print(id1);
    });
  }

  List<String> urList=[];


  bool visibleLoading=false;
  bool _uploading=false;

  late File _image=File('');
  late File _image1=File('');
  late File _image2=File('');
  late File _image3=File('');
  late File _image4=File('');

  final picker = ImagePicker();







  late List<String> gal = [];
  Future showGallery() async {
    var response = await http.post(
        Uri.parse("https://manjether.000webhostapp.com/layisi/vehi.php"),
        headers: {"Accept": "headers/json"},body:{'id':'$id1'});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      setState(() {
        gal = jsonData;
      });
      print(jsonData);
      return jsonData;
    }
  }


  Future imageFromGallery()async {

    var imageFromGall = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (imageFromGall != null) {
        _image = File(imageFromGall.path);
        print("this is from gallery");
      } else {
        print("no image selected");
      }
    });
  }


  Future imageFromGallery1()async {

    var imageFromGall = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (imageFromGall != null) {
        _image1 = File(imageFromGall.path);
        print("this is from gallery");
      } else {
        print("no image selected");
      }
    });
  }



  Future imageFromGallery2()async {

    var imageFromGall = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (imageFromGall != null) {
        _image2 = File(imageFromGall.path);
        print("this is from gallery");
      } else {
        print("no image selected");
      }
    });
  }



  Future imageFromGallery3()async {

    var imageFromGall = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (imageFromGall != null) {
        _image3 = File(imageFromGall.path);
        print("this is from gallery");
      } else {
        print("no image selected");
      }
    });
  }



  Future imageFromGallery4()async {

    var imageFromGall = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (imageFromGall != null) {
        _image4 = File(imageFromGall.path);
        print("this is from gallery");
      } else {
        print("no image selected");
      }
    });
  }

  late String own;


  Future postPhoto() async {
    EasyLoading.show(status: 'Saving...');

    var request=http.MultipartRequest('Post',Uri.parse('https://manjether.000webhostapp.com/layisi/post.php'));
    request.fields['user_id']='$id1';

    var photo = await http.MultipartFile.fromPath('image', _image.path);
    request.files.add(photo);

    var photo1 = await http.MultipartFile.fromPath('image1', _image1.path);
    request.files.add(photo1);

    var photo2 = await http.MultipartFile.fromPath('image2', _image2.path);
    request.files.add(photo2);

    var photo3 = await http.MultipartFile.fromPath('image3', _image3.path);
    request.files.add(photo3);

    var photo4 = await http.MultipartFile.fromPath('image4', _image4.path);
    request.files.add(photo4);

    var response=await request.send();

    if(response.statusCode==200){

      EasyLoading.showSuccess('Image  Uploaded');

    }else{

      EasyLoading.showError('Image Upload failed..');

    }

  }




  @override
  Widget build(BuildContext context) {

    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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

                  //fist image
                  Column(
                    children: [
                      Stack(
                        children: [

                          //first image
                          if(_image.path!='')
                            Positioned(
                              right: 0,
                              child:IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: (){
                                  setState(() {
                                    _image == null;
                                  });

                                },
                              ),
                            ),
                          Container(
                            height: 120,
                            width:MediaQuery.of(context).size.width,
                            child: FittedBox(
                              child: _image.path == '' ?
                              Icon(
                                CupertinoIcons.photo_on_rectangle,
                                color: Colors.grey,
                              ): Image.file(_image),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20,),

                    ],
                  ),

                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: NeumorphicButton(
                          //onPressed:getImage,
                          onPressed: (){
                            imageFromGallery();

                          },

                          style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                          child:Text(
                            'upload image',textAlign: TextAlign.center,style: TextStyle(color:Colors.white),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  if(_uploading)
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    ),

                  //second image
                  Column(
                    children: [
                      Stack(
                        children: [

                          //first image
                          if(_image1.path!='')
                            Positioned(
                              right: 0,
                              child:IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: (){
                                  setState(() {
                                    _image1 == null;
                                  });

                                },
                              ),
                            ),
                          Container(
                            height: 120,
                            width:MediaQuery.of(context).size.width,
                            child: FittedBox(
                              child: _image1.path == '' ?
                              Icon(
                                CupertinoIcons.photo_on_rectangle,
                                color: Colors.grey,
                              ): Image.file(_image1),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20,),

                    ],
                  ),

                  SizedBox(height: 20,),
                  Row(
                    children: [

                      Expanded(
                        child: NeumorphicButton(
                          //onPressed:getImage,
                          onPressed: (){
                            imageFromGallery1();

                          },

                          style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                          child:Text(
                            'upload image',textAlign: TextAlign.center,style: TextStyle(color:Colors.white),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  if(_uploading)
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    ),

                  //third image
                  Column(
                    children: [
                      Stack(
                        children: [

                          //first image
                          if(_image2.path!='')
                            Positioned(
                              right: 0,
                              child:IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: (){
                                  setState(() {
                                    _image2 == null;
                                  });

                                },
                              ),
                            ),
                          Container(
                            height: 120,
                            width:MediaQuery.of(context).size.width,
                            child: FittedBox(
                              child: _image2.path == '' ?
                              Icon(
                                CupertinoIcons.photo_on_rectangle,
                                color: Colors.grey,
                              ): Image.file(_image2),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),


                    ],
                  ),

                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: NeumorphicButton(
                          //onPressed:getImage,
                          onPressed: (){
                            imageFromGallery2();

                          },

                          style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                          child:Text(
                            'upload image',textAlign: TextAlign.center,style: TextStyle(color:Colors.white),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  if(_uploading)
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    ),

                  //fourth image
                  Column(
                    children: [
                      Stack(
                        children: [

                          //first image
                          if(_image3.path!='')
                            Positioned(
                              right: 0,
                              child:IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: (){
                                  setState(() {
                                    _image3 == null;
                                  });

                                },
                              ),
                            ),
                          Container(
                            height: 120,
                            width:MediaQuery.of(context).size.width,
                            child: FittedBox(
                              child: _image3.path == '' ?
                              Icon(
                                CupertinoIcons.photo_on_rectangle,
                                color: Colors.grey,
                              ): Image.file(_image3),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),


                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: NeumorphicButton(
                          //onPressed:getImage,
                          onPressed: (){
                            imageFromGallery3();

                          },

                          style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                          child:Text(
                            'upload image',textAlign: TextAlign.center,style: TextStyle(color:Colors.white),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  if(_uploading)
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    ),

                  //fifth image
                  Column(
                    children: [
                      Stack(
                        children: [

                          //first image
                          if(_image4.path!='')
                            Positioned(
                              right: 0,
                              child:IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: (){
                                  setState(() {
                                    _image4 == null;
                                  });

                                },
                              ),
                            ),
                          Container(
                            height: 120,
                            width:MediaQuery.of(context).size.width,
                            child: FittedBox(
                              child: _image4.path == '' ?
                              Icon(
                                CupertinoIcons.photo_on_rectangle,
                                color: Colors.grey,
                              ): Image.file(_image4),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),

                      if(_image.path!='' && _image1.path!='' && _image2.path!='' && _image3.path !='' && _image4.path !='')
                        Row(
                          children: [
                            Expanded(
                              child: NeumorphicButton(
                                style: NeumorphicStyle(
                                  color: Colors.green,
                                ),
                                onPressed:(){
                                  setState(() {
                                    _uploading=true;
                                    postPhoto().then((url){
                                      setState(() {
                                        _uploading=false;
                                      });

                                    });
                                  });
                                },
                                child: Text('Save',textAlign: TextAlign.center,),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Expanded(
                              child: NeumorphicButton(
                                style: NeumorphicStyle(
                                  color: Colors.red,
                                ),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel',textAlign: TextAlign.center,),
                              ),
                            ),

                          ],
                        ),

                      SizedBox(height: 20,),



                    ],
                  ),


                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: NeumorphicButton(
                          //onPressed:getImage,
                          onPressed: (){
                            imageFromGallery4();

                          },

                          style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                          child:Text(
                            'upload image',textAlign: TextAlign.center,style: TextStyle(color:Colors.white),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  if(_uploading)
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    )
                ],

              ),
            ),
          ],
        ),
      ),
    );

  }









}



