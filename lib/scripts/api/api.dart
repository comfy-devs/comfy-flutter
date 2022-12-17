/* Types */
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../types/api.dart';

const apiVersion = "/v1";

Future<APIResponse> get(APIGetRequest descriptor) async {
  try {
    final response = await http.get(
        Uri.parse(descriptor.state.preferences.apiEndpoint +
            apiVersion +
            descriptor.path),
        headers: {"Origin": descriptor.state.preferences.apiEndpoint});
    return APIResponse(response.statusCode, json.decode(response.body));
  } on Exception catch (_) {
    return APIResponse(-1, "");
  }
}

Future<APIResponse> post(APIPostRequest descriptor) async {
  final response = await http.post(
      Uri.parse(descriptor.state.preferences.apiEndpoint +
          apiVersion +
          descriptor.path),
      body: descriptor.body,
      headers: {"Origin": descriptor.state.preferences.apiEndpoint});
  return APIResponse(response.statusCode, json.decode(response.body));
}
