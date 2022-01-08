import 'package:fast_farmers/constants.dart';
import 'package:fast_farmers/providers/crop_api_manager.dart';
import 'package:fast_farmers/widgets/rounded_button.dart';
import 'package:fast_farmers/widgets/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddNewCropScreen extends StatefulWidget {
  const AddNewCropScreen({Key? key}) : super(key: key);

  @override
  _AddNewCropScreenState createState() => _AddNewCropScreenState();
}

class _AddNewCropScreenState extends State<AddNewCropScreen> {
  final _formKey = GlobalKey<FormState>();

  final _cropNameFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _orderLimitFocusNode = FocusNode();
  final _aboutFocusNode = FocusNode();

  String? cropName;
  String? price;
  String? orderLimit;
  String? about;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(addNewCropScreenTitle),
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'New Crop',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      RoundedInputField(
                        backgroundColor: kPrimaryLightColor,
                        borderColor: kPrimaryColor,
                        textInputAction: TextInputAction.next,
                        focusNode: _cropNameFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        hintText: 'Enter Crop Name *',
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Name of the crop is required.';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          cropName = value!;
                        },
                      ),
                      const SizedBox(height: 20),
                      RoundedInputField(
                        backgroundColor: kPrimaryLightColor,
                        borderColor: kPrimaryColor,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_orderLimitFocusNode);
                        },
                        hintText: 'Enter Price *',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Price is required.';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          price = value;
                        },
                      ),
                      const SizedBox(height: 20),
                      RoundedInputField(
                        backgroundColor: kPrimaryLightColor,
                        borderColor: kPrimaryColor,
                        textInputAction: TextInputAction.next,
                        focusNode: _orderLimitFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_aboutFocusNode);
                        },
                        hintText: 'Enter Order Limit *',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(5),
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            _orderLimitFocusNode.requestFocus();
                            return 'Order Limit is required.';
                          }

                          if (double.parse(value) < 0) {
                            _orderLimitFocusNode.requestFocus();
                            return 'Enter a valid number';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          orderLimit = value;
                        },
                      ),
                      const SizedBox(height: 20),
                      RoundedInputField(
                        backgroundColor: kPrimaryLightColor,
                        borderColor: kPrimaryColor,
                        // textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        focusNode: _aboutFocusNode,
                        hintText: 'About Crop *',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'About is required.';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          about = value;
                        },
                      ),
                      const SizedBox(height: 20),
                      RoundedButton(
                        vertical: 20,
                        horizontal: 20,
                        width: size.width * 0.8,
                        text: "Upload Image",
                        color: kPrimaryLightColor,
                        textColor: kPrimaryColor,
                        press: () {},
                      ),
                      const SizedBox(height: 20),
                      RoundedButton(
                        vertical: 20,
                        horizontal: 20,
                        width: size.width * 0.8,
                        text: "ADD",
                        textColor: Colors.white,
                        press: () {
                          _saveForm();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    await CropApiManager().addNewCrop(cropName!, price!, orderLimit!, about!);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _cropNameFocusNode.dispose();
    _priceFocusNode.dispose();
    _orderLimitFocusNode.dispose();
    _aboutFocusNode.dispose();
    super.dispose();
  }
}
