import 'package:taxi_assist/service/authentication_service.dart';
import 'package:taxi_assist/service/cloud_storage_service.dart';
import 'package:taxi_assist/service/firestore_service.dart';
import 'package:taxi_assist/utils/image_selector.dart';
import 'package:get_it/get_it.dart';
import 'package:taxi_assist/service/navigation_service.dart';
import 'package:taxi_assist/service/dialog_service.dart';
import 'activity.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => CloudStorageService());
  locator.registerLazySingleton(() => ImageSelector());
  locator.registerLazySingleton(() => MyHomePage());
}
