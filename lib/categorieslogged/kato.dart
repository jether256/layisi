import 'dart:convert';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';

import 'package:http/http.dart' as http;
import 'package:layisi/categorieslogged/subcatlo.dart';
import 'package:layisi/provider/cartegorypro.dart';
import 'package:layisi/screens/product_by_cart.dart';
import 'package:layisi/widgets/loading.dart';
import 'package:provider/provider.dart';

import '../model/categoModel.dart';
import 'catlist.dart';


class CategoryLo extends StatefulWidget {
  const CategoryLo({Key? key}) : super(key: key);

  @override
  _CategoryLoState createState() => _CategoryLoState();
}


class _CategoryLoState extends State<CategoryLo> {


  @override
  void initState(){
    super.initState();
    showCategories();
  }

  late  List categories=[];

  //List<CategoryModel> categories = [];
  showCategories()async {
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
    var snapshot;
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
                        builder: (context) => const CategoryListScreenLo(),
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
                  future:showCategories(),
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

                          }) ;



                    } else {
                      return Center(child: Loading());
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

          if(widget.categoryTitle=='Cars'){

            EasyLoading.showError('No Subcategories..');

            _categoryProvider.selectedCategory(
                widget.categoryID,widget.categoryTitle,widget.categoryStatus,widget.categoryPic
            );


            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  ProductByCategory(categoryID:widget.categoryID,categoryTitle:widget.categoryTitle,categoryPic:widget.categoryPic, categoryStatus:widget.categoryStatus,)
                )
            );



          }else{

            _categoryProvider.selectedCategory(
                widget.categoryID,widget.categoryTitle,widget.categoryStatus,widget.categoryPic
            );


            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>   SubCatLo(categoryID:widget.categoryID, categoryTitle:widget.categoryTitle,categoryPic:widget.categoryPic,categoryStatus:widget.categoryStatus,),
                )
            );
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

