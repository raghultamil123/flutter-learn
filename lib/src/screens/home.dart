import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/src/bloc/pokemon_list_bloc.dart';
import 'package:untitled/src/utils/extensions.dart';

import '../bloc/bloc_provider.dart';
import '../model/pokemon.dart';
import '../model/response.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int startValue = 0;
  bool valueEnd = false;
  int beforesize = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startValue = 0;
    valueEnd = false;
    beforesize = 0;
  }



  @override
  Widget build(BuildContext context) {


    final bloc = BlocProvider.of<PokemonListBloc>(context);

    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor,elevation: 0,),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text("PokeDex",style: TextStyle(
            color: Colors.blue[900],
            fontSize: 50,
            fontWeight: FontWeight.w900
          ),),
          Text("Search for pokemon by using name",style: TextStyle(
            fontSize: 18,
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  
                  child: Card(
                    elevation: 6.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0)
                        )
                      ),
                      child: TextFormField(
                      initialValue: "Search",
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.white
                          )

                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(5.0)
                        ),
                        prefixIcon: Icon(Icons.search)
                      ),
              ),
                    ),
                  ),
                ),
              IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt))]
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification){
                if(scrollNotification is ScrollEndNotification){
                  print(startValue);
                  if(!valueEnd ){
                    startValue += 20;
                    bloc.loadMore(startValue);

                  }

                }
                return true;
              },
              child: StreamBuilder<List<Pokemon>?>(
                stream: bloc.pokemonListStream,
                builder: (context, AsyncSnapshot<List<Pokemon>?> snapshot) {
                  if(!snapshot.hasData || snapshot.data == null){
                    return Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          value: null,
                        ),
                      ),
                    );
                  }
                  if(beforesize >= snapshot.data!.length){
                    valueEnd = true;
                  }
                  beforesize = snapshot.data!.length;
                  return CustomScrollView(
                    slivers: [
                      PokemonList(pokemons:snapshot.data!)
                    ],
                  );
                }
              ),
            ),
          )
          ]
        ),
      ),
    );
  }
}

class PokemonList extends StatelessWidget {




  Map<int,Color> colors = {
    0:Colors.green,
     1:Colors.purple,
      2:Colors.redAccent,
    3:Colors.greenAccent,
  };

  List<Pokemon> pokemons;
  PokemonList({Key? key, required this.pokemons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.0/1.4

        ),
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return Card(

              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              color: colors[index % 4]?.withOpacity(0.7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                 SvgPicture.network("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/${index + 1}.svg",width: 50,fit: BoxFit.fill,),

                  Text(pokemons[index].name.capitalize(),style:  TextStyle(
                   color: Colors.blue[900],
                    fontSize:17,
                    fontWeight: FontWeight.w600
                  ),),
                  Text(index.toString(),style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey
                  ),)
                ],
              ),
            );
          },
          childCount: pokemons.length,
        ));
  }

}