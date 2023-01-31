
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


import 'package:http/http.dart' as http;

import 'package:layisi/provider/cartegorypro.dart';

import 'dart:convert';


import 'package:provider/provider.dart';


import '../model/categoModel.dart';




class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({Key? key}) : super(key: key);

  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {


  // List<CategoryModel> categories = [];
  // showListCategories() async {
  //
  //
  //   var isCacheExist = await APICacheManager().isAPICacheKeyExist("Categories");
  //
  //   if(!isCacheExist) {
  //
  //
  //     var response = await http.get(
  //         Uri.parse("https://layisikla.000webhostapp.com/api/category.php"),
  //         headers: {"Accept": "headers/json"});
  //
  //     if (response.statusCode == 200) {
  //
  //       APICacheDBModel cacheDBModel= APICacheDBModel(key:"Categories", syncData:response.body);
  //       await APICacheManager().addCacheData(cacheDBModel);
  //
  //       // If the call to the server was successful, parse the JSON
  //       List<dynamic> values=[];
  //       values = json.decode(response.body);
  //       if(values.isNotEmpty){
  //         for(int i=0;i<values.length;i++){
  //           if(values[i]!=null){
  //             Map<String,dynamic> map=values[i];
  //             categories .add(CategoryModel.fromJson(map));
  //           }
  //         }
  //       }
  //       return categories;
  //
  //     } else {
  //       // If that call was not successful, throw an error.
  //       throw Exception('Failed to load category');
  //     }
  //
  //   }else{
  //
  //     var cacheData=await APICacheManager().getCacheData("Categories");
  //     print("Cache:hit");
  //
  //     List<dynamic> values=[];
  //     values = json.decode(cacheData.syncData);
  //     if(values.isNotEmpty){
  //       for(int i=0;i<values.length;i++){
  //         if(values[i]!=null){
  //           Map<String,dynamic> map=values[i];
  //           categories .add(CategoryModel.fromJson(map));
  //         }
  //       }
  //     }
  //     return categories;
  //
  //
  //   }
  //
  // }


  @override
  void initState(){
    super.initState();
    showListCategories();
  }


  late  List categories=[];
  //List<CategoryModel> categories = [];

  showListCategories()async {
    var response = await http.get(
        Uri.parse("https://layisikla.000webhostapp.com/api/category.php"),
        headers: {"Accept": "headers/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      setState(() {
        categories = jsonData;
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
        title: const Text('categories',style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child:FutureBuilder<dynamic>(
              future:showListCategories(),
              //initialData: [],
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                if (snapshot.hasData) {
                  // if(snapshot.data!.length == 0){
                  //   return Center(child: Text('List is empty'));
                  // }else {
                    return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                      itemCount:categories.length ,

                      itemBuilder:( context, index){

                        final x = categories[index];
                      return CategoryItem (
                        categoryID:categories[index]['ID'],
                        categoryTitle:categories[index]['title'],
                        categoryStatus:categories[index]['status'],
                        categoryPic:'https://layisikla.000webhostapp.com/admin/ajax/cat/${categories[index]['imagee']}',
                      );

                      }) ;
                  // }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }

        ),
      ),
      ),
    );
  }
}

class CategoryItem extends StatefulWidget {

  final String categoryID;
  final  String categoryTitle;
  final String categoryPic;
  final String categoryStatus;

  const CategoryItem({ required this.categoryID, required this.categoryTitle, required this.categoryPic, required this.categoryStatus});

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {


    final _categoryProvider=Provider.of<CategoryProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: (){



      if( widget.categoryTitle=='Cars'){

        EasyLoading.showError('Please Login First');



      }else{

        EasyLoading.showError('Please Login First');



      }

        },
        leading: Image.network(widget.categoryPic),
        // leading: CachedNetworkImage(
        //   height: 40,
        //   imageUrl: widget.categoryPic,fit: BoxFit.cover,
        // ),
        title: Text(widget.categoryTitle,style: const TextStyle(fontSize: 15),),
        trailing: const Icon(Icons.arrow_forward_ios,size: 12,),
      ),
    );
  }
}

