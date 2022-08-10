import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/app/core/keys.dart';

class StoreService extends GetxService{
  late GetStorage _box;

  Future<StoreService> init()async{
    _box=GetStorage();
    //await _box.write(TASKKEY, []);
    await _box.writeIfNull(TASKKEY, []);
    return this;
  }

  T read<T> (String key) {
    _box.listen(() {print(_box.read(key));});
    print("Function Readddddddd");
    return _box.read(key);
  }

  void write(String key,List<dynamic> value)async{
    await _box.write(key,value);
    _box.listen(() {print(_box.read(key));});
    print("Function writeeeee");

  }
}