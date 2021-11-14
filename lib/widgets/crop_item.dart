import 'package:fast_farmers/screens/crop_details_screen.dart';
import 'package:fast_farmers/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class CropItem extends StatefulWidget {
  const CropItem(
      {Key key,
      this.image,
      this.cropName,
      this.price,
      this.about,
      this.id,
      this.orderLimit})
      : super(key: key);
  final String id;
  final String image;
  final String cropName;
  final String price;
  final String about;
  final String orderLimit;

  @override
  _CropItemState createState() => _CropItemState();
}

class _CropItemState extends State<CropItem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: MediaQuery.of(context).size.height * 0.39,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.white,
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Hero(
                  tag: 'img${widget.id}',
                  child: Image.network(
                    widget.image,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10, left: 10),
                        width: double.infinity,
                        child: Text(
                          widget.cropName,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.016,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 10, left: 10),
                        width: double.infinity,
                        child: Text(
                          widget.price,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.014,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(right: 15),
                    child:
                        //  ElevatedButton(
                        //   onPressed: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => CropDetailsScreen()));
                        //   },
                        //   child: Text('Place Order'),
                        // ),
                        RoundedButton(
                      vertical: 15,
                      horizontal: 15,
                      elevation: 3,
                      width: size.width * 0.25,
                      textColor: Colors.white,
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CropDetailsScreen(
                                      image: widget.image,
                                      cropName: widget.cropName,
                                      about: widget.about,
                                      price: widget.price,
                                      orderLimit: widget.orderLimit,
                                      id: widget.id,
                                    )));
                      },
                      text: 'Place Order',
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
