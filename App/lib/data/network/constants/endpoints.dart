class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://api-dev.galaxytraco.com/api";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // auth
  static const String loginUrl = "/login";

  // receipt
  static const String receiptUrl = "/packing-receive";
  static const String packingUrl = "/packing";

  // product
  static const String productCategoryUrl = "/product-category";
  static const String productUrl = "/product";

  // receipt
  static const String mainReceiveUrl = "/receive";

  //user
  static const String userUrl = "/user";
}
