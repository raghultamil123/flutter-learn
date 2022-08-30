class Pokemon{
  String name;
  String url;
  Pokemon({required this.name,required this.url});
  factory Pokemon.fromJson(Map<String,dynamic> data){
    return Pokemon(
      name:data['name'],
      url:data['url']
    );
  }

}