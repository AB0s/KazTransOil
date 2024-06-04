import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> fetchInfo(int type,int page, int pageSize) async {
  var url = Uri.parse('https://www.mbportal.kz/api/info?InfoType=$type&Page=$page&PageSize=$pageSize');

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    var items = data['items'];
    return items ?? [];
  } else {
    print('Request failed with status: ${response.statusCode}');
    return [];
  }
}
