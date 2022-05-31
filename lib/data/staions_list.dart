import 'package:googleads/classes/Station.dart';

class linge_num {
  late List<Station> stations ;
  late String metro_num ;
  linge_num(this.stations, this.metro_num)  ;

}
class Stations_list {
  static List<Station> All_Stations=[
    Station(0,'Place de Barcelone', 36.79611111, 10.18055556),
    Station(1,'Habib Thameur', 36.80472222, 10.17777778),
    Station(2,'Place de République', 36.80638889, 10.18083333),
    Station(3,'Bab El Khadra', 36.81027778, 10.17250000),
    Station(4,'Bab Laassal', 36.81333333, 10.16805556),
    Station(5,'Bab Saadoun', 36.80972222, 10.16194444),
    Station(6,'Mefteh Sâadallah', 36.81305556, 10.15638889),
    Station(7,'Cité Rommana', 36.82361111, 10.15083333),
    Station(8,'Campus', 36.82611111, 10.14388889),
    Station(9,'14 Janvier',36.82277778, 10.14000000),
    Station(10,'Les Jasmins', 36.82583333, 10.13472222),
    Station(11,'Ettahrir', 36.82916667, 10.12861111),
    Station(12,'Omrane Supérieure', 36.83055556, 10.12388889),
    Station(13,'Ettadhamen', 36.83583333, 10.11777778),
    Station(14,'Intilaka', 36.83916667, 10.11694444),
    Station(15,'Bab Alioua',36.78583333, 10.17972222),
    Station(16,'Mohamed Manachou',36.78222222, 10.17972222),
    Station(17,'13 août', 36.77500000, 10.17916667),
    Station(18,'Mohamed Ali', 36.76777778, 10.18388889),
    Station(19,'Kabaria', 36.75972222, 10.19055556),
    Station(20,'Ibn Sina', 36.75416667, 10.19388889),
    Station(21,'Ouardia 6', 36.75416667, 10.19916667),
    Station(22,'Cité Ennour', 36.75138889,10.20472222),
    Station(23,'A. Chabbi', 36.75250000, 10.21472222),
    Station(24,'Ben Arous', 36.75555556, 10.22027778),
    Station(25,'Ibn Khaldoun', 36.82583333, 10.13472222),
    Station(26,'Tunis Marine', 36.80000000, 10.19277778),
    Station(27,'Farhat Hached', 36.79777778, 10.18611111),
    Station(28,'Den Den', 36.80222222, 10.11083333),
    Station(29,'Artisanat', 36.80277778, 10.11611111),
    Station(30,'Khaznadar', 36.80416667, 10.12166667),

    Station(31,'Bardo', 36.80722222, 10.13527778),
    Station(32,'Boulevard du 20 mars', 36.80833333, 36.80833333),
    Station(33,'Bouchoucha', 36.80916667, 10.14888889),
    Station(34,'Tahar Haddad', 36.76083333,10.18694444),
    Station(35,'Ghazeli', 36.75472222,10.18777778),
    Station(36,'Cité municipale', 36.74833333,10.18888889),
    Station(37,'Ennesri', 36.74500000,10.19027778),
    Station(38,'El Montazah', 36.74277778,10.19361111),
    Station(39,'El Mourouj 2',36.74222222,10.19777778),
    Station(40,'El Mourouj 1', 36.73833333,10.21027778),
    Station(41,'Environnement', 36.73305556,10.21027778),
    Station(42,'El Mourouj 3', 36.72861111,10.21083333),
    Station(43,'Martyrs', 36.72361111,10.21194444),
    Station(44,'El Mourouj 4', 36.71972222,10.21638889),
    Station(45,'Ariana', 36.85972222,10.19750000),
    Station(46,'Indépendance', 36.85444444,10.19583333),
    Station(47,'El Fell', 36.84694444,10.19250000),
    Station(48,'10 décembre 1948', 36.84444444,10.18444444),
    Station(49,'Cité sportive', 36.83861111,10.18194444),
    Station(50,'La Jeunesse', 36.83333333,10.18277778),
    Station(51,'Cité Jardins',36.82333333,10.18555556),
    Station(52,'Palestine', 36.81916667,10.18111111),
    Station(53,'Mohamed V',36.81583333,10.18333333),
    Station(54,'Nelson Mandela', 36.81111111,10.18250000),
  ];
  static   List<Station> stations_linge6  =[All_Stations[26],All_Stations[27],All_Stations[0],All_Stations[15],All_Stations[16],All_Stations[18],All_Stations[34],All_Stations[35],All_Stations[36],All_Stations[37],All_Stations[38],All_Stations[39],All_Stations[40],All_Stations[41],All_Stations[42],All_Stations[43],All_Stations[44]];
  static   List<Station> stations_linge4 =[All_Stations[28],All_Stations[29],All_Stations[30],All_Stations[31],All_Stations[32],All_Stations[33],All_Stations[5],All_Stations[4],All_Stations[3],All_Stations[2],All_Stations[1],All_Stations[0],All_Stations[27],All_Stations[26], ];
  static   List<Station> stations_linge5  =[All_Stations[0],All_Stations[1],All_Stations[2],All_Stations[3],All_Stations[4],All_Stations[5],All_Stations[6],All_Stations[7],All_Stations[8],All_Stations[9],All_Stations[10],All_Stations[11],All_Stations[12],All_Stations[13],All_Stations[14]];
  static   List<Station> stations_linge1  =[All_Stations[26],All_Stations[27],All_Stations[0],All_Stations[15],All_Stations[16],All_Stations[17],All_Stations[18],All_Stations[19],All_Stations[20],All_Stations[21],All_Stations[22],All_Stations[23],All_Stations[24]];
  static   List<Station> stations_linge3  =[All_Stations[26],All_Stations[27],All_Stations[0],All_Stations[1],All_Stations[2],All_Stations[3],All_Stations[4],All_Stations[5],All_Stations[6],All_Stations[7],All_Stations[8],All_Stations[9],All_Stations[10],All_Stations[25],];

  static   List<Station> stations_linge2  =[All_Stations[45],All_Stations[46],All_Stations[47],All_Stations[48],All_Stations[49],All_Stations[50],All_Stations[3],All_Stations[51],All_Stations[52],All_Stations[53],All_Stations[54],All_Stations[0],];



  // static   List<String>All_Stations  = (stations_linge1+stations_linge2+stations_linge3+stations_linge4+stations_linge5+stations_linge6).toSet().toList() ;

  static List<linge_num> metro_list =[
    linge_num(stations_linge1,'1') ,
    linge_num(stations_linge2,'2') ,
    linge_num(stations_linge3,'3') ,
    linge_num(stations_linge4,'4') ,
    linge_num(stations_linge5,'5') ,
    linge_num(stations_linge6,'6') ,
  ];


}