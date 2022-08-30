import 'dart:convert';

import 'package:untitled/src/model/pokemon_info.dart';

import '../model/response.dart';
import 'package:http/http.dart' as http;
class PokemonClient{
  Future<Response> fetchPokemonList(int start,int limit) async {

    print("called");
    try {
      var url = Uri.parse("https://pokeapi.co/api/v2/pokemon/?offset=${start}&limit=${limit}");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Response pokemonResponse = Response.fromJson(jsonDecode(response.body));
        return pokemonResponse;
      }
    } catch (e) {
      print("log"+e.toString());
    }
    return Response(count: 0, results: []);

  }

  Future<PokemonInfo> fetchPokemonInfo(String pokemonName) async{
    try{
      var url = Uri.parse("https://pokeapi.co/api/v2/pokemon/${pokemonName}");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        //Response pokemonResponse = Response.fromJson(jsonDecode(response.body));
        return PokemonInfo();
      }
    }catch(e){

    }

    return PokemonInfo();
  }
}