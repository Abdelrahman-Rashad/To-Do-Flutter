import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:todo/app/data/services/storage/repository.dart';
import 'package:todo/model/task.dart';

class Homecontroller extends GetxController{
  TaskRepository taskRepository;
  Homecontroller({required this.taskRepository});
  final tasks=<Task>[].obs;
  final chipIndex=0.obs;
  final deleting = false.obs;
  final formkey=GlobalKey<FormState>();
  var titlecontroller=TextEditingController();
  final task =Rx<Task?>(null);
  final doingTodos=<dynamic>[].obs;
  final doneTodos=<dynamic>[].obs;
  PageController mypage=PageController(initialPage: 0);

  @override
  void onInit() {
    print("oninit in controller = ${taskRepository.readTasks()}");
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_)=>taskRepository.writeTasks(tasks));
    super.onInit();
  }

  void changeChipIndex(int value){
    chipIndex.value=value;
  }
  void changemypage(int index) {
    mypage.jumpToPage(index);
  }

  @override
  void onClose() {
    titlecontroller.dispose();
    super.onClose();
  }
  void changeDeleting (bool value){
    deleting.value=value;
  }
  void changeTodos(List<dynamic> select){
    doingTodos.clear();
    doneTodos.clear();
    for(int i=0;i<select.length;i++){
      var todo=select[i];
      var status=todo['done'];
      if(status)
      doneTodos.add(todo);
      else
      doingTodos.add(todo);
    }
  }

  void changeTask (Task? value){
    task.value=value;
  }

  bool addTask(Task task) {
    if(tasks.contains(task))
    return false;

    tasks.add(task);
    return true;
  }

  void deletetask(Task task) {
    tasks.remove(task);
  }

  updateTask(Task task, String title) {
    var todos=task.todos??[];
    if(containetodo(todos,title)){
      return false;
    }

    var todo ={'title':title,'done':false};
    todos.add(todo);
    var newtask=task.copywith(todos:todos);
    int oldIdx=tasks.indexOf(task);
    tasks[oldIdx]=newtask;
    tasks.refresh();
    return true;
  }
  
  bool containetodo(List todos, String title) {
    return todos.any((element) => element['title']==title);
  }

  bool addTodo(String title) {
    var todo ={'title':title,'done':false};
    if(doingTodos.any((element) => mapEquals<String,dynamic>(todo,element ))){
      return false;
    }
     var donetodo ={'title':title,'done':true};
    if(doneTodos.any((element) => mapEquals<String,dynamic>(donetodo,element ))){
      return false;
    }
    doingTodos.add(todo);
    return true;
  }

  void updateTodos(){
    var newTodos=<Map<String,dynamic>>[];
    newTodos.addAll([...doingTodos,...doneTodos]);

    var newtask=task.value!.copywith(todos: newTodos);
    int oldIdx=tasks.indexOf(task.value);
    tasks[oldIdx]=newtask;
    tasks.refresh();
  }

  void doneTodo(String title) {
    var doingtodo ={'title':title,'done':false};
    int index=doingTodos.indexWhere((element) => mapEquals<String,dynamic>(doingtodo, element));
    doingTodos.removeAt(index);
    var donetodo ={'title':title,'done':true};
    doneTodos.add(donetodo);
    doingTodos.refresh();
    doneTodos.refresh();

  }

  deleteDoneTodo(dynamic donetodo) {
    int index = doneTodos.indexWhere((element) =>mapEquals<String , dynamic>(donetodo, element));
    doneTodos.removeAt(index);
    doneTodos.refresh();
  }

  bool isTodoEmpty(Task task){
    return task.todos==null || task.todos!.isEmpty;
  }

  int getDoneTodo(Task task){
    var res=0;
    for(var e in task.todos!){
      if(e['done']==true) {
        res++;
      }
    }
    return res;
  }
  int getTotalTask(){
    var res=0;
    for(var e in tasks){
      if(e.todos!=null){
        res += e.todos!.length;
      }
    }
    return res;
  }

  int getTotalDoneTask(){
    var res=0;
    for(var e in tasks){
      if(e.todos!=null){
        for(var j in e.todos!){
          if(j['done']==true){
            res++;
          }
        }
      }
    }
    return res;
  }
}