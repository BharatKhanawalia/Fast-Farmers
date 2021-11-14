import 'package:flutter/material.dart';

import 'package:fast_farmers/constants.dart';
import 'package:fast_farmers/models/crop_details.dart';
import 'package:fast_farmers/screens/add_new_crop_screen.dart';
import 'package:fast_farmers/screens/login_screen.dart';
import 'package:fast_farmers/screens/orders_screen.dart';
import 'package:fast_farmers/screens/posted_crops_screen.dart';
import 'package:fast_farmers/widgets/crop_item.dart';
import 'package:fast_farmers/providers/crop_api_manager.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen(
      {Key key, this.farmer = false, this.loggedIn = false, this.email = ''})
      : super(key: key);
  final bool farmer;
  final bool loggedIn;
  final String email;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Map<String, String> param = {'imageName': '', 'cropName': ''};

class _HomeScreenState extends State<HomeScreen> {
  List<CropDetails> _crops = <CropDetails>[];

  @override
  void initState() {
    CropApiManager().fetchCrops().then((value) {
      setState(() {
        _crops.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: 90,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  border: Border(bottom: BorderSide(color: kPrimaryColor)),
                ),
                child: Center(
                  child: Text(
                    widget.loggedIn ? widget.email : appTitle,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            if (widget.loggedIn) drawerItemPop(Icons.home, 'Home'),
            if (widget.loggedIn && widget.farmer)
              drawerItemPush(
                  Icons.add_box_rounded, 'Add New Crop', AddNewCropScreen()),
            if (widget.loggedIn && widget.farmer)
              drawerItemPush(Icons.list, 'Posted Crops', PostedCropsScreen()),
            if (widget.loggedIn && widget.farmer)
              drawerItemPush(Icons.shopping_bag, 'Orders', OrdersScreen()),
            if (!widget.loggedIn)
              drawerItemPush(Icons.login, 'Login', LoginScreen()),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  circularCrops('maize', 'Maize'),
                  SizedBox(width: 8),
                  circularCrops('millets', 'Millets'),
                  SizedBox(width: 8),
                  circularCrops('rice', 'Rice'),
                  SizedBox(width: 8),
                  circularCrops('sugarcane', 'Sugarcane'),
                  SizedBox(width: 8),
                  circularCrops('wheat', 'Wheat')
                ],
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Explore All Crops',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _crops.length,
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.all(10),
                  child: CropItem(
                    image: _crops[index].cropImage,
                    cropName: _crops[index].cropName,
                    price: _crops[index].price,
                    about: _crops[index].aboutCrop,
                    id: _crops[index].cropId,
                    orderLimit: _crops[index].orderLimit,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget circularCrops(String cropImageName, String cropName) {
    return Column(
      children: [
        CircleAvatar(
          radius: 62,
          backgroundColor: kPrimaryColor,
          child: CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/$cropImageName.jpg'),
          ),
        ),
        Text(
          cropName,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget drawerItemPop(IconData icons, String drawerItemName) {
    return ListTile(
      leading: Icon(icons),
      title: Text(drawerItemName),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget drawerItemPush(IconData icons, String drawerItemName, Widget screen) {
    return ListTile(
      leading: Icon(icons),
      title: Text(drawerItemName),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screen));
      },
    );
  }
}
