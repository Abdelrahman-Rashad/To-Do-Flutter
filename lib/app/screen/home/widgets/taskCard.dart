import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/extensions.dart';
import 'package:todo/app/screen/detail/detail.dart';
import 'package:todo/app/screen/home/home.dart';
import 'package:todo/controller/homecontroller.dart';
import 'package:todo/main.dart';
import 'package:todo/model/task.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  TaskCard({Key? key, required this.task}) : super(key: key);
  final Homecontrol = Get.find<Homecontroller>();
  final Task task;
  @override
  Widget build(BuildContext context) {
    var squarewidth = Get.width - 20.0.wp;
    final color = HexColor.fromHex(task.color);
    return GestureDetector(
      onTap:(){
        Homecontrol.changeTask(task);
        Homecontrol.changeTodos(task.todos??[]);
        Get.to(()=>DetailPage());},
      child: Container(
        width: squarewidth / 2,
        height: squarewidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300]!,
                blurRadius: 7,
                offset: Offset(0, 7),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StepProgressIndicator(
                totalSteps: Homecontrol.isTodoEmpty(task)?1:task.todos!.length,
                currentStep: Homecontrol.isTodoEmpty(task)?0:Homecontrol.getDoneTodo(task),
                roundedEdges: const Radius.circular(10),
                size: 5,
                padding: 0,
                selectedGradientColor: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [color.withOpacity(0.4), color]),
                unselectedGradientColor: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [Colors.white, Colors.white]),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Icon(IconData(task.icon,fontFamily: 'MaterialIcons'),color: color,),
            ),
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title,style: Theme.of(context).textTheme.headline5,),
                  SizedBox(height: 1.0.wp,),
                  Text('${task.todos?.length??0} Task',style: Theme.of(context).textTheme.headline2,)
    
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
