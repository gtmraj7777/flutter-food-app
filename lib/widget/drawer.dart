import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'HomeScreen.dart';
import 'history_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.red[900],
        child: ListView(
          children: [
            DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  accountEmail: Text("gautam@gmail.com"),
                  accountName: Text(
                    "Gautam Rajbhar",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  // currentAccountPicture: Image.asset('assets/images/gautam.jpg'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/gautam.jpg'),
                  ),
                )),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              leading: Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              title: Text(
                "Home",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryScreen()),
                );
              },
              leading: Icon(
                Icons.history,
                color: Colors.white,
              ),
              title: Text(
                "Order History",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () async {
                print("GGGGGGG");

                final phoneNumber = "8448966286";
                final url = 'tel:$phoneNumber';

                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
              leading: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              title: Text(
                "Call",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
