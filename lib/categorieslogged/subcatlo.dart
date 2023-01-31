import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:layisi/provider/subcatpro.dart';
import 'package:layisi/screens/product_by_sub.dart';
import 'dart:convert';

import 'package:layisi/widgets/loading.dart';
import 'package:provider/provider.dart';

import '../model/submodel.dart';





class SubCatLo extends StatefulWidget {

  final String categoryID;
  final  String categoryTitle;
  final String categoryPic;
  final String categoryStatus;

  SubCatLo({required this.categoryID, required this.categoryTitle, required this.categoryPic, required this.categoryStatus,});

  @override
  _SubCatLoState createState() => _SubCatLoState();
}

class _SubCatLoState extends State<SubCatLo> {

  @override
  void initState(){
    super.initState();
    showSubCategories();
  }


  late  List subCategories=[];
 // List<SubCatModel> subCategories = [];
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
                    physics: BouncingScrollPhysics(),
                    itemCount:subCategories.length ,
                    itemBuilder:(context,index){
                     // final x = subCategories[index];

                      return SubItem (
                        subID:subCategories[index]['ID'],
                        sCatID:subCategories[index]['cat_id'],
                        subcat:subCategories[index]['subcat'],
                      );



                    });

                // }
              }




              else {
                return Center(child: Loading());
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




          _subProvider.selectedSub(
              widget.subID,widget.sCatID,widget.subcat
          );

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductBySub(subID:widget.subID,sCatID:widget.sCatID,subcat:widget.subcat)
              )
          );



        },
        title: Text(widget.subcat,style:TextStyle(fontSize:15),),



      ),
    );
  }
}

