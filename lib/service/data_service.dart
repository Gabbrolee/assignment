import 'package:dio/dio.dart';

class DataService {
  static const url = "https://baconipsum.com/api/?type=meat-and-filler";
  static const imageUrl = "https://picsum.photos/200/300/?random";


  Dio dio = Dio();

  Future<List<String>> getData() async {
   final res = await dio.get(url);
   return List<String>.from(res.data).map((e) => e.toString()).toList();
  }
}

