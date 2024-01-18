class Constants {
  static String baseUrl = "192.168.1.174:4440";
  static String SocketUrl = "192.168.1.174:4441";

  static Map<String, String> ApiHeaders = {
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  static String authApi = "/api/public/login";
  static String productsApi = "/api/product";
  static String clientApi = "/api/client";
  static String orderApi = "/api/orders";

  String BuildUrl(String apiUrl){
    return baseUrl + apiUrl;
  }
}
