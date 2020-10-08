import 'package:e_commerce/db/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ProductDetail extends StatefulWidget {
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int currentSwipeIndex;
  int sayac;
  bool favouriteState;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentSwipeIndex = 0;
    sayac = 0;
    favouriteState = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(),
      body: body(context),
    );
  }

  AppBar appBar() => AppBar(
        title: Text(
          "Product Details",
          style: TextStyle(color: Colors.blue.shade900),
        ),
        centerTitle: true,
        actions: [Icon(Icons.favorite)],
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blue.shade900),
        elevation: 0,
      );

  SizedBox body(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //emptySizedBox(10),
            Expanded(
              child: swipeImage(context),
              flex: 25,
            ),
            //emptySizedBox(5),
            Expanded(child: swipeButton(), flex: 1),
            //emptySizedBox(5),
            Expanded(child: productCard(), flex: 20),
            emptySizedBox(5),
            Expanded(child: colorPadding(), flex: 5),
            emptySizedBox(20),
            Expanded(
              child: sayacPadding(),
              flex: 5,
            ),
            emptySizedBox(20),
            Expanded(
              child: cardStack(context),
              flex: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget cardStack(BuildContext context) {
    return Row(
      children: [
        Expanded(child: cartFavourite(), flex: 3),
        Expanded(child: cartProcess(context), flex: 10),
      ],
    );
  }

  Widget cartProcess(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        summaryRaisedButton("Add to cart"),
        SizedBox(
          width: 10,
        ),
        summaryRaisedButton("Buy now"),
      ],
    );
  }

  InkWell cartFavourite() {
    return InkWell(
        child: cartFavouriteContainer(), onTap: () => cartSetState());
  }

  void cartSetState() {
    setState(() {
      favouriteState
          ? showSnackBar("Beğenilmekten Vazgeçildi")
          : showSnackBar("Beğenildi");
      favouriteState = !favouriteState;
    });
  }

  Widget cartFavouriteContainer() {
    return Expanded(
      child: Container(
        //margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            border: Border.all(color: Colors.grey)),
        child: Icon(
          Icons.favorite,
          color: favouriteState ? Colors.red : Colors.grey,
        ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      String msg) {
    return scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
    ));
  }

  RaisedButton summaryRaisedButton(String text) {
    return RaisedButton(
      color: Colors.blue[900],
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget sayacPadding() {
    return Row(children: [
      Expanded(
        child: sayacContentAlign(),
        flex: 4,
      ),
      Spacer(
        flex: 10,
      ),
      Expanded(child: toplamParaText(), flex: 3),
    ]);
  }

  Widget toplamParaText() {
    return Text(
      "\$${sayac * 240}",
      style: TextStyle(fontSize: 25),
    );
  }

  Widget sayacContentAlign() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        sayacButton(Icons.add_circle, true),
        Text(sayac.toString()),
        sayacButton(Icons.remove_circle, false),
      ],
    );
  }

  InkWell sayacButton(IconData icon, bool state) {
    return InkWell(
      child: Icon(
        icon,
        color: Colors.grey,
      ),
      onTap: () => updateSayac(state),
    );
  }

  void updateSayac(bool state) {
    setState(() {
      if (state == true) {
        sayac++;
      } else {
        if (sayac <= 0) {
        } else {
          sayac--;
        }
      }
    });
  }

  Widget colorPadding() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [colorTitle(), containerColorCircleAvatar()],
    );
  }

  Row containerColorCircleAvatar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        colorCircleAvatar(Colors.blue),
        SizedBox(width: 5),
        colorCircleAvatar(Colors.red),
        SizedBox(width: 5),
        colorCircleAvatar(Colors.purple),
      ],
    );
  }

  CircleAvatar colorCircleAvatar(Color color) {
    return CircleAvatar(
      radius: 7,
      backgroundColor: color,
    );
  }

  Align colorTitle() => Align(
      alignment: Alignment(-0.97, 0),
      child: FittedBox(
        child: Text("Color",
            style: TextStyle(
              fontSize: 20,
            )),
      ));

  Widget productCard() {
    return Card(
      child: ListTile(
        title: titleText(),
        subtitle: Text(
          resimsubtitle[0],
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ),
    );
  }

  Text titleText() => Text(
        "Primrose Accent",
        style: TextStyle(fontSize: 32, color: Colors.blue[900]),
      );

  SizedBox emptySizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget swipeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: resimlist
          .map((e) => swipeButtonContainer(resimlist.indexOf(e)))
          .toList(),
    );
  }

  CircleAvatar swipeButtonContainer(index) {
    return CircleAvatar(
        radius: 8,
        backgroundColor:
            index == currentSwipeIndex ? Colors.blue : Colors.grey);
  }

  Widget swipeImage(context) {
    return Swiper(
      //autoplayDelay: 200,
      //autoplay: true,

      index: currentSwipeIndex,
      onIndexChanged: (value) {
        setState(() {
          print(currentSwipeIndex);
          currentSwipeIndex = value;
        });
      },
      itemCount: resimlist.length,
      itemBuilder: (context, index) => Container(
        height: 70,
        child: getImage(index),
      ),

      /*itemWidth: MediaQuery.of(context).size.width,
          itemHeight: 400.0,
          layout: SwiperLayout.TINDER*/
    );
  }

  Image getImage(int index) {
    return Image.asset(
      resimlist[index],
      fit: BoxFit.fill,
    );
  }
}
