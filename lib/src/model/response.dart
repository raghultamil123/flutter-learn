import 'package:untitled/src/model/pokemon.dart';
import 'dart:convert';

class Response{
  int count;
  List<Pokemon> results;
  Response({required this.count,required this.results});

  factory Response.fromJson(Map<String,dynamic> data){
    return Response(
      count: data['count'],
      results: (data['results'] as List).map((e)=>Pokemon.fromJson(e)).toList(),
    );
  }
}