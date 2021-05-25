import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiRequest {
  static final String url = 'https://type.fit/api/quotes';

  static Future<List<Quote>> fetchQuotes() async {
    List<Quote> quote = [];

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> list = data;
      // return list.map((e) => Quote.fromMap(e)).toList();
      list.forEach((element) => quote.add(Quote.fromMap(element)));
      print(list);
      return quote;
    } else {
      throw Exception('Unable to fetch data');
    }
  }
}

class Quote {
  final String text;
  final String author;
  Quote({
    required this.text,
    required this.author,
  });

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      text: map['text'] ?? '',
      author: map['author'] ?? '',
    );
  }
}
