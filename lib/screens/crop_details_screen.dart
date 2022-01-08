import 'package:fast_farmers/constants.dart';
import 'package:flutter/material.dart';

class CropDetailsScreen extends StatefulWidget {
  const CropDetailsScreen({
    Key? key,
    this.image,
    this.cropName,
    this.price,
    this.about,
    this.orderLimit,
    this.id,
  }) : super(key: key);
  final String? id;
  final String? image;
  final String? cropName;
  final String? price;
  final String? about;
  final String? orderLimit;
  @override
  _CropDetailsScreenState createState() => _CropDetailsScreenState();
}

class _CropDetailsScreenState extends State<CropDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cropName!),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Hero(
                tag: 'img${widget.id}',
                child: Image.network(
                  widget.image!,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About Crop:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(widget.about!),
                  const SizedBox(height: 10),
                  const Text(
                    'Price:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(widget.price!),
                  const SizedBox(height: 10),
                  const Text(
                    'Order Limit:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(widget.orderLimit!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
