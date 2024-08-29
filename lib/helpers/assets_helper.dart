


class AssetsHelper{
  static final AssetsHelper _singleton = AssetsHelper._internal();

  factory AssetsHelper() {
    return _singleton;
  }

  AssetsHelper._internal();

  static const String splashImage="assets/ecom1.png";
}