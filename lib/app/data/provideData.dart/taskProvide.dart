import 'dart:convert';

import 'package:get/get.dart';
import 'package:todo/app/core/keys.dart';
import 'package:todo/app/data/services/storage/sevices.dart';
import 'package:todo/model/task.dart';

class TaskProvider{
  final _store=Get.find<StoreService>();

  List<Task> readTasks(){
    var tasks =<Task>[];
    dynamic temp= jsonDecode(_store.read(TASKKEY).toString());
    print("before Provider = ${jsonDecode(_store.read(TASKKEY).toString())}");
    for(var e in temp){
      tasks.add(Task.fromjson(e));
    }
    //tasks.add(Task.fromjson(temp));
    
    /*List<dynamic>? temp1;
    temp1?.add(temp);
    print("Provider = $temp1");
    temp1?.forEach((element) => tasks.add(Task.fromjson(element)));*/
    
    
    return tasks;
  }

  void writeTasks(List<Task> tasks){
    /*for(var e in tasks){
        _store.write(TASKKEY,jsonEncode(e.tojson(e)));

    }*/
    var temp=<dynamic>[];
    for(var e in tasks){
      temp.add(jsonEncode(e.tojson(e)));
    }

    _store.write(TASKKEY,temp);

  }
}