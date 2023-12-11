import 'dart:developer';

import 'package:anitection/models/animal/animal.dart';
import 'package:anitection/models/auth/auth_result.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/models/institution/institution.dart';
import 'package:anitection/models/pattern/pattern.dart';
import 'package:anitection/models/user/user.dart';
import 'package:anitection/repositories/token_repository.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

@RestApi(baseUrl: "https://anitection-api.yumekiti.net/")
abstract class AnitectionClient {
  factory AnitectionClient(Dio dio, {String baseUrl}) = _AnitectionClient;

  @GET("/api/users/me")
  Future<User> me();

  @POST("/api/auth/local")
  Future<AuthResult> login(@Body() Map<String, dynamic> request);

  @POST("/api/auth/local/register")
  Future<AuthResult> register(@Body() Map<String, dynamic> request);

  @GET("/api/animals")
  Future<PagingData<Model<AnimalAttributes>>> getAnimals();

  @GET("/api/animals/{id}")
  Future<SingleData<Model<AnimalAttributes>>> getAnimal(@Path("id") int id);

  @GET("/api/institutions/{id}")
  Future<SingleData<Model<InstitutionAttributes>>> getInstitution(
      @Path("id") int id);

  @GET("/api/patterns")
  Future<PagingData<Model<PatternAttributes>>> getPatterns(
    @Query("pagination[page]") int? page,
  );

  //
  // @GET("/api/animals")
  // Future<PagingData<Model<AnimalAttributes>>> searchAnimals(
  // @Query("filters[animal_kind][name][\$eq]") String? animalKind,
  // @Query("filters[size][\$eq]") String? size,
  // @Query("filters[hair_length][\$eq]") String? hairLength,
  // @Query("filters[age][\$gte]") int? ageGte,
  // @Query("filters[age][\$lte]") int? ageLte,
  // );
  //
  @GET("/api/animals")
  Future<PagingData<Model<AnimalAttributes>>> searchAnimals(
    @Queries() Map<String, dynamic> query,
  );
}

AnitectionClient create(
  TokenRepository service,
) {
  final dio = Dio();

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final token = await service.get();
      log("token: $token");
      if (token != null) {
        options.headers['Authorization'] = "Bearer $token";
      }

      handler.next(options);
    },
  ));
  return AnitectionClient(dio);
}
