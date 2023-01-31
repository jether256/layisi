import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'package:layisi/pref/pref.dart';
import 'package:layisi/provider/auth.dart';
import 'dart:convert';
import 'dart:io';

import 'package:layisi/shared/sharedpref.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'class.dart';


class FormScreen extends StatefulWidget {
  final String subID;
  final  String catID;
  final String subTitle;

  FormScreen({required this.subID, required this.catID, required this.subTitle});
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {


  @override
  void initState() {
    super.initState();

    showPhoneModels();
    showAdu();
    getPref();




  }
  final _fomKey=GlobalKey<FormState>();


  bool visibleLoading=false;
  bool _uploading=false;

  late File _image=File('');
  late File _image1=File('');
  late File _image2=File('');
  late File _image3=File('');
  late File _image4=File('');

  List accessories=[
    'Mobile',
    'Tablets'
  ];

  List tabType=[
    'Ipads',
    'Samsung',
    'other types'
  ];

  List apartmentType=[
    'Apartments',
    'Farm Houses',
    'Houses and Villas'
  ];

  List fun=[
    'Furnished',
    'Semi-furnished',
    'Unfurnished'
  ];

  List con=[
    'New Launch',
    'Ready to Move',
    'Under Construction'
  ];


  List number=[
    '1',
    '2',
    '3',
    '4',
    '4+'
  ];

  final List<String> _ads=[
    'Standard Ad Free',
    '7 Days Offer Shs 5000',
    '30 Days Offer Shs 15000',
    '3 Months Offer Shs 40000',
    '6 Months Offer Shs 78000',
    '1 Year Offer Shs 1',
    'Boost Offer 33000'

  ];



  final picker = ImagePicker();


  final _brandText=TextEditingController();
  final _typeText=TextEditingController();
  final _titleController=TextEditingController();
  final _descController=TextEditingController();
  final _priceController=TextEditingController();
  final _bedrooms=TextEditingController();
  final _bathrooms=TextEditingController();
  final _fun=TextEditingController();
  final _sqft=TextEditingController();
  final _carpet=TextEditingController();
  final _floors=TextEditingController();
  final _con=TextEditingController();
  final  _addressController=TextEditingController();
  final _adController=TextEditingController();

  final FormClass _formClass=new FormClass();


  // final List<String> _ads=[
  //   'Standard Ad Free',
  //   '7 Days Offer Shs 5000',
  //   '30 Days Offer Shs 15000',
  //   '3 Months Offer Shs 40000',
  //   '6 Months Offer Shs 78000',
  //   '1 Year Offer Shs 1',
  //   'Boost Offer 33000'
  //
  // ];



    validate(AuthProvider authData){

    if(_fomKey.currentState!.validate()){


      //phones
      if(_brandText.text!='' && _priceController.text !=''
          && _titleController.text!='' && _descController.text!=''
          && _addressController.text!=''  && _adController.text!=''){

                setState(() {
                  _uploading=true;
                  saveOtherData1(authData).then((url){ setState(() {
                    _uploading=false;
                  });

                  });
                  });

      }

      //phones accessories & tablets
     else if( _typeText.text!='' &&  _priceController.text !=''
          && _titleController.text!='' && _descController.text!=''
          && _addressController.text!=''   && _adController.text!=''){

        setState(() {
          _uploading=true;
          saveOtherData2(authData).then((url){ setState(() {
            _uploading=false;
          });

          });
        });

      }

      //houses rent
      else if (       _bedrooms.text!='' && _bathrooms.text!='' && _fun.text!='' && _con.text!='' &&
      _sqft.text!='' && _carpet.text!='' && _floors.text!=''
      && _priceController.text !=''
      && _titleController.text!='' && _descController.text!=''
      && _addressController.text!=''  && _adController.text!=''){

        setState(() {
          _uploading=true;
          saveOtherData3(authData).then((url){ setState(() {
            _uploading=false;
          });

          });
        });

      }

      //houses sell
      else if (   _typeText.text!='' &&    _bedrooms.text!='' && _bathrooms.text!='' && _fun.text!='' && _con.text!='' &&
          _sqft.text!='' && _carpet.text!='' && _floors.text!=''
          && _priceController.text !=''
          && _titleController.text!='' && _descController.text!=''
          && _addressController.text!=''  && _adController.text!=''){

        setState(() {
          _uploading=true;
          saveOtherData4(authData).then((url){ setState(() {
            _uploading=false;
          });

          });
        });

      }

      //others
      else if (
          _priceController.text !=''
          && _titleController.text!='' && _descController.text!=''
          && _addressController.text!=''  && _adController.text!=''){

        setState(() {
          _uploading=true;
          saveOtherData5(authData).then((url){ setState(() {
            _uploading=false;
          });

          });
        });

      }





    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content:Text('Please complete the required fields'),),
      );
    }

  }


  ///rest of the services
  Future saveOtherData5(AuthProvider authData) async{
    EasyLoading.show(status: 'Saving...');

    var request=http.MultipartRequest('Post',Uri.parse('https://layisikla.000webhostapp.com/api/postrest.php'));
    request.fields['user_id']='$userID';
    request.fields['name']='$name';
    request.fields['phone']='$num';

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


    request.fields['category']=widget.catID;
    request.fields['subcategory']=widget.subID;
    request.fields['price']=_priceController.text;
    request.fields['title']=_titleController.text;
    request.fields['crip']=_descController.text;
    request.fields['adu']=_addressController.text;
    request.fields['lon']='${authData.shopLongitude}';
    request.fields['lat']='${authData.shopLatitude}';
    request.fields['ad']=_adController.text;

    var response=await request.send();

    if(response.statusCode==200){

      EasyLoading.showSuccess('Data Uploaded');

    }else{

      EasyLoading.showError('Data Failed to upload..');
    }


  }


  ///sell house or building
  Future saveOtherData4(AuthProvider authData) async{
    EasyLoading.show(status: 'Saving...');
    var request=http.MultipartRequest('Post',Uri.parse('https://layisikla.000webhostapp.com/api/sellhouse.php'));
    request.fields['user_id']='$userID';
    request.fields['name']='$name';
    request.fields['phone']='$num';


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

    // request.fields['brand']=_brandText.text;
    request.fields['type']=_typeText.text;
    request.fields['category']=widget.catID;
    request.fields['subcategory']=widget.subID;
    request.fields['price']=_priceController.text;
    request.fields['title']=_titleController.text;
    request.fields['bedrooms']=_bedrooms.text;
    request.fields['bathrooms']=_bathrooms.text;
    request.fields['fun']=_fun.text;
    request.fields['con']=_con.text;
    request.fields['sqft']=_sqft.text;
    request.fields['carpet']=_carpet.text;
    request.fields['floors']=_floors.text;
    request.fields['crip']=_descController.text;
    request.fields['adu']=_addressController.text;
    request.fields['lon']='${authData.shopLongitude}';
    request.fields['lat']='${authData.shopLatitude}';
    request.fields['ad']=_adController.text;

    var response=await request.send();

    if(response.statusCode==200){

      EasyLoading.showSuccess('Data Uploaded');

    }else{


      EasyLoading.showError('Data Failed to upload..');

    }


  }

  ///rent house
  Future saveOtherData3(AuthProvider authData) async{
    EasyLoading.show(status: 'Saving...');
    var request=http.MultipartRequest('Post',Uri.parse('https://layisikla.000webhostapp.com/api/renthouse.php'));
    request.fields['user_id']='$userID';
    request.fields['name']='$name';
    request.fields['phone']='$num';


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

    // request.fields['brand']=_brandText.text;
    //request.fields['type']=_typeText.text;
    request.fields['category']=widget.catID;
    request.fields['subcategory']=widget.subID;
    request.fields['price']=_priceController.text;
    request.fields['title']=_titleController.text;
    request.fields['bedrooms']=_bedrooms.text;
    request.fields['bathrooms']=_bathrooms.text;
    request.fields['fun']=_fun.text;
    request.fields['con']=_con.text;
    request.fields['sqft']=_sqft.text;
    request.fields['carpet']=_carpet.text;
    request.fields['floors']=_floors.text;
    request.fields['crip']=_descController.text;
    request.fields['adu']=_addressController.text;
    request.fields['lon']='${authData.shopLongitude}';
    request.fields['lat']='${authData.shopLatitude}';
    request.fields['ad']=_adController.text;

    var response=await request.send();

    if(response.statusCode==200){

      EasyLoading.showSuccess('Data Uploaded');

    }else{


      EasyLoading.showError('Data Failed to upload..');

    }


  }


  ///tablets,accesories
  Future saveOtherData2(AuthProvider authData) async{
    EasyLoading.show(status: 'Saving...');
    var request=http.MultipartRequest('Post',Uri.parse('https://layisikla.000webhostapp.com/api/posttabac.php'));
    request.fields['user_id']='$userID';
    request.fields['name']='$name';
    request.fields['phone']='$num';

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


    request.fields['type']=_typeText.text;
    request.fields['category']=widget.catID;
    request.fields['subcategory']=widget.subID;
    request.fields['price']=_priceController.text;
    request.fields['title']=_titleController.text;
    request.fields['crip']=_descController.text;
    request.fields['adu']=_addressController.text;
    request.fields['lon']='${authData.shopLongitude}';
    request.fields['lat']='${authData.shopLatitude}';
    request.fields['ad']=_adController.text;

    var response=await request.send();

    if(response.statusCode==200){

      EasyLoading.showSuccess('Data Uploaded');

    }else{

      EasyLoading.showError('Data Failed to upload..');

    }


  }



///phones
  Future saveOtherData1(AuthProvider authData) async{
    EasyLoading.show(status: 'Saving...');
    var request=http.MultipartRequest('Post',Uri.parse('https://layisikla.000webhostapp.com/api/postphone.php'));
    request.fields['user_id']='$userID';
    request.fields['name']='$name';
    request.fields['phone']='$num';

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

    request.fields['brand']=_brandText.text;
    request.fields['category']=widget.catID;
    request.fields['subcategory']=widget.subID;
    request.fields['price']=_priceController.text;
    request.fields['title']=_titleController.text;
    request.fields['crip']=_descController.text;
    request.fields['adu']=_addressController.text;
    request.fields['lon']='${authData.shopLongitude}';
    request.fields['lat']='${authData.shopLatitude}';
    request.fields['ad']=_adController.text;

    var response=await request.send();

    if(response.statusCode==200){


      EasyLoading.showSuccess('Data Uploaded');

    }else{


      EasyLoading.showError('Data Failed to upload..');
    }


  }

  // Future saveOtherData() async{
  //   EasyLoading.show(status: 'Saving...');
  //   var request=http.MultipartRequest('Post',Uri.parse('https://manjether.000webhostapp.com/layisi/post2.php'));
  //   request.fields['user_id']='$userID';
  //   request.fields['name']='$name';
  //   request.fields['phone']='$num';
  //
  //
  //   var photo = await http.MultipartFile.fromPath('image', _image.path);
  //   request.files.add(photo);
  //
  //   var photo1 = await http.MultipartFile.fromPath('image1', _image1.path);
  //   request.files.add(photo1);
  //
  //   var photo2 = await http.MultipartFile.fromPath('image2', _image2.path);
  //   request.files.add(photo2);
  //
  //   var photo3 = await http.MultipartFile.fromPath('image3', _image3.path);
  //   request.files.add(photo3);
  //
  //   var photo4 = await http.MultipartFile.fromPath('image4', _image4.path);
  //   request.files.add(photo4);
  //
  //   request.fields['brand']=_brandText.text;
  //   request.fields['type']=_typeText.text;
  //   request.fields['category']=widget.catID;
  //   request.fields['subcategory']=widget.subID;
  //   request.fields['price']=_priceController.text;
  //   request.fields['title']=_titleController.text;
  //   request.fields['bedrooms']=_bedrooms.text;
  //   request.fields['bathrooms']=_bathrooms.text;
  //   request.fields['fun']=_fun.text;
  //   request.fields['con']=_con.text;
  //   request.fields['sqft']=_sqft.text;
  //   request.fields['carpet']=_carpet.text;
  //   request.fields['floors']=_floors.text;
  //   request.fields['crip']=_descController.text;
  //   request.fields['adu']=_addressController.text;
  //   request.fields['lon']='${authData.shopLongitude}';
  //   request.fields['lat']='${authData.shopLatitude}';
  //
  //   var response=await request.send();
  //
  //   if(response.statusCode==200){
  //
  //
  //     EasyLoading.showSuccess('Data Uploaded');
  //
  //   }else{
  //
  //     EasyLoading.showError('Data Failed to upload..');
  //
  //   }
  //
  //
  // }

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



  late List adu = [];
  Future showAdu() async {
    var response = await http.post(
        Uri.parse("https://layisikla.000webhostapp.com/api/loc.php"),
        headers: {"Accept": "headers/json"},body:{'id':'$userID'});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      setState(() {
        adu = jsonData;
      });
      print(jsonData);
      return jsonData;
    }
  }



  late List phoneModels=[];

  Future showPhoneModels() async{

    var response = await http.get(Uri.parse("https://layisikla.000webhostapp.com/api/phonebrand.php"),headers:{"Accept":"headers/json"});
    if(response.statusCode ==200){
      var jsonData=json.decode(response.body);

      setState((){
        phoneModels=jsonData;

      });
      print(jsonData);
      return jsonData;

    }

  }


  ///preferences
  String? userID,name,email,num, pass, pic,lon, lat,ad, city,country,status,log,create;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      userID = sharedPreferences.getString(PrefInfo.ID);
      name = sharedPreferences.getString(PrefInfo.name);
      email = sharedPreferences.getString(PrefInfo.email);
      num = sharedPreferences.getString(PrefInfo.num);
      pass = sharedPreferences.getString(PrefInfo.pass);
      pic = sharedPreferences.getString(PrefInfo.pic);
      lon = sharedPreferences.getString(PrefInfo.lon);
      lat = sharedPreferences.getString(PrefInfo.lat);
      ad = sharedPreferences.getString(PrefInfo.ad);
      city = sharedPreferences.getString(PrefInfo.city);
      country = sharedPreferences.getString(PrefInfo.country);
      status = sharedPreferences.getString(PrefInfo.status);

      log = sharedPreferences.getString(PrefInfo.log);
      create = sharedPreferences.getString(PrefInfo.create);
    });
  }





  @override
  Widget build(BuildContext context) {


    Widget _add(){

      return  Dialog(

        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            //going to use it so many times lets create our own app bar
            _formClass.appBar(subID:widget.subID,catID:widget.catID,subTitle:widget.subTitle),
            FutureBuilder(
              future:showAdu(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount:adu.length ,
                    itemBuilder:(context,index){

                      return ListTile(
                        onTap: (){

                          setState(() {
                            _addressController.text=adu[index]['address'];
                          });
                          Navigator.pop(context);

                        },
                        title: Text(adu[index]['address'],style:const TextStyle(fontSize:15,color: Colors.black),),
                      );


                    });
              },
            ),
          ],

        ),
      );


    }


    Widget _appBar(title,fieldValue){

      return  AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
        automaticallyImplyLeading: false,
        title: Text('$title>$fieldValue',style: const TextStyle(color: Colors.black,fontSize: 14),),
      );
    }


    Widget _listview({fieldValue,list,textController}){

      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          iconTheme: const IconThemeData(color: Colors.white),
          shape: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
          automaticallyImplyLeading: false,
          title: Text('Ads Options $fieldValue',style: const TextStyle(color: Colors.white,fontSize: 14),),
        ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder:(BuildContext context, int index){
                  return ListTile(
                    onTap: (){
                      textController.text=list[index];
                      Navigator.pop(context);
                    },


                    title: Text(list[index]),

                  );
                })
          ],
        ),
      );
    }



    //api/phonebrand.php

    showFormDialog(phoneModels,_textController){
      return showDialog(context: context, builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            _formClass.appBar(subID:widget.subID,catID:widget.catID,subTitle:widget.subTitle),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount:phoneModels.length ,
                    itemBuilder:(BuildContext context,int index){

                  return ListTile(
                    onTap: (){
                      setState(() {
                        _textController.text=phoneModels[index]['name'];
                      });
                      Navigator.pop(context);

                    },
                      title:Text(phoneModels[index]['name']),
                  );

                }),
              ),

            ],
          ),
        );
      });
    }


    showAcModels(accessories,_textController){
      return showDialog(context: context, builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _formClass.appBar(subID:widget.subID,catID:widget.catID,subTitle:widget.subTitle),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount:accessories.length ,
                  itemBuilder:(BuildContext context,int index){

                    return ListTile(
                      onTap: (){
                        setState(() {
                          _textController.text=accessories[index];
                        });
                        Navigator.pop(context);

                      },
                      title:Text(accessories[index]),
                    );

                  }),

            ],
          ),
        );
      });
    }


    showTabModels(tabType,_textController){
      return showDialog(context: context, builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _formClass.appBar(subID:widget.subID,catID:widget.catID,subTitle:widget.subTitle),
              ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount:tabType.length ,
                  itemBuilder:(BuildContext context,int index){

                    return ListTile(
                      onTap: (){
                        setState(() {
                          _textController.text=tabType[index];
                        });
                        Navigator.pop(context);

                      },
                      title:Text(tabType[index]),
                    );

                  }),

            ],
          ),
        );
      });
    }

    showSellApp(apartmentType,_textController){
      return showDialog(context: context, builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _formClass.appBar(subID:widget.subID,catID:widget.catID,subTitle:widget.subTitle),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount:apartmentType.length ,
                  itemBuilder:(BuildContext context,int index){

                    return ListTile(
                      onTap: (){
                        setState(() {
                          _textController.text=apartmentType[index];
                        });
                        Navigator.pop(context);

                      },
                      title:Text(apartmentType[index]),
                    );

                  }),

            ],
          ),
        );
      });
    }

    showNumBeds(number,_textController){
      return showDialog(context: context, builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _formClass.appBar(subID:widget.subID,catID:widget.catID,subTitle:widget.subTitle),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount:number.length ,
                  itemBuilder:(BuildContext context,int index){

                    return ListTile(
                      onTap: (){
                        setState(() {
                          _textController.text=number[index];
                        });
                        Navigator.pop(context);

                      },
                      title:Text(number[index]),
                    );

                  }),

            ],
          ),
        );
      });
    }

    showNumBaths(number,_textController){
      return showDialog(context: context, builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _formClass.appBar(subID:widget.subID,catID:widget.catID,subTitle:widget.subTitle),
              ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount:number.length ,
                  itemBuilder:(BuildContext context,int index){

                    return ListTile(
                      onTap: (){
                        setState(() {
                          _textController.text=number[index];
                        });
                        Navigator.pop(context);

                      },
                      title:Text(number[index]),
                    );

                  }),

            ],
          ),
        );
      });
    }

    showFun(fun,_textController){
      return showDialog(context: context, builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _formClass.appBar(subID:widget.subID,catID:widget.catID,subTitle:widget.subTitle),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount:fun.length ,
                  itemBuilder:(BuildContext context,int index){

                    return ListTile(
                      onTap: (){
                        setState(() {
                          _textController.text=fun[index];
                        });
                        Navigator.pop(context);

                      },
                      title:Text(fun[index]),
                    );

                  }),

            ],
          ),
        );
      });
    }

    showCon(con,_textController){
      return showDialog(context: context, builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _formClass.appBar(subID:widget.subID,catID:widget.catID,subTitle:widget.subTitle),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount:con.length ,
                  itemBuilder:(BuildContext context,int index){

                    return ListTile(
                      onTap: (){
                        setState(() {
                          _textController.text=con[index];
                        });
                        Navigator.pop(context);

                      },
                      title:Text(con[index]),
                    );

                  }),

            ],
          ),
        );
      });
    }

    Widget _myGridView(){

      return Column(
        children: [
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

                        Container(
                          height: 120,
                          width:MediaQuery.of(context).size.width,
                          child: Neumorphic(
                            child: _image.path == '' ?
                            const Icon(
                              CupertinoIcons.photo_on_rectangle,
                              color: Colors.grey,
                            ): Image.file(_image),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20,),

                  ],
                ),

                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: NeumorphicButton(

                        //onPressed:getImage,
                        onPressed: (){
                          imageFromGallery();

                        },

                        style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                        child:const Text(
                          'upload image',textAlign: TextAlign.center,style: TextStyle(color:Colors.white),),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
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

                        Container(
                          height: 120,
                          width:MediaQuery.of(context).size.width,
                          child: Neumorphic(
                            child: _image1.path == '' ?
                            const Icon(
                              CupertinoIcons.photo_on_rectangle,
                              color: Colors.grey,
                            ): Image.file(_image1),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20,),

                  ],
                ),

                const SizedBox(height: 20,),
                Row(
                  children: [

                    Expanded(
                      child: NeumorphicButton(
                        //onPressed:getImage,
                        onPressed: (){
                          imageFromGallery1();

                        },

                        style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                        child:const Text(
                          'upload image',textAlign: TextAlign.center,style: TextStyle(color:Colors.white),),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
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

                        Container(
                          height: 120,
                          width:MediaQuery.of(context).size.width,
                          child: Neumorphic(
                            child: _image2.path == '' ?
                            const Icon(
                              CupertinoIcons.photo_on_rectangle,
                              color: Colors.grey,
                            ): Image.file(_image2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),


                  ],
                ),

                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: NeumorphicButton(
                        //onPressed:getImage,
                        onPressed: (){
                          imageFromGallery2();

                        },

                        style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                        child:const Text(
                          'upload image',textAlign: TextAlign.center,style: TextStyle(color:Colors.white),),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
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

                        Container(
                          height: 120,
                          width:MediaQuery.of(context).size.width,
                          child: Neumorphic(
                            child: _image3.path == '' ?
                            const Icon(
                              CupertinoIcons.photo_on_rectangle,
                              color: Colors.grey,
                            ): Image.file(_image3),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),


                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: NeumorphicButton(
                        //onPressed:getImage,
                        onPressed: (){
                          imageFromGallery3();

                        },

                        style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                        child:const Text(
                          'upload image',textAlign: TextAlign.center,style: TextStyle(color:Colors.white),),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
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


                        Container(
                          height: 120,
                          width:MediaQuery.of(context).size.width,
                          child: Neumorphic(
                            child: _image4.path == '' ?
                            const Icon(
                              CupertinoIcons.photo_on_rectangle,
                              color: Colors.grey,
                            ): Image.file(_image4),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),

                    // if(_image.path!='' && _image1.path!='' && _image2.path!='' && _image3.path !='' && _image4.path !='')
                    //   Row(
                    //     children: [
                    //       Expanded(
                    //         child: NeumorphicButton(
                    //           style: NeumorphicStyle(
                    //             color: Colors.green,
                    //           ),
                    //           onPressed:(){
                    //             setState(() {
                    //               _uploading=true;
                    //               postPhoto().then((url){
                    //                 setState(() {
                    //                   _uploading=false;
                    //                 });
                    //
                    //               });
                    //             });
                    //           },
                    //           child: Text('Save',textAlign: TextAlign.center,),
                    //         ),
                    //       ),
                    //       SizedBox(height: 10,),
                    //       // Expanded(
                    //       //   child: NeumorphicButton(
                    //       //     style: NeumorphicStyle(
                    //       //       color: Colors.red,
                    //       //     ),
                    //       //     onPressed: (){
                    //       //       Navigator.pop(context);
                    //       //     },
                    //       //     child: Text('Cancel',textAlign: TextAlign.center,),
                    //       //   ),
                    //       // ),
                    //
                    //     ],
                    //   ),

                    const SizedBox(height: 20,),



                  ],
                ),


                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: NeumorphicButton(
                        //onPressed:getImage,
                        onPressed: (){
                          imageFromGallery4();

                        },

                        style: NeumorphicStyle(color: Theme.of(context).primaryColor),
                        child:const Text(
                          'upload image',textAlign: TextAlign.center,style: TextStyle(color:Colors.white),),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                if(_uploading)
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  )
              ],

            ),
          ),
        ],

      );    }

    final _authData = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Add some details...',style: TextStyle(color: Colors.white)),
        elevation: 0.0,
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ) ,
      body: SafeArea(
        child: Form(
          key: _fomKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.subTitle,),
                  //should b for mobile only

                  if(widget.subTitle=='Mobile Phone')

                  InkWell(
                    onTap: (){

                      showFormDialog(phoneModels,_brandText);
                    },
                    child: TextFormField(
                      controller: _brandText,
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'Brands',
                      ),
                    ),
                  ),

                  if(widget.subTitle=='Accesories' || widget.subTitle=='Tablets')
                    InkWell(
                      onTap: (){

                        if(widget.subTitle=='Tablets'){
                         showTabModels(tabType,_typeText);
                        }



                        showAcModels(accessories,_typeText);
                      },
                      child: TextFormField(
                        controller: _typeText,
                        enabled: false,
                        decoration: const InputDecoration(
                          labelText: 'Type',
                        ),
                      ),
                    ),



                      if(
                      widget.subTitle=='Sell:House&Buildings')
                  InkWell(
                    onTap: (){

                      if(widget.subTitle=='Sell:House&Buildings'||
                      widget.subTitle=='Rent:House&Buildings'
                      ){
                        showSellApp(apartmentType,_typeText);
                      }

                    },
                    child: TextFormField(
                      controller: _typeText,
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'Type',
                      ),
                    ),
                  ),

                  if(
                  widget.subTitle=='Sell:House&Buildings' ||
                  widget.subTitle=='Rent:House&Buildings')
                  Container(
                    child: Column(
                      children: [

                        InkWell(
                          onTap: (){



                            showNumBeds(number,_bedrooms);
                          },
                          child: TextFormField(
                            controller: _bedrooms,
                            enabled: false,
                            decoration: const InputDecoration(
                              labelText: 'BedRooms',
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){



                            showNumBaths(number,_bathrooms);
                          },
                          child: TextFormField(
                            controller: _bathrooms,
                            enabled: false,
                            decoration: const InputDecoration(
                              labelText: 'BathRooms',
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){



                            showFun(fun,_fun);
                          },
                          child: TextFormField(
                            controller: _fun,
                            enabled: false,
                            decoration: const InputDecoration(
                              labelText: 'Furnishing',
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: (){



                            showCon(con,_con);
                          },
                          child: TextFormField(
                            controller: _con,
                            enabled: false,
                            decoration: const InputDecoration(
                              labelText: 'Construction status',
                            ),
                          ),
                        ),

                        TextFormField(
                          controller: _sqft,

                          decoration: const InputDecoration(
                            labelText: 'Building Sqft',
                          ),
                        ),

                        TextFormField(
                          controller: _carpet,

                          decoration: const InputDecoration(
                            labelText: 'Carpet Sqft',
                          ),
                        ),


                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _floors,

                          decoration: const InputDecoration(
                            labelText: 'Total Floors',
                          ),
                        ),


                      ],
                    ),
                  ),


                  TextFormField(
                    autofocus: false,
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration:const InputDecoration(
                      labelText: 'Price',
                      prefixText:'shs',

                    ),

                    validator: (value){

                      if(value!.isEmpty){
                        return 'Please complete required field';
                      }
                      return null;
                    },

                  ),

                  TextFormField(
                    autofocus: false,
                    controller: _titleController,

                    maxLength: 50,

                    decoration:const InputDecoration(
                        labelText: 'Add title',
                        helperText: 'Mention key features(eg brand,model'


                    ),

                    validator: (value){

                      if(value!.isEmpty){
                        return 'Please complete required field';
                      }


                      return null;
                    },

                  ),

                  TextFormField(
                    autofocus: false,
                    controller: _descController,

                    maxLength: 4000,
                    minLines: 1,
                    maxLines: 30,

                    decoration:const InputDecoration(
                        labelText: 'Description',
                        helperText: 'include condition,features,reason for selling'


                    ),

                    validator: (value){

                      if(value!.isEmpty){
                        return 'Please complete required field';
                      }
                      return null;
                    },

                  ),



                  InkWell(
                    onTap: () {
                      //lets show the list of cars instead of manually typing
                      _authData.getCurrentAddress().then((address) {
                        if (address != null) {
                          setState(() {
                            _addressController.text =
                            //'${_authData.placeName}\n${_authData.shopAdd}';
                            '${_authData.shopAdd}';
                          });
                        } else {
                          EasyLoading.showError('Could not find locatio try again...');
                          return;
                        }
                      });
                    },
                    child: TextFormField(
                      controller: _addressController,
                      maxLines: 4,
                      minLines: 2,
                      enabled: false,
                      //enter manually now

                      decoration: const InputDecoration(
                        labelText: 'Tap to get Address',
                        counterText: 'SellerAddress',
                      ),

                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please complete required field';
                        }
                        return null;
                      },

                    ),
                  ),

                  const SizedBox(height: 10,),


                  InkWell(
                    onTap: (){

                      showDialog(context: context, builder:(BuildContext context){
                        return _listview(fieldValue: 'ADS',list: _ads,textController: _adController);

                      });

                    },
                    child: TextFormField(
                      enabled: false,
                      controller: _adController,

                      decoration:const InputDecoration(
                          labelText: 'Ads Options'
                      ),

                      validator: (value){

                        if(value!.isEmpty){
                          return 'Please complete required field';
                        }
                        return null;
                      },

                    ),
                  ),

                  const SizedBox(height: 10,),





                  //
                  // InkWell(
                  //   onTap: (){
                  //
                  //     //lets show the list of cars instead of manually typing
                  //     showDialog(context: context,builder: (BuildContext context){
                  //
                  //       return _add();
                  //     });
                  //   },
                  //   child: TextFormField(
                  //     controller: _addressController,
                  //     maxLines: 4,
                  //     minLines: 2,
                  //     enabled: false,//enter manually now
                  //
                  //     decoration:const InputDecoration(
                  //       labelText: 'Address',
                  //       counterText: 'SellerAddress',
                  //     ),
                  //
                  //     validator: (value){
                  //
                  //       if(value!.isEmpty){
                  //         return 'Please complete required field';
                  //       }
                  //       return null;
                  //     },
                  //
                  //   ),
                  // ),

                  InkWell(
                    // onTap: (){
                    //   //upload image here
                    //   showDialog(context: context,builder: (BuildContext context){
                    //     return ImagePicke();
                    //
                    //   });
                    //
                    // },
                    child: Neumorphic(
                      child: Container(
                        //height: 40,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.deepOrangeAccent,
                        // child: Center(child: Text(
                        //     gal.length> 0 ? 'Upload more images':   'Upload image'),),

                        child:_myGridView(),
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Row(
        children: [
          if(_image.path!='' && _image1.path!='' && _image2.path!='' && _image3.path !='' && _image4.path !='')
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: NeumorphicButton(
                  style: NeumorphicStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text('Save',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  ),
                  onPressed: (){
                    validate(_authData);

                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
