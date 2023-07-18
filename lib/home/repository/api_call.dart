import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiCall {
  String? _apikey;

  ApiCall() {
    getApiKey();
  }

  void getApiKey() {
    _apikey = const String.fromEnvironment('OPENAIKEY');
    if (_apikey == null || _apikey!.isEmpty) {
      throw Exception('OPENAIKEY not found');
    }
  }

  Future<String> sendRequest(String message) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_apikey',
    };
    final body = json.encode({
      'model': 'gpt-3.5-turbo',
      'messages': [
        {'role': 'user', 'content': message}
      ],
      'temperature': 0.7,
    });
    try {
      final response = await http.post(
          Uri.parse("https://api.openai.com/v1/chat/completions"),
          headers: headers,
          body: body);
      // print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse['choices'][0]['message']['content'].toString();
      } else {
        return "Error ${response.statusCode}";
      }
    } catch (e) {
      print(e);
      return "Error";
    }
  }
}
