import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/app/core/extensions.dart';
import 'package:todo/controller/homecontroller.dart';
import 'package:intl/intl.dart';

class Report extends StatelessWidget {
  Report({Key? key}) : super(key: key);
  final control=Get.find<Homecontroller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx((){
          var createdTasks = control.getTotalTask();
          var completedTasks = control.getTotalDoneTask();
          var livetasks = createdTasks-completedTasks;
          var precent=(completedTasks/createdTasks *100).toStringAsFixed(0);
          return ListView(
            children: [
              Row(
                children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.0.wp,bottom: 2.0.wp,top: 5.0.wp),
                  child: const Icon(Icons.data_saver_off_rounded,color:Colors.deepPurple,size: 35,),
                ),
                 Padding(
                padding: EdgeInsets.only(left: 4.0.wp,bottom: 2.0.wp,right: 4.0.wp,top: 4.0.wp),
                child: Text('My Report',style: Theme.of(context).textTheme.headline4,),
              ),
              ],),
             
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                child: Text(DateFormat.yMMMd().format(DateTime.now()),style: Theme.of(context).textTheme.headline2),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 4.0.wp,horizontal: 4.0.wp),
                child: const Divider(thickness: 2,),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 3.0.wp,horizontal: 5.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    status(Colors.red, livetasks, 'Live Tasks', context),
                    status(Colors.green, completedTasks, 'Completed', context),
                    status(Colors.blue, createdTasks, 'Created', context)
                  ],
                ),
              ),
              SizedBox(height:15.0.wp),
              UnconstrainedBox(
                child: SizedBox(
                  width: 70.0.wp,
                  height: 70.0.wp,
                  child: CircularStepProgressIndicator(
                    totalSteps: createdTasks==0?1:createdTasks,
                    currentStep: completedTasks,
                    stepSize: 20,
                    selectedColor: Colors.deepPurple,
                    unselectedColor: Colors.grey[200],
                    padding: 0,
                    width:150,
                    height: 150,
                    selectedStepSize: 22,
                    roundedCap: (_,__)=>true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${createdTasks==0?0:precent} %',style: Theme.of(context).textTheme.headline4,),
                        SizedBox(height: 1.0.wp,),
                        Text("Efficiency",style: Theme.of(context).textTheme.headline2,)
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        })
        )
    );
  }
  Widget status(Color color,int number,String title,BuildContext context){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 3.0.wp,
          width: 3.0.wp,
          decoration: BoxDecoration(
            color: color.withOpacity(0.4),
            shape: BoxShape.circle,
            border: Border.all(
              width: 0.5.wp,
              color: color,
            )
          ),
        ),SizedBox(width: 3.0.wp,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$number",style: Theme.of(context).textTheme.headline6,),
            Text(title,style: Theme.of(context).textTheme.headline2,)

          ],
        )
      ],
    );
  }
}