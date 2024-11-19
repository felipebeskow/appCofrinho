import 'package:cofrinho/model/categories.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoriesController {
  Future<List<Categories>> getCategories() async {
    final response = await http
        .get(Uri.parse('${const String.fromEnvironment('API_URL')}/category'));
    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      List<Categories> listCategories = json
          .map((category) => Categories(
              nome: category['CAT_NOME'], uuid: category['CAT_UUID']))
          .toList();
      return listCategories;
    }
    return List<Categories>.empty();
  }
}
