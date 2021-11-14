import 'dart:convert';

import 'package:fast_farmers/constants.dart';
import 'package:http/http.dart' as http;
import 'package:fast_farmers/models/crop_details.dart';

class CropApiManager {
  Future<List<CropDetails>> fetchCrops() async {
    final response = await http.get(Uri.parse(getUrl));
    var crops = <CropDetails>[];
    if (response.statusCode == 200) {
      var cropsJson = json.decode(response.body);
      print(cropsJson);
      for (var cropJson in cropsJson) {
        crops.add(CropDetails.fromJson(cropJson));
      }
    }
    return crops;
  }

  Future<void> addNewCrop(String cropName, String cropPrice, String orderLimit,
      String aboutCrop) async {
    try {
      final response = await http.post(Uri.parse(postUrl), body: {
        'cropName': cropName,
        'cropPrice': cropPrice,
        'orderLimit': orderLimit,
        'aboutCrop': aboutCrop,
      });
      print(response.body);
    } catch (error) {
      print(error);
      throw (error);
    }
  }
}
