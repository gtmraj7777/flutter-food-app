import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_food_app/model/Food.dart';
import 'package:flutter_food_app/model/Order.dart';
import 'package:flutter_food_app/utils/order_database.dart';
import 'package:url_launcher/url_launcher.dart';

class FoodDetails extends StatefulWidget {
  late Food food;

  FoodDetails(this.food);

  @override
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  int count = 0;
  int totalBill() {
    int totalBill = 0;

    int price = int.parse(widget.food.foodPrice);

    return price * count;
  }

  void incrementCount() {

    if(count == 5 )
      {


        Dialog errorDialog = Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
          child: Container(
            height: 130.0,
            width: 320.0,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:  EdgeInsets.all(5.0),
                  child: Text('Quantity is not more than 5', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 25.0),),
                ),

                Padding(padding: EdgeInsets.only(top: 10.0)),
                TextButton(onPressed: () {


                  Navigator.of(context).pop();
                },
                    child: Text('OK', style: TextStyle(color: Colors.green, fontSize: 25.0,fontWeight: FontWeight.bold),))
              ],
            ),
          ),
        );
        showDialog(context: context, builder: (BuildContext context) => errorDialog);
      }
    else
    ++count;

    setState(() {});
  }

  void decrementCount() {



    if (count > 0)
      --count;
    else{



      Dialog errorDialog = Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
          height: 180.0,
          width: 250.0,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.all(5.0),
                child: Text('Quantity is ZERO', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 35.0),),
              ),

              Padding(padding: EdgeInsets.only(top: 10.0)),
              TextButton(onPressed: () {


                Navigator.of(context).pop();
              },
                  child: Text('OK', style: TextStyle(color: Colors.green, fontSize: 25.0,fontWeight: FontWeight.bold),))
            ],
          ),
        ),
      );
      showDialog(context: context, builder: (BuildContext context) => errorDialog);
    }

    setState(() {});
  }

  int orederID() {
    int orderid = 0;
    var rng = Random();
    for (var i = 0; i < 10; i++) {
      print(rng.nextInt(100));
      orderid = rng.nextInt(100);
    }

    return orderid;
  }

  String currentTime() {
    DateTime dateToday = new DateTime.now();
    String date = dateToday.toString().substring(0, 10);
    print(date); // 2021-06

    return date;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Odering...'),
          backgroundColor: Colors.red,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30.0,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage(widget.food.foodImage),
                  width: 200.0,
                  height: 200.0,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Center(
                  child: Text(
                widget.food.foodName,
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              )),
              SizedBox(
                height: 8.0,
              ),
              Center(
                  child: Text(
                '₹ ${widget.food.foodPrice}',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              )),
              SizedBox(
                height: 12.0,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(" "),
                    Text(""),
                    RaisedButton(
                        child: Text(
                          "-",
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          decrementCount();
                        }),
                    Text(
                      "$count",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    RaisedButton(
                        child: Text(
                          "+",
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          incrementCount();
                        }),
                    Text(""),
                    Text(" "),
                  ],
                ),
              ),
              SizedBox(
                height: 45.0,
              ),
              Container(
                child: Text(
                  "Total Bill ₹ ${totalBill()}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              RaisedButton(
                  child: Text("ORDER NOW"),
                  color: Colors.lightGreen,
                  onPressed: () async {
                    if (count != 0) {
                      final toEmail = '';
                      final subject =
                          'Your Zomato summary for ${widget.food.foodName}';
                      final message = '''
                       Order Summary
                       
                Order No: ${orederID()}
                Order placed at : ${currentTime()}
                Food Item : ${widget.food.foodName}
                Item Quantity : ${count}
                Total Bill : ₹ ${totalBill()}       
                       
                
                
                Enjoy the ${widget.food.foodName} .....
                
                ''';

                      print(message);
                      final url =
                          'mailto:$toEmail?subject=${subject}&body=${message}';

                      if (await canLaunch(url)) {
                        await launch(url);
                      }

                      final order = new Order(
                          foodImage: '${widget.food.foodImage}',
                          foodName: '${widget.food.foodName}',
                          foodPrice: '${widget.food.foodPrice}',
                          foodQuantity: "${count}",
                          foodTotalPrice: '${totalBill()}');
                      OrderDatabase.instance.create(order);
                    } else {

                      Dialog errorDialog = Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
                        child: Container(
                          height: 150.0,
                          width: 250.0,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:  EdgeInsets.all(5.0),
                                child: Text('Please Select ...', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 35.0),),
                              ),

                              Padding(padding: EdgeInsets.only(top: 10.0)),
                              TextButton(onPressed: () {


                                Navigator.of(context).pop();
                              },
                                  child: Text('OK', style: TextStyle(color: Colors.green, fontSize: 25.0,fontWeight: FontWeight.bold),))
                            ],
                          ),
                        ),
                      );

                      showDialog(context: context, builder: (BuildContext context) => errorDialog);




                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
