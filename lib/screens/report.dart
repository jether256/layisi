import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:layisi/pref/pref.dart';
import 'package:layisi/provider/advertPro.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {



  final _reportController=TextEditingController();
  final _desc=TextEditingController();

  ///lists
  ///List<String> urList=[];
  final List<String> _reportList=[
    'This is illegal/fraudulent',
    'This ad is spam',
    'This is wrong',
    'Wrong category',
    'Seller asked for prepayment',
    'it is sold',
    'User is unreachable',
    'Other',
  ];


  @override
  void initState(){
    super.initState();
    getPref();
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

  Future<void> send(AdvertsProvider advertsProvider) async {

    EasyLoading.show(status: 'Reporting...');

    var response=await http.post(Uri.parse('https://layisikla.000webhostapp.com/api/report.php'),

        body:{
      "title":advertsProvider.Title,
      "image":advertsProvider.Image,
      "random":advertsProvider.Random,
      "report":_reportController.text,
      "describe":_desc.text,
        });



    if(response.statusCode==200){
      EasyLoading.showSuccess('Report Sent..');
      }else{

      EasyLoading.showError('Failed to Report');
      }

    }





  @override
  Widget build(BuildContext context) {

    final _advertsProvider=Provider.of<AdvertsProvider>(context);

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
            _appBar('Select report reason',fieldValue),
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

    return Form(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          elevation: 0.0,
          title: const Text('Report This Ad',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          iconTheme: const IconThemeData(color: Colors.white),
          
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      height: 50,
                      child:CachedNetworkImage(
                        imageUrl: _advertsProvider.Image,fit: BoxFit.cover,
                        //placeholder: (context, url) =>,
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(width: 10,),
                     Text(_advertsProvider.Title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),

                  ],
                ),

                const SizedBox(height: 10,),
                const Text('Why do you want to report this Ad?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 12,right: 12),
                  child: Container(
                    color: Colors.white24,
                    child:Column(
                      children: [

                        InkWell(
                          onTap: (){

                            showDialog(context: context, builder:(BuildContext context){
                              return _listview(fieldValue: 'Choose Reason',list: _reportList,textController: _reportController);

                            });

                          },
                          child: TextFormField(
                            enabled: false,
                            controller: _reportController,
                              decoration: InputDecoration(
                                  labelText: 'Choose reason*',
                                  labelStyle: const TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      )
                                  )
                              ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          keyboardType:TextInputType.multiline,
                          maxLines: 5,
                          maxLength: 500,
                          controller:_desc,
                          decoration: InputDecoration(
                              labelText: 'Describe your issue*',
                              labelStyle: const TextStyle(color: Colors.grey),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  )
                              )
                          ),
                        ),
                        const SizedBox(height: 10,),

                        MaterialButton(
                          color: Colors.deepOrangeAccent,
                          onPressed: (){

                            send(_advertsProvider);
                          },
                          child: const Text('REPORT',style: TextStyle(color: Colors.white),),
                        ),



                      ],
                    ) ,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
