import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';

import 'package:http/http.dart' as http;
import 'package:layisi/categories/subcat.dart';
import 'package:layisi/provider/cartegorypro.dart';

import 'package:layisi/screens/product_by_cart.dart';
import 'package:provider/provider.dart';
import '../model/categoModel.dart';
import 'categoriesscreen.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}


class _CategoryState extends State<Category> {










  // List<CategoryModel> categories = [];
  // showListCategories() async {
  //   var response = await http.get(
  //       Uri.parse("https://jetherk.000webhostapp.com/api/category.php"),
  //       headers: {"Accept": "headers/json"});
  //
  //   if (response.statusCode == 200) {
  //     // If the call to the server was successful, parse the JSON
  //     List<dynamic> values=[];
  //     values = json.decode(response.body);
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
  //   } else {
  //     // If that call was not successful, throw an error.
  //     throw Exception('Failed to load category');
  //   }
  // }

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
  showListCategories() async {
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




    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
            height: 150,
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                    child:Text('categories'),),
                TextButton(onPressed: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryListScreen(),
                      )
                  );
                },
                child:Row(
                  children: const [
                    Text('See All',style: TextStyle(color: Colors.black),),
                    Icon(Icons.arrow_forward_ios,size: 12,color:Colors.black,),
                  ],
                ),

                ),
              ],

            ),
            Expanded(

            child: FutureBuilder<dynamic>(
                    future:showListCategories(),
                    //initialData: [],
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                      if (snapshot.hasData) {

                        return  ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                  itemCount:categories.length ,
                  itemBuilder:( context, index){

                    //final x = categories[index];
                return CategoryItem (
                  categoryID:categories[index]['ID'],
                  categoryTitle:categories[index]['title'],
                    categoryStatus:categories[index]['status'],
                  categoryPic:'https://layisikla.000webhostapp.com/admin/ajax/cat/${categories[index]['imagee']}',

                );

              });

                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }

            ),
            ),

          ],

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


   CategoryItem({ required this.categoryID, required this.categoryTitle, required this.categoryPic, required this.categoryStatus});





  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {


    final _categoryProvider=Provider.of<CategoryProvider>(context);


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          //
          // _catooo.getCategory(categories['Cars']);
          // _catooo.getCar(categories);
          if( widget.categoryTitle=='Cars'){

            EasyLoading.showError('Please Login First');




          }else{

            EasyLoading.showError('Please Login First');


          }


        },
        child: SizedBox(
          width: 60,
          height: 50,
          child: Column(
            children: [
              //Image.network(widget.categoryPic),
              CachedNetworkImage(
                imageUrl: widget.categoryPic,fit: BoxFit.cover,
                placeholder: (context, url) =>GFShimmer(
                  child:Container(
                    color: Colors.grey.shade400,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Flexible(
                child: Text(
                  widget.categoryTitle,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

