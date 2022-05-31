class Station{
  late int id;
  late String name;
  late double lat;
  late double long;
  Station(int id,String nom,double lat,double long){
    this.id=id;
    this.name=nom;
    this.lat=lat;
    this.long=long;

  }
  String getName(){
    return this.name;
  }
  double getLat(){
    return this.lat;
  }
  double getLong(){
    return this.long;
  }
}