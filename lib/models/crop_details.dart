class CropDetails {
  String cropId;
  String cropName;
  String aboutCrop;
  String cropImage;
  String price;
  String orders;
  String postedBy;
  String addedOn;
  String orderLimit;

  CropDetails(
    this.cropId,
    this.cropName,
    this.aboutCrop,
    this.cropImage,
    this.price,
    this.orders,
    this.postedBy,
    this.addedOn,
    this.orderLimit,
  );

  CropDetails.fromJson(Map<String, dynamic> json) {
    cropId = json['cropId'].toString();
    cropName = json['cropName'];
    aboutCrop = json['aboutCrop'];
    cropImage = json['cropImage'];
    price = json['price'];
    orders = json['orders'].toString();
    postedBy = json['postedBy'];
    addedOn = json['addedOn'];
    orderLimit = json['orderLimit'].toString();
  }
}
