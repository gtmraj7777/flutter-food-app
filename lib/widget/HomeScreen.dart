import 'package:flutter/material.dart';
import 'package:flutter_food_app/model/Food.dart';
import 'package:flutter_food_app/widget/food_details.dart';
import 'package:url_launcher/url_launcher.dart';

import 'drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Food> foods = [
    Food("assets/images/momos.jpg", "Momos", "35"),
    Food("assets/images/bonda.jpg", "Bonda", "15"),
    Food("assets/images/champaranmeat.jfif", "Champaran", "600"),
    Food("assets/images/dhuska.jpg", "Dhuska", "20"),
    Food("assets/images/alooparatha.jpg", "Paratha", "20"),
    Food("assets/images/chilkaroti.jpg", "Chilka Roti", "15"),
    Food("assets/images/jalebi.jpg", "Jalebi", "12"),
    Food("assets/images/lassi.jpg", "Lassi", "10"),
    Food("assets/images/mushroomcurry.gif", "MushRoom", "35"),
    Food("assets/images/panipuri.jpg", "Pani Puri", "5"),
    Food("assets/images/khir.png", "Khir", "25"),
    Food("assets/images/pastry.jpg", "Pastry", "20"),
    Food("assets/images/liitichokha.jpg", "Litti Chokha", "20"),
    Food("assets/images/lucknowibiryani.gif", "Lucknowi", "120"),
    Food("assets/images/roti.jfif", "Roti", "5"),
    Food("assets/images/rusgulla.jpg", "Rusgulla", "25"),
    Food("assets/images/samosa.jfif", "Samosa", "5"),
    Food("assets/images/vadapow.webp", "Vada Pow", "12"),
    Food("assets/images/chowmein.jfif", "Chowmein", "40"),
    Food("assets/images/cake.jpg", "Cake", "150"),
  ];

  Widget itemTemplate(Food food) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FoodDetails(food)),
        );
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: new BorderRadius.circular(10.0),
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage(food.foodImage),
                width: 100.0,
                height: 100.0,
              ),
            ),
            Column(
              children: [
                Container(
                    //color: Colors.lightBlue,
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0.0, 0.0, 10),
                  child: Text(
                    '${food.foodName}',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink),
                  ),
                )),
                Container(
                    //color: Colors.lightBlue,
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10),
                  child: Text(
                    '₹ ${food.foodPrice}',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        fontFamily: 'Georgia',
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Zomato Clone"),
          backgroundColor: Colors.red,
          actions: [],
        ),
        body: ListView.builder(
            itemCount: foods.length,
            itemBuilder: (BuildContext context, int index) {
              return itemTemplate(foods[index]);
            }),
        drawer: MyDrawer(),
      ),
    );
  }

  Widget callButton() => IconButton(
      icon: Icon(Icons.phone),
      onPressed: () async {
        final phoneNumber = "8448966286";
        final url = 'tel:$phoneNumber';

        if (await canLaunch(url)) {
          await launch(url);
        }
      });
}
