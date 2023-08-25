import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';

String baseUrlConnexion = "http://192.168.1.29:8081";

class Model {
  Client httpClient = http.Client();
  String baseUrl = baseUrlConnexion;
  //String baseUrl = "https://615f5fb4f7254d0017068109.mockapi.io/api/v1";

  Model({MockClient? mockClient}){
    if(mockClient != null){
      httpClient = mockClient;
    }
  }
}