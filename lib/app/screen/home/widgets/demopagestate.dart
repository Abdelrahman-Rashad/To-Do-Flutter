import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/extensions.dart';
import 'package:todo/app/screen/home/home.dart';
import 'package:todo/app/screen/home/widgets/addDialog.dart';
import 'package:todo/app/screen/report/report.dart';
import 'package:todo/controller/homecontroller.dart';
import 'package:todo/model/task.dart';

class Demopagestate extends StatelessWidget {
  Demopagestate({Key? key}) : super(key: key);
  var control=Get.find<Homecontroller>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: DragTarget<Task>(

        builder:(_,__,___){
          return  Obx(
          () =>  FloatingActionButton(
            backgroundColor: control.deleting.value?Colors.red:Colors.deepPurple,
            onPressed:(){
              if(control.tasks.isNotEmpty){
                Get.to(()=>AddDialog(),transition: Transition.downToUp);
              }else{
                EasyLoading.showInfo("Please create your task type");
              }
            },
            child: Icon(control.deleting.value? Icons.delete:Icons.add,color: Colors.white,size: 30),
          ),
        );
        },
        onAccept: (Task task){
          control.deletetask(task);
          EasyLoading.showSuccess("Delete Sucess");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: 
         BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.deepPurple,
          notchMargin: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Padding(
              padding: EdgeInsets.only(right: 10.0.wp),
              child: IconButton(onPressed: (){control.changemypage(0);}, icon: Icon(Icons.list_alt_rounded,color: Colors.white,size: 30,)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0.wp),
              child: IconButton(onPressed: (){control.changemypage(1);}, icon: Icon(Icons.data_saver_off_rounded,color: Colors.white,size: 30)),
            ),
          ],)
          ),
      
      body: PageView(
        controller: control.mypage,
        children: [
          Home(),
          Report(),
        ],
      ),
    );
  }
}