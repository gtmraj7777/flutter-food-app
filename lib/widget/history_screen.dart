import 'package:flutter/material.dart';
import 'package:flutter_food_app/model/Order.dart';
import 'package:flutter_food_app/utils/order_database.dart';

import 'drawer.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Order> orders = [];

  String currentTime() {
    DateTime dateToday = new DateTime.now();
    String date = dateToday.toString().substring(0, 10);
    print(date); // 2021-06-24

    return date;
  }

  @override
  void initState() {
    super.initState();
    print("init");
    loadData();
  }

  Future loadData() async {
    print("before fetch");
    orders = await OrderDatabase.instance.readAllOreders();
    print("after fetch");
    setState(() {});
  }

  Widget itemTemplate(Order order) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: new BorderRadius.circular(10.0),
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage(order.foodImage),
                width: 50.0,
                height: 50.0,
              ),
            ),
            Text(
              "${order.foodName}",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            Text(
              "₹ ${order.foodPrice}",
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange),
            ),
            Text(
              "Qty :  ${order.foodQuantity}",
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange),
            ),
            Column(
              children: [
                Text(
                  "Bill ₹ ${order.foodTotalPrice}",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
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
          title: Text("Order History"),
          backgroundColor: Colors.red,
        ),
        body: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (BuildContext context, int index) {
              return itemTemplate(orders[index]);
            }),
        drawer: MyDrawer(),
      ),
    );
  }
}
