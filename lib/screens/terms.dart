import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


class Terms extends StatefulWidget {

  static const  String id='terms';

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {


  bool isAccepted=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [

                const SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal:10),
                  child: Row(
                    children:  [
                      const Icon(Icons.article_outlined,color: Colors.deepOrangeAccent,size: 7,),
                      const SizedBox(width: 3,),

                      Expanded(
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text('Terms of Service',textAlign: TextAlign.left,style: TextStyle(color: Colors.black.withOpacity(0.85,),fontSize: 17,fontWeight: FontWeight.w700),),
                              Text('Last Updated:Feb 11,2022',textAlign: TextAlign.left,style: TextStyle(color: Colors.black.withOpacity(0.7,),fontSize: 14,),),

                            ],
                          ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Expanded(
                    child:Container(
                      width: MediaQuery.of(context).size.width,
                      alignment:Alignment.topLeft,
                      child: SingleChildScrollView(
                        child: Text('Terms and conditions Here',textAlign:TextAlign.left,style:TextStyle(color: Colors.black.withOpacity(0.7)),),
                      ),
                    ),
                ),
                const SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [

                      Expanded(child:NeumorphicButton(
                        onPressed: (){

                          Navigator.pop(context);
                        },
                        style: const NeumorphicStyle(color:Colors.deepOrangeAccent),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Decline ',style: TextStyle(color:isAccepted ? Colors.deepOrangeAccent:Colors.blueGrey),),
                            ],

                          ),
                        ),
                      )),

                      Expanded(child:NeumorphicButton(
                        onPressed: (){
                          Navigator.pop(context);

                        },
                        style: const NeumorphicStyle(color:Colors.deepOrangeAccent),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('Accept ',style: TextStyle(color: Colors.white),),
                            ],

                          ),
                        ),
                      )),

                    ],
                  ),
                )

              ],
            ),

          ),
      ),
    );
  }
}
