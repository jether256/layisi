

import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:geopoint/geopoint.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:layisi/crypt/encrypt.dart';
import 'package:layisi/provider/auth.dart';
import 'package:layisi/screens/terms.dart';
import 'package:provider/provider.dart';

import 'login.dart';



class Register extends StatefulWidget {


  static const  String id='register';

  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {




  bool isAccepted=false;



  final _formKey = GlobalKey<FormState>();
  final _nName = TextEditingController();
  final _contNum = TextEditingController();
  final _ema = TextEditingController();
  final _pass = TextEditingController();
  final _addressController = TextEditingController();
  final _lonontroller = TextEditingController();
  final _LatController = TextEditingController();


  Widget _formField(
      {TextEditingController? controller, String? label, TextInputType? type,
        String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        prefixText: controller == _contNum ? '+256' : null,

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


  _scaffold(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),
      action: SnackBarAction(label: 'Ok', onPressed: () {
        ScaffoldMessenger.of(context).clearSnackBars();
      },),));
  }


  @override
  Widget build(BuildContext context) {


    final _authData = Provider.of<AuthProvider>(context);

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
                  Text('Layisi Register',style: TextStyle(color: Colors.deepOrangeAccent.withOpacity(0.8),fontSize: 18,fontWeight: FontWeight.w700)),
                  const SizedBox(height:10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [


                        _formField(
                            controller: _nName,
                            label: 'Name',
                            type: TextInputType.text,

                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Name';
                              }
                            }
                        ),

                        const SizedBox(
                          height: 10,
                        ),


                        _formField(
                            controller: _contNum,
                            label: 'Phone Number',
                            type: TextInputType.text,

                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Phone Number';
                              }
                            }
                        ),

                        const SizedBox(
                          height: 10,
                        ),


                        _formField(
                            controller: _ema,
                            label: 'Email',
                            type: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Email';
                              }
                              bool _isValid = (EmailValidator.validate(value));
                              if (_isValid == false) {
                                return 'Enter Valid Email Address';
                              }
                            }
                        ),

                        const SizedBox(height: 10,),

                        _formField(
                            controller: _pass,
                            label: 'Password',
                            type: TextInputType.visiblePassword,

                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Password';
                              }
                            }
                        ),

                        const SizedBox(height: 10,),


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
                                _scaffold('Could not find location try again');
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


                        Row(
                          mainAxisAlignment:MainAxisAlignment.start,
                          children: [
                            const Text('Have Account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, Login.id);
                              },
                              child: const Text('Login', style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontWeight: FontWeight.bold),),
                            ),

                          ],
                        ),

                        GestureDetector(
                          onTap: (){

                            Navigator.pushReplacementNamed(context, Terms.id);

                          },
                          child: Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.greenAccent,
                                activeColor: Colors.red,
                                splashRadius:MediaQuery.of(context).size.height * 0.03,
                                value: isAccepted,
                                onChanged: (value) {
                                  setState(() {
                                    isAccepted = value!;
                                  });
                                },
                              ),
                              const SizedBox(height: 10,),
                              const Expanded(
                                child: Text('if you continue,you are accepting \n Terms and Conditions and Privacy Policy',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontSize: 16,
                                  ),),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],

              ),

            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(

                child: NeumorphicButton(
                  style: const NeumorphicStyle(color:Colors.deepOrangeAccent),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      EasyLoading.show(status: 'Registering...');

                      var response = await http.post(Uri.parse(
                          'https://layisikla.000webhostapp.com/api/register.php'),

                          body: {"name":encryp(_nName.text) ,
                            "number": encryp(_contNum.text),
                            "email":encryp( _ema.text),
                            "password":encryp(_pass.text) ,
                            "address":encryp( _addressController.text),
                            "lon":encryp( '${_authData.shopLongitude}'),
                            "lat": encryp('${_authData.shopLatitude}'),
                          });


                      if (response.statusCode == 200) {
                        var userData = json.decode(response.body);

                        if (userData == "ERROR") {
                          EasyLoading.showError('Email Already Exists..');
                        } else {
                          Navigator.pushReplacementNamed(context, Login.id);

                          EasyLoading.showSuccess('Registered...');

                          print(userData);
                        }
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [

                        Text('Register ',style: TextStyle(color: Colors.white),),
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