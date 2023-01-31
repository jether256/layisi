import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:layisi/crypt/encrypt.dart';
import 'package:layisi/pref/pref.dart';
import 'package:layisi/screens/register.dart';
import 'package:layisi/screenslogged/main_sc.dart';
import 'package:layisi/shared/sharedpref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'location.dart';

class Login extends StatefulWidget {

  static const  String id='login';

  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey=GlobalKey<FormState>();
  final _businessName=TextEditingController();
  final _contNum=TextEditingController();
  final _ema=TextEditingController();
  final _pass=TextEditingController();





  //https://bodayo.000webhostapp.com/api/user/reg.php



  Widget _formField({TextEditingController? controller,String? label,TextInputType? type,
    String? Function(String?)? validator}){
    return TextFormField(

      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        prefixText:controller ==_contNum ?'+256':null,

        contentPadding: const EdgeInsets.only(left: 10),
        filled: true,
        fillColor: Colors.grey.shade300,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4)
        ),
      ),
      validator: validator,



    );
  }



  login() async {
    EasyLoading.show(status: 'Logging In...');

    var response=await http.post(Uri.parse('https://layisikla.000webhostapp.com/api/login.php'),

        body:{"email":encryp(_ema.text),"password":encryp(_pass.text), });



    if(response.statusCode==200){
      var userData=json.decode(response.body);



      String ID=userData['id'];
      String name=userData['name'];
      String email=userData['email'];
      String num=userData['number'];
      String pass=userData['password'];
      String pic=userData['pic'];
      String lon=userData['lon'];
      String lat=userData['lat'];
      String ad=userData['address'];
      String city=userData['city'];
      String country=userData['country'];
      String status=userData['status'];
      String log=userData['last_log'];
      String create=userData['create_date'];


      if(userData=="ERROR"){

        EasyLoading.showError('Login Failed..');


      }else{

        savePref(ID, name, email, num, pass, pic, lon, lat, ad, city, country, status, log, create);



        Navigator.pushReplacementNamed(context,MainScreenLogged.id);



        EasyLoading.showSuccess('Logged In...');

        print(userData);
      }

    }



  }



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

  savePref(
      String ID ,String name,String email, String num,String pass,String pic ,String lon,String lat,
      String ad,String city,String country,String status , String log,String create
      ) async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    setState(() {
      sharedPreferences.setString(PrefInfo.ID, ID);
      sharedPreferences.setString(PrefInfo.name, name);
      sharedPreferences.setString(PrefInfo.email,email);
      sharedPreferences.setString(PrefInfo.num,num);
      sharedPreferences.setString(PrefInfo.pass, pass);
      sharedPreferences.setString(PrefInfo.pic, pic);
      sharedPreferences.setString(PrefInfo.lon, lon);
      sharedPreferences.setString(PrefInfo.lat, lat);
      sharedPreferences.setString(PrefInfo.ad,ad);
      sharedPreferences.setString(PrefInfo.city, city);
      sharedPreferences.setString(PrefInfo.country, country);
      sharedPreferences.setString(PrefInfo.status, status);

      sharedPreferences.setString(PrefInfo.log, log);
      sharedPreferences.setString(PrefInfo.create, create);
    });

  }



  @override
  Widget build(BuildContext context) {


    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width:MediaQuery.of(context).size.width ,
            alignment: Alignment.topCenter,
            child:SingleChildScrollView(
              padding: EdgeInsets.zero,
              physics:const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:  [
                  const SizedBox(height:10),
                  Image.asset(
                    'assets/images/logo.png',
                    color: Colors.deepOrangeAccent,
                    height:200,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                  const SizedBox(height:10),
                  Text('Layisi Login',style: TextStyle(color: Colors.deepOrangeAccent.withOpacity(0.8),fontSize: 18,fontWeight: FontWeight.w700)),
                  const SizedBox(height:10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [

                        _formField(
                            controller:_ema,
                            label:'Email',
                            type: TextInputType.emailAddress,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Enter Email';

                              }
                              bool _isValid= (EmailValidator.validate(value));
                              if(_isValid==false){
                                return 'Enter Valid Email Address';

                              }




                            }
                        ),

                        const SizedBox(height: 10,),


                        _formField(
                            controller:_pass,
                            label:'Password',
                            type: TextInputType.visiblePassword,

                            validator: (value){
                              if(value!.isEmpty){
                                return 'Enter your Password';

                              }
                            }
                        ),

                        const SizedBox(height: 10,),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Forgot Password?',
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepOrangeAccent),),

                        ),

                        Row(
                          children:[
                            const Text('New Account?'),
                            TextButton(
                              onPressed:(){
                                Navigator.pushReplacementNamed(context,Register.id);
                              },
                              child:const Text('Register',style: TextStyle(color:Colors.deepOrangeAccent,fontWeight: FontWeight.bold),),
                            ),

                          ],
                        ),


                      ],
                    ),
                  )
                ],

              ),

            ),
          ),
        ),
        bottomNavigationBar:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(


                child:NeumorphicButton(
                  style: const NeumorphicStyle(color:Colors.deepOrangeAccent),
                  onPressed:()
                  {

                    if(_formKey.currentState!.validate()){

                      login();
                    }

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [

                        Text('Login ',style: TextStyle(color: Colors.white),),
                      ],

                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
