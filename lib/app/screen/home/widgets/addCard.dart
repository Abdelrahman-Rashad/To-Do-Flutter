import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/extensions.dart';
import 'package:todo/app/screen/home/icons.dart';
import 'package:todo/controller/homecontroller.dart';
import 'package:todo/model/task.dart';

class AddCard extends StatelessWidget {
  AddCard({Key? key}) : super(key: key);
  final homecontrol=Get.find<Homecontroller>();
  @override
  final icons=getIcons();
  var squarewidth=Get.width-20.0.wp;
  Widget build(BuildContext context) {
    return Container(
      width: squarewidth/2,
      height: squarewidth/2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: ()async{
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            radius: 5,
            title: 'Task Type',
            titleStyle:Theme.of(context).textTheme.headline5,
            content: Form(
              key: homecontrol.formkey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: TextFormField(
                      controller:homecontrol.titlecontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        labelText: 'Title',
                        labelStyle: Theme.of(context).textTheme.headline2,
                      ),
                      validator: (value){
                        if(value==null||value.trim().isEmpty){
                          return 'Please enter your task title';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical:  5.0.wp),
                    child: Wrap(
                      spacing: 2.0.wp,
                      children: icons.map((e) => Obx((){
                        final index=icons.indexOf(e);
                        return ChoiceChip(
                          label: e,
                          selectedColor: Colors.grey[200],
                          pressElevation: 0,
                          backgroundColor: Colors.white,
                          selected: homecontrol.chipIndex.value==index,
                          onSelected: (bool selected){
                            homecontrol.chipIndex.value=selected?index:0;
                          },);
                      })).toList(),
                    ),
                  ),
                  SizedBox(width: 40.0.wp,height: 6.0.hp, child: ElevatedButton(onPressed: (){
                    if(homecontrol.formkey.currentState!.validate()){
                      int icon=icons[homecontrol.chipIndex.value].icon!.codePoint;
                      String color=icons[homecontrol.chipIndex.value].color!.toHex();
                      var task =Task(title: homecontrol.titlecontroller.text.toString(), icon: icon, color: color);
                      Get.back();
                      homecontrol.addTask(task)?EasyLoading.showSuccess('Create Sucess'):EasyLoading.showError('Duplicate Task');
                    }
                  }, child: Text("Confirm")))
                ],
              ))
          );
          homecontrol.titlecontroller.clear();
          homecontrol.changeChipIndex(0);
        },
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(20),
          color: Colors.grey[400]!,
          dashPattern: const [8,4],
          child: Center(
            child: Icon(Icons.add,size: 15.0.wp,
            color: Colors.grey,),
          )),
      ),
    );
  }
}