import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/extensions.dart';
import 'package:todo/controller/introcontroller.dart';

class Intro extends StatelessWidget {
  Intro({Key? key}) : super(key: key);
  final introdata=IntroController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F2F1),
      body: SafeArea(
        child:
           Center(
             child: Column(
              children: [
                Expanded(child: PageView.builder(
                  controller: introdata.pagecontroller,
                  onPageChanged: introdata.currentIndex,
                  itemCount: introdata.contents.length,
                  itemBuilder: (context,index) {
                    return Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Image(image: AssetImage(introdata.contents[index].imageName??""),width: 340,height: 340,),
                          SizedBox(height: 10.0.hp,),
                          Text(introdata.contents[index].title??"",style: Theme.of(context).textTheme.headline1,),
                          SizedBox(height: 1.0.hp,),
                          Text(introdata.contents[index].description??"",style: Theme.of(context).textTheme.headline2,textAlign: TextAlign.center,)
                          
                        ],
                      ),
                    );
                  },
                )),
                Container(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(introdata.contents.length, (index) {
                    return  Obx((){
    return Container(

      height: 15,
      width: introdata.currentIndex.value==index?55:30,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
        blurRadius: 7,
          )
        ],
        borderRadius: BorderRadius.circular(20),
        color: introdata.currentIndex.value==index?Theme.of(context).primaryColor:Colors.white,
      ),
    );
  }
    
  );
                  }),
                ),),
                SizedBox(height: 10.0.hp,),
                Obx((){
                  return Container(
                    padding: EdgeInsets.only(bottom: 30),
                    width: 60.0.wp,
                    height: 10.0.hp,
                    child: ElevatedButton(
                      
                      onPressed: (){
                        
                      introdata.actionbutton();
                    }, child: Text(introdata.currentIndex.value==introdata.contents.length-1?"Continue":"Next",style:Theme.of(context).textTheme.headline3,)),
                  );
                }
                  
                )
              ],
          ),
           ),

        
        ),
    );
  }

}

