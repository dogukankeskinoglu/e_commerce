import 'package:e_commerce/db/database.dart';
import 'package:e_commerce/productDetail.dart';
import 'package:flutter/material.dart';

class ViewMain extends StatefulWidget {
  @override
  _ViewMainState createState() => _ViewMainState();
}

class _ViewMainState extends State<ViewMain> {
  int currentBottomBarIndex;

  @override
  void initState() {
    super.initState();
    currentBottomBarIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(),
      body: buildBody(context),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  AppBar buildAppBar() => AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.blue),
        title: appBarContainer(),
        actions: [Icon(Icons.shopping_cart)],
      );

  Container appBarContainer() {
    return Container(
      height: AppBar().preferredSize.height / 1.5,
      child: Material(
        borderRadius: BorderRadius.circular(20),
        shadowColor: Colors.grey,
        elevation: 10,
        child: appBarTextFormField(),
      ),
    );
  }

  TextFormField appBarTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: "Search Location",
        contentPadding: EdgeInsets.only(top: 5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Container buildBody(context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleItem(),
          sizedBoxEmpty(),
          listViewItem(),
          sizedBoxEmpty(),
          listViewButton(),
          sizedBoxEmpty(),
          discoverItemGridView(context),
        ],
      ),
    );
  }

  Container discoverItemGridView(context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.9,
      child: InkWell(
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            discoverGridViewItem(
                context, "assets/images/Koltuk2.jpg", "Primrose Accent", 240),
            discoverGridViewItem(
                context, "assets/images/Koltuk2.jpg", "Primrose Accent", 240),
            discoverGridViewItem(
                context, "assets/images/Koltuk2.jpg", "Primrose Accent", 240),
            discoverGridViewItem(
                context, "assets/images/Koltuk2.jpg", "Primrose Accent", 240),
          ],
        ),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetail(),
            )),
      ),
    );
  }

  Container discoverGridViewItem(
      context, String imgsrc, String productName, int productPrice) {
    return Container(
      margin: EdgeInsets.only(bottom: 8, right: 8),
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(10)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Image.asset(
          imgsrc,
          height: MediaQuery.of(context).size.height / 6,
          width: MediaQuery.of(context).size.width / 3.5,
          fit: BoxFit.contain,
        ),
        exploreText(productName),
        exploreText("\$${productPrice.toString()}"),
      ]),
    );
  }

  SizedBox listViewButton() {
    return SizedBox(
      height: 20,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: raisedButtonContainer(index, context),
        ),
        itemCount: listbutton.length,
      ),
    );
  }

  Container raisedButtonContainer(int index, BuildContext context) {
    return Container(
      width: listbutton[index].length > 3
          ? MediaQuery.of(context).size.width / 6
          : MediaQuery.of(context).size.width / 8,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: raisedButton(index),
    );
  }

  RaisedButton raisedButton(int index) {
    return RaisedButton(
      textColor: Colors.black,
      color: Colors.red[50],
      elevation: 0,
      onPressed: () {},
      child: Text(
        listbutton[index],
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  SizedBox listViewItem() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Container(
            width: MediaQuery.of(context).size.width / 3.3,
            decoration: BoxDecoration(
                color: mobilyarenk[index],
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/Koltuk1.jpg",
                  height: 60,
                  width: MediaQuery.of(context).size.width / 3.5,
                  fit: BoxFit.contain,
                ),
                exploreText(mobilyalist[index]),
                exploreText("\$${mobilyafiyat[index]}"),
              ],
            ),
          ),
        ),
        itemCount: mobilyalist.length,
      ),
    );
  }

  Text exploreText(String string) {
    return Text(
      string,
      style: TextStyle(color: Colors.white),
    );
  }

  SizedBox sizedBoxEmpty() {
    return SizedBox(
      height: 5,
    );
  }

  Text titleItem() {
    return Text(
      "Explore",
      style: TextStyle(fontSize: 32),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      selectedIconTheme: IconThemeData(color: Colors.black),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      onTap: (value) {
        setState(() {
          currentBottomBarIndex = value;
        });
      },
      currentIndex: currentBottomBarIndex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        BottomNavigationBarItem(
            icon: Icon(Icons.location_searching), title: Text("Discover")),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite), title: Text("Wishlist")),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), title: Text("Settings")),
      ],
      backgroundColor: Colors.blue,
    );
  }
}
