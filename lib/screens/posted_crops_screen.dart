import 'package:fast_farmers/constants.dart';
import 'package:flutter/material.dart';

class PostedCropsScreen extends StatefulWidget {
  const PostedCropsScreen({Key key}) : super(key: key);

  @override
  _PostedCropsScreenState createState() => _PostedCropsScreenState();
}

class _PostedCropsScreenState extends State<PostedCropsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(postedCropsScreenTitle),
      ),
    );
  }
}
