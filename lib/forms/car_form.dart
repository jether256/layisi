

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:galleryimage/galleryimage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:layisi/pref/pref.dart';
import 'package:layisi/provider/auth.dart';
import 'package:layisi/screens/addd.dart';
import 'package:layisi/screens/mainscreen.adrt.dart';


import 'dart:convert';



import 'dart:io';

import 'package:layisi/shared/sharedpref.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SellerCarForm extends StatefulWidget {

  final id;
  final title;

  SellerCarForm({required this.title, this.id});

  //static const  String id='seller-car';

  @override
  State<SellerCarForm> createState() => _SellerCarFormState();
}

class _SellerCarFormState extends State<SellerCarForm> {
  final _fomKey=GlobalKey<FormState>();

  final _brandController=TextEditingController();
  final _yearController=TextEditingController();
  final _priceController=TextEditingController();
  final _fuelController=TextEditingController();
  final _transController=TextEditingController();
  final _kmController=TextEditingController();
  final _ownerController=TextEditingController();
  final _titleController=TextEditingController();
  final _descController=TextEditingController();
  final  _addressController=TextEditingController();
  final _adController=TextEditingController();

  bool visibleLoading=false;
  bool _uploading=false;

  late File _image=File('');
  late File _image1=File('');
  late File _image2=File('');
  late File _image3=File('');
  late File _image4=File('');

  final picker = ImagePicker();


  String id1 = "";
  String name1 = "";
  String  phone1 = "";

  String _location='';
  String _address='';







  @override
  void initState() {
    super.initState();

    //showAdu();
    showCarModels();

    getPref();
    getLoc();


    showAdu().then((value){

      setState(() {
        _addressController.text=adu as String;
      });
    });


  }









  validate(AuthProvider authData){

    if(_fomKey.currentState!.validate()){

          setState(() {
            _uploading=true;
            saveCarData(authData).then((url){ setState(() {
              _uploading=false;
            });

            });
          });

     // Navigator.pushNamed(context,UserReviewScreen.id);


    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content:Text('Please complete the required fields'),),
      );
    }

  }



  late Future  futureAlbum;



  ///lists
  List<String> urList=[];


  final List<String> _fuelList=['Diesel','Petrol','Electric','LPG'];
  final List<String> _translList=['Manual','Automatic'];
  final List<String> _noOfOwners=['1','2nd','3rd','4th','4+'];

  final List<String> _ads=[
    'Standard Ad Free',
    '7 Days Offer Shs 5000',
    '30 Days Offer Shs 15000',
    '3 Months Offer Shs 40000',
    '6 Months Offer Shs 78000',
    '1 Year Offer Shs 1000000',
    'Boost Offer 33000'

  ];




  Future saveCarData(AuthProvider authData) async{

   EasyLoading.show(status: 'Saving...');


    var request=http.MultipartRequest('Post',Uri.parse('https://layisikla.000webhostapp.com/api/postcar.php'));
    request.fields['user_id']='$userID';
    request.fields['name']='$name';
    request.fields['phone']='$num';
   request.fields['category']=widget.id;


    var photo = await http.MultipartFile.fromPath('image',_image.path);
    request.files.add(photo);

    var photo1 = await http.MultipartFile.fromPath('image1',_image1.path);
    request.files.add(photo1);

    var photo2 = await http.MultipartFile.fromPath('image2',_image2.path);
    request.files.add(photo2);

    var photo3 = await http.MultipartFile.fromPath('image3',_image3.path);
    request.files.add(photo3);

    var photo4 = await http.MultipartFile.fromPath('image4',_image4.path);
    request.files.add(photo4);

    request.fields['brand']=_brandController.text;
    request.fields['year']=_yearController.text;
    request.fields['price']=_priceController.text;
    request.fields['fuel']=_fuelController.text;
    request.fields['trans']=_transController.text;
    request.fields['km']=_kmController.text;
    request.fields['owners']=_ownerController.text;
    request.fields['title']=_titleController.text;
    request.fields['crip']=_descController.text;
    request.fields['adu']=_addressController.text;
    request.fields['ad']=_adController.text;
    request.fields['lon']='${authData.shopLongitude}';
    request.fields['lat']='${authData.shopLatitude}';

    var response=await request.send();

    if(response.statusCode==200){

      EasyLoading.showSuccess('Car Data saved');

    }else{

      EasyLoading.showError('Failed to save');
    }


  }




  ///pick images from Gallery
  ///start pick//
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

  ///end pick from gallery





  //
  //
  // late List<String> gal = [];
  // Future showGallery() async {
  //   var response = await http.post(
  //       Uri.parse("https://manjether.000webhostapp.com/layisi/vehi.php"),
  //       headers: {"Accept": "headers/json"},body:{'id':'$id1'});
  //   if (response.statusCode == 200) {
  //     var jsonData = json.decode(response.body);
  //
  //     setState(() {
  //       gal = jsonData;
  //     });
  //     print(jsonData);
  //     return jsonData;
  //   }
  // }





///car model api
  late List carModels=[];
  Future showCarModels() async{

    var response = await http.get(Uri.parse("https://layisikla.000webhostapp.com/api/cars.php"),headers:{"Accept":"headers/json"});
    if(response.statusCode ==200){
      var jsonData=json.decode(response.body);

      setState((){
        carModels=jsonData;

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

  String? loke;
  getLoc() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    loke = sharedPreferences.getString(PrefInfo.ID);

    String? loco=sharedPreferences.getString('location');
    String? ade=sharedPreferences.getString('address');
    setState(() {
      _location=loco!;
      _address=ade!;
    });
  }

  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(PrefInfo.ID);
    sharedPreferences.remove(PrefInfo.name);
    sharedPreferences.remove(PrefInfo.email);
    sharedPreferences.remove(PrefInfo.num);
    sharedPreferences.remove(PrefInfo.pass);
    sharedPreferences.remove(PrefInfo.pic);
    sharedPreferences.remove(PrefInfo.lon);
    sharedPreferences.remove(PrefInfo.lat);
    sharedPreferences.remove(PrefInfo.ad);
    sharedPreferences.remove(PrefInfo.city);
    sharedPreferences.remove(PrefInfo.country);
    sharedPreferences.remove(PrefInfo.status);

    sharedPreferences.remove(PrefInfo.log);
    sharedPreferences.remove(PrefInfo.create);


    Navigator.pushReplacementNamed(context,MainScreen.id);


  }



  ///show address

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
  List _addList =[];
  Future fetchAdd() async {
    var response = await http.post(
        Uri.parse("https://layisikla.000webhostapp.com/api/loc.php"),
        headers: {"Accept": "headers/json"},body:{'id':'$userID'});

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values =[];
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            _addList.add(Add.fromJson(map));
            debugPrint('${map['address']}');
          }
        }
      }
      return _addList;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }





  @override
  Widget build(BuildContext context) {

    final _authData = Provider.of<AuthProvider>(context);

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

    Widget _brandlist(){

          return  Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,

                children: [
                  //going to use it so many times lets create our own app bar
                  _appBar('Cars','brands'),

                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount:carModels.length ,
                        itemBuilder:(context,index){

                          return ListTile(
                            onTap: (){

                              setState(() {
                                _brandController.text=carModels[index]['model'];
                              });
                              Navigator.pop(context);

                            },
                            title: Text(carModels[index]['model'],style:const TextStyle(fontSize:15,color: Colors.black),),
                          );


                        }),
                  ),


                ],
                ),
          );
        }

        Widget _add(){

          return  Dialog(

              child: Column(
                mainAxisSize: MainAxisSize.max,
              children: [
              //going to use it so many times lets create our own app bar
              _appBar('Cars','Address'),

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



        Widget _listview({fieldValue,list,textController}){

      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _appBar('Cars',fieldValue),
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
                mainAxisAlignment:MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CAR',style: TextStyle(fontWeight: FontWeight.bold),),
                  InkWell(
                    onTap: (){

                      //lets show the list of cars instead of manually typing
                      showDialog(context: context,builder: (BuildContext context){

                        return _brandlist();
                      });
                    },
                    child: TextFormField(
                      controller: _brandController,

                      enabled: false,//enter manually now

                      decoration:const InputDecoration(
                        labelText: 'Brand/Model/Variant *'
                      ),

                      validator: (value){

                        if(value!.isEmpty){
                          return 'Please complete required field';
                        }
                        return null;
                      },

                    ),
                  ),

                  TextFormField(
                    controller: _yearController,
                    keyboardType: TextInputType.number,
                    decoration:const InputDecoration(
                        labelText: 'Year'
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

                  InkWell(
                    onTap: (){

                     showDialog(context: context, builder:(BuildContext context){
                       return _listview(fieldValue: 'Fuel',list: _fuelList,textController: _fuelController);

                     });

                    },
                    child: TextFormField(
                      enabled: false,
                      controller: _fuelController,

                      decoration:const InputDecoration(
                          labelText: 'Fuel'
                      ),

                      validator: (value){

                        if(value!.isEmpty){
                          return 'Please complete required field';
                        }
                        return null;
                      },

                    ),
                  ),

                  InkWell(
                    onTap: (){

                      showDialog(context: context, builder:(BuildContext context){
                        return _listview(fieldValue: 'Transmission',list: _translList,textController: _transController);

                      });

                    },
                    child: TextFormField(
                      enabled: false,
                      controller: _transController,
                      decoration:const InputDecoration(
                          labelText: 'Transmission'
                      ),

                      validator: (value){

                        if(value!.isEmpty){
                          return 'Please complete required field';
                        }
                        return null;
                      },

                    ),
                  ),

                  TextFormField(
                    autofocus: false,
                    controller: _kmController,
                    keyboardType: TextInputType.number,
                    decoration:const InputDecoration(
                      labelText: 'Km Driven',


                    ),

                    validator: (value){

                      if(value!.isEmpty){
                        return 'Please complete required field';
                      }
                      return null;
                    },

                  ),

                  InkWell(
                    onTap: (){

                      showDialog(context: context, builder:(BuildContext context){
                        return _listview(fieldValue: 'No of Owners',list: _noOfOwners,textController: _ownerController);

                      });

                    },
                    child: TextFormField(
                      enabled: false,
                      controller: _ownerController,
                      decoration:const InputDecoration(
                          labelText: 'No of Owners'
                      ),

                      validator: (value){

                        if(value!.isEmpty){
                          return 'Please complete required field';
                        }
                        return null;
                      },

                    ),
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

                      if(value.length<10){
                        return 'Need atleast 10 characters';
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

                  const SizedBox(height: 10,),
                  const Divider(color: Colors.grey,),




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

                  InkWell(
                    onTap: (){

                      showDialog(context: context, builder:(BuildContext context){
                        return _listview(fieldValue: 'Ad Options',list: _ads,textController: _adController);

                      });

                    },
                    child: TextFormField(
                      enabled: false,
                      controller: _adController,

                      decoration:const InputDecoration(
                          labelText: 'Ads Optons'
                      ),

                      validator: (value){

                        if(value!.isEmpty){
                          return 'Please complete required field';
                        }
                        return null;
                      },

                    ),
                  ),




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

                  const Divider(color: Colors.grey,),

                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey.shade300,
                  //     borderRadius: BorderRadius.circular(4),
                  //   ),
                  //   child: FutureBuilder(
                  //
                  //     future:showGallery(),
                  //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  //       return ListView.builder(
                  //           shrinkWrap: true,
                  //           scrollDirection: Axis.horizontal,
                  //           physics: BouncingScrollPhysics(),
                  //           itemCount:gal.length ,
                  //           itemBuilder:(context,index){
                  //
                  //             return gal.length==0 ? Text('No images',textAlign: TextAlign.center,): GalleryImage(
                  //               imageUrls:gal,
                  //             );
                  //           });
                  //     },
                  //   ),
                  //
                  // ),

                  const SizedBox(height: 10,),

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

                  const SizedBox(height: 80,),

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

