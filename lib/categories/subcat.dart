import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:layisi/provider/subcatpro.dart';
import 'dart:convert';

import 'package:layisi/screens/product_by_sub.dart';
import 'package:provider/provider.dart';

import '../model/submodel.dart';



class Subcalist extends StatefulWidget {

  final String categoryID;
  final  String categoryTitle;
  final String categoryPic;
  final String categoryStatus;

  Subcalist({ required this.categoryID, required this.categoryTitle, required this.categoryPic, required this.categoryStatus});

  //const Subcalist({Key? key}) : super(key: key);

  @override
  _SubcalistState createState() => _SubcalistState();
}

class _SubcalistState extends State<Subcalist> {



  @override
  void initState(){
    super.initState();
    showSubCategories();
  }



  late  List subCategories=[];
  //List<SubCatModel> subCategories = [];
  showSubCategories() async {
    var response = await http.get(
        Uri.parse("https://layisikla.000webhostapp.com/api/sub.php"),
        headers: {"Accept": "headers/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      setState(() {
        subCategories = jsonData;
      });
      print(jsonData);
      return jsonData;
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: const Border(bottom: BorderSide(color: Colors.grey,),),
        backgroundColor: Colors.deepOrangeAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        title:  Text(widget.categoryTitle,style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        child:FutureBuilder<dynamic>(
              future:showSubCategories(),
              //initialData: [],
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
              if (snapshot.hasData) {
              // if(snapshot.data!.length == 0){
              //   return Center(child: Text('List is empty'));
              // }else {

          return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount:subCategories.length ,
              itemBuilder:(context,index){

                //final x = subCategories[index];

              return SubItem (
                subID:subCategories[index]['ID'],
                sCatID:subCategories[index]['cat_id'],
                subcat:subCategories[index]['subcat'],
              );


              });

                // }
                }




              else {
                return const Center(child: CircularProgressIndicator());
                }
                }



      ),
      ),
    );
  }
}

class SubItem extends StatefulWidget {

  final String subID;
  final String  sCatID;
  final String  subcat;

  SubItem({required this.subID, required this.sCatID, required this.subcat});

  @override
  _SubItemState createState() => _SubItemState();
}

class _SubItemState extends State<SubItem> {
  @override
  Widget build(BuildContext context) {

    final _subProvider=Provider.of<SubProvider>(context);


    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
      child: ListTile(
        onTap: (){

          EasyLoading.showError('Please Login First');



        },
        title: Text(widget.subcat,style:const TextStyle(fontSize:15),),



      ),
    );
  }
}

