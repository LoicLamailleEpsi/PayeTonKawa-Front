import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Model {
  Client httpClient = http.Client();
  String baseUrl = "http://192.168.1.29:8081";
  //String baseUrl = "https://615f5fb4f7254d0017068109.mockapi.io/api/v1";
}