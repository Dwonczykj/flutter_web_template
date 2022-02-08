import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

import 'model_response.dart';
import 'service_interface.dart';

class MockService implements ServiceInterface<ConsumerObj> {
  static MockService create() {
    // final client = ChopperClient(
    //     // baseUrl: apiUrl,
    //     // interceptors: [_addQuery, HttpLoggingInterceptor()],
    //     // converter: ModelConverter(),
    //     // errorConverter: const JsonConverter(),
    //     // services: [
    //     //   _$TemplateService(),
    //     // ],
    //     );
    var ms = MockService();
    ms.init();
    return ms;
  }

  @override
  Future<dynamic> queryService(String query) {
    var response = http.Response(
        Success<List<ConsumerObj>>(_projects_list.toList()).toString(), 200,
        request: null);
    return Future.value(jsonDecode(response.body));
  }

  late Iterable<ConsumerObj> _projects_list = <ConsumerObj>[];

  void init() {
    loadServiceData();
  }

  void loadServiceData() async {
    var jsonString = await rootBundle.loadString('assets/mock_data/data.json');
    _projects_list = (jsonDecode(jsonString)['consumers'] as List).map(
        (element) => ConsumerObj.fromJson(element as Map<String, dynamic>));
  }
}

class ConsumerObj extends TSerializable {
  factory ConsumerObj.fromJson(Map<String, dynamic> json) {
    return ConsumerObj(json['name'], json['balance']);
  }

  final String name;
  final double balance;

  ConsumerObj(this.name, this.balance) : super();

  @override
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'name': name, 'balance': balance};
}
