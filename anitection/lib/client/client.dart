import 'package:anitection/models/animal/animal.dart';
import 'package:anitection/models/auth/auth_result.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/models/institution/institution.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

@RestApi(baseUrl: "https://anitection-api.yumekiti.net")
abstract class AnitectionClient {
  factory AnitectionClient(Dio dio, {String baseUrl}) = _AnitectionClient;

  @POST("/api/auth/local")
  Future<AuthResult> login(@Body() Map<String, dynamic> request);
  
  @POST("api/auth/local/register")
  Future<AuthResult> register(@Body() Map<String, dynamic> request);

  @GET("/api/animals")
  Future<PagingData<Model<AnimalAttributes>>> getAnimals();

  @GET("/api/animals/{id}")
  Future<SingleData<Model<AnimalAttributes>>> getAnimal(@Path("id") int id);

  @GET("/api/institutions/{id}")
  Future<SingleData<Model<InstitutionAttributes>>> getInstitution(@Path("id") int id);
}