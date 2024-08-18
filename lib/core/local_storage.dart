import 'package:firebase_core/firebase_core.dart';
import 'package:fuel_management/firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_strategy/url_strategy.dart';




class LocalStorage {
  static Future<void> initData() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await Hive.initFlutter();
    //open local storage box
    await Hive.openBox('fuel');
    
    setPathUrlStrategy();
  }

  //save data to local storage
  static void saveData(String key, String value) async{
    await Hive.box('fuel').put(key, value);
  }

  //get data from local storage
  static String? getData(String key) {
    return Hive.box('fuel').get(key);
  }

  //remove data from local storage
  static void removeData(String key) async{
    await Hive.box('fuel').delete(key);
  }
}
