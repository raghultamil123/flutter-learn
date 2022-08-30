import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/src/bloc/bloc_provider.dart';
import 'package:untitled/src/bloc/pokemon_list_bloc.dart';

import 'screens/home.dart';

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    //
    return BlocProvider(
      bloc: PokemonListBloc(),
      child: Listener(
          onPointerDown: (_) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.focusedChild?.unfocus();
            }
          },
        child: MaterialApp(
            theme: ThemeData(
              textTheme: GoogleFonts.robotoTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            home: Scaffold(
              body: Home(),
            )
        ),
      ),
    );
  }

}