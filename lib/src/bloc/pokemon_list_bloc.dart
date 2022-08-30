import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:untitled/src/bloc/base_bloc.dart';
import 'package:untitled/src/client/pokemon_client.dart';

import '../model/pokemon.dart';
import '../model/response.dart';

class PokemonListBloc extends BaseBloc{

  final _searchQueryController = StreamController<String>();
  final _pokemonListController = BehaviorSubject<List<Pokemon>>();

  final client = PokemonClient();

  Sink<String?> get searchQuery => _searchQueryController.sink;

  get  pokemonListStream => _pokemonListController.stream;

  PokemonListBloc()  {
    client.fetchPokemonList(0,20).
    then((value) => _pokemonListController.sink.add(value.results));

  }

  loadMore(int start){
    var oldData = _pokemonListController.value;
    client.fetchPokemonList(start, 20)
    .then((value) => {
        _pokemonListController.sink.add(oldData + value.results)

    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchQueryController.close();
  }

}