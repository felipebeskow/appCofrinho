import 'package:cofrinho/env.dart';
import 'package:cofrinho/model/walleties.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WalletiesController {
  Future<List<Walleties>> getWalleties() async {
    final response = await http.get(Uri.parse('${Env.API_KEY}/wallet'));
    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      List<Walleties> listWalleties = json
          .map((wallet) =>
              Walleties(nome: wallet['CAR_NOME'], uuid: wallet['CAR_UUID']))
          .toList();
      return listWalleties;
    }
    return List<Walleties>.empty();
  }
}
