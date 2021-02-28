import 'package:here_you_go_1/models/userModel.dart';
import 'package:here_you_go_1/navdrawer/circular_image.dart';
import 'package:here_you_go_1/navdrawer/zoom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:here_you_go_1/services/ProfilePage.dart';
import 'package:here_you_go_1/src/expenses.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  final String imageUrl =
      "https://celebritypets.net/wp-content/uploads/2016/12/Adriana-Lima.jpg";

  final List<MenuItem> options = [
    MenuItem(Icons.search, 'Search'),
    MenuItem(Icons.money, 'Expense'),
    MenuItem(Icons.favorite, 'Favourite'),
    MenuItem(Icons.location_searching_outlined, 'Location'),
    MenuItem(Icons.format_list_bulleted, 'Blog'),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        //on swiping left
        if (details.delta.dx < -6) {
          Provider.of<MenuController>(context, listen: true).toggle();
        }
      },
      child: Container(
        padding: EdgeInsets.only(
            top: 62,
            left: 32,
            bottom: 8,
            right: MediaQuery.of(context).size.width / 2.9),
        color: Color(0xffaabbc8),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CircularImage(
                    NetworkImage(imageUrl),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                  child: Text(
                    'Tiya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),

                  ),
                )
              ],
            ),
            Spacer(),
            Column(
              children: options.map((item) {
                return ListTile(
                  onTap: (){
                    if(item.title == 'Search')
                    print('hey');
                    if(item.title == 'Expense')
                     {
                       Navigator.push(context,
                           MaterialPageRoute(builder: (context) => Expense()));
                     }
                    if(item.title == 'Favourite')
                      print('ok');
                    if(item.title == 'Blog')
                      print('yo');
                  },
                  leading: Icon(
                    item.icon,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                );
              }).toList(),
            ),
            Spacer(),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.settings,
                color: Colors.white,
                size: 20,
              ),
              title: Text('Settings',
                  style: TextStyle(fontSize: 14, color: Colors.white)),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.person,
                color: Colors.white,
                size: 20,
              ),
              title: Text('Support',
                  style: TextStyle(fontSize: 14, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  String title;
  IconData icon;

  MenuItem(this.icon, this.title);
}