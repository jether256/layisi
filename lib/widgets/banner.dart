import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';



class Bann extends StatelessWidget {

  static const  String id='banner';
  const Bann({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .30,
        color: Colors.deepOrangeAccent,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        const Text('Cars',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:Colors.white,
                          letterSpacing: 1,
                          fontSize: 18,
                        ),),

                        const SizedBox(height: 20,),

                        SizedBox(
                        height: 45.0,
                        child: DefaultTextStyle(
                          style:const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ), child: AnimatedTextKit(
                          repeatForever: true,
                          isRepeatingAnimation: true,
                          animatedTexts: [
                            FadeAnimatedText('Reach 10k+\nInterested Buyers',
                            duration: const Duration(seconds: 4)),
                            FadeAnimatedText('New way to\n Buy or Sell Cars',
                                duration: const Duration(seconds: 4)),
                            FadeAnimatedText('Over 1k\n Cars to Buy',
                                duration: const Duration(seconds: 4)),

                          ],

                        ),
                        ),),



                      ],
                    ),

                    Neumorphic(
                      style: const NeumorphicStyle(
                        color: Colors.white,

                      ),
                      child:  Image.asset('assets/images/car.png',height: 50,),
                      //child:Image.network('');
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(child: NeumorphicButton(
                    child: const Text('Buy Car',textAlign: TextAlign.center,),
                  )),
                  const SizedBox(width: 20,),
                  Expanded(child: NeumorphicButton(
                    child: const Text('Sell Car',textAlign: TextAlign.center,),
                  )),
                ],

              ),
            ],
          ),
        ),

      ),
    );
  }
}
