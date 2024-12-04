import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:untitled2/constantes.dart';
import 'package:untitled2/models/personagem.dart';

class PersonagemServices {
  Future<List<Personagem>> getPersonagens() async {
    final response = await http.get(Uri.parse('$BASE_URL/quotes?count=32'));

    if(response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((personagem) => Personagem.fromJson(personagem)).toList();
    } else {
      throw Exception("Erro ao buscar personagens!");
    }
  }
}