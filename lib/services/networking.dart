import 'dart:convert';
import 'package:http/http.dart' as http;

class networkBuilder {
  networkBuilder(this.url);

  final String url;
  late String data;

  Future getMyData() async {
    final uri = Uri.parse(url);
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
