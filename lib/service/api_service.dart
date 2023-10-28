import 'dart:convert';
import 'dart:math';
import 'package:screl_test/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
class ApiService{
 Future<List<UserModel>> fetchUserData() async {
  final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((item) => UserModel.fromJson(item)).toList();
  } else {
    throw Exception('Erro occure while fetching data');
  }
}

Future<void> openMaps(String lat, String lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await launchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print('error occur $url');
    }
  }
  
}