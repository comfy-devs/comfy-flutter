/* Types */
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../types/api.dart';

const apiEndpoint = "https://api.nyananime.xyz";
const apiVersion = "/v1";

Future<APIResponse> get(APIGetRequest descriptor) async {
    final response = await http.get(Uri.parse(apiEndpoint + apiVersion + descriptor.path), headers: { "Origin": apiEndpoint });
    return APIResponse(response.statusCode, json.decode(response.body));
}

Future<APIResponse> post(APIPostRequest descriptor) async {
    final response = await http.post(Uri.parse(apiEndpoint + apiVersion + descriptor.path), body: descriptor.body, headers: { "Origin": apiEndpoint });
    return APIResponse(response.statusCode, json.decode(response.body));
}
