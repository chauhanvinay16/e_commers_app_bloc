


class StringHelper{
  static final StringHelper _singleton = StringHelper._internal();

  factory StringHelper() {
    return _singleton;
  }

  StringHelper._internal();

  static const String login="Login";
  static const String Profile="PROFILE";
  static const String enteremail="Enter Email";
  static const String enterpassword="Enter Password";
  static const String Somthingwrong="Opps Somthing Want To Wrong !";
  static const String name="Name";
  static const String addProduct="Add Product";
  static const String title="Title";
  static const String edit="Edit";
  static const String updateproduct="Update Product";
  static const String enmail="Email";
  static const String submit="Submit";
  static const String product="Product";
  static const String productdetail="Product Detail";
  static const String description="Desscription";
  static const String category="Category";
  static const String price="Price";
}