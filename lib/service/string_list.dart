import 'package:dio/dio.dart';

class StringListService{
  final url = "https://baconipsum.com/api/?type=meat-and-filler.";
  final imageUrl = "https://picsum.photos/200/300/?random";
  Dio dio = Dio();

  Future<List<String>> getStringList() async {
   final res = await dio.get(url);
   return List<String>.from(res.data).map((e) => e.toString()).toList();
  }

  Future<String> getImages() async {
    final res = await dio.get(imageUrl);
    return res.toString();
  }
}

