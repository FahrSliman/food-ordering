class CommonResponse<T> {
  T? data;
  int? statusCode;
  String? message;

  CommonResponse.fromJson(Map<String, dynamic> json) {
    try {
      this.statusCode = json['statusCode'];

      if (statusCode == 200) {
        this.data = json['response'];
      } else {
        if (json['response'] != null &&
            json['response'] is Map &&
            json['response']['title'] != null) {
          this.message = json['response']['title'];
          //title can be changed for each api
        } else {
          switch (statusCode) {
            case 400:
             message= '400 Bad requst';

              break;

            case 401:
            message=  '401 Unauthorized';

              break;
            case 404:
             message= '404 path not exist';

              break;

            case 500:
            message=  '500 Internal server eror';

              break;
            case 502:
            message=  '502 proxy eror';

              break;
            case 503:
             message = '503 server unaviliable';

              break;
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  bool get getStatus => statusCode == 200 ? true : false;
}
