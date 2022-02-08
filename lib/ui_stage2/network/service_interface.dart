// import 'package:chopper/chopper.dart'; // flutter pub run build_runner build --delete-conflicting-outputs

import 'model_response.dart';

abstract class TSerializable {
  TSerializable.fromJson(Map<String, dynamic> json);

  TSerializable();

  Map<String, dynamic> toJson();
}

abstract class ServiceInterface<T extends TSerializable> {
  Future<dynamic> queryService(String query);
}
