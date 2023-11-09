import 'package:anitection/models/animal/animal.dart';
import 'package:anitection/models/base.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

@RestApi(baseUrl: "https://anitection-strapi.yumekiti.net")
abstract class AnitectionClient {
  factory AnitectionClient(Dio dio, {String baseUrl}) = _AnitectionClient;

  @GET("/api/animals?populate=*")
  Future<ArrayData<Model<AnimalAttributes>>> getAnimals();


}