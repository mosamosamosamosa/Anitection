import 'dart:developer';

import 'package:anitection/models/animal/animal.dart';
import 'package:anitection/models/animal/favorite/favorite.dart';
import 'package:anitection/models/auth/auth_result.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/models/institution/institution.dart';
import 'package:anitection/models/pattern/pattern.dart';
import 'package:anitection/models/pedigree/pedigree.dart';
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

  @GET("/api/pedigrees")
  Future<PagingData<Model<PedigreeAttributes>>> getPedigree(
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

  // favorites
  @GET("/api/favorites")
  Future<PagingData<Model<FavoriteAttributes>>> getFavorites(
    @Query("pagination[page]") int? page,
  );

  // create favorite
  @POST("/api/favorites")
  Future<void> createFavorite(
    @Body() Map<String, dynamic> request,
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
      options.headers['Content-Type'] = "application/json";
      // add content length header
      options.headers['Content-Length'] = options.data?.length ?? 0;
      logCurlCommand(options);
      handler.next(options);
    },
    onResponse: (response, handler) {
      if (response.statusCode == 401) {
        service.save(token: null);
      }
      handler.next(response);
    },
  ));
  return AnitectionClient(dio);
}

void logCurlCommand(RequestOptions options) {
  final method = options.method;
  final url = options.uri;
  final headers = options.headers;
  final data = options.data;
  final queryParameters = options.queryParameters;

  final curlCommand = StringBuffer("curl -X $method ");

  headers.forEach((key, value) {
    curlCommand.write("-H '$key: $value' ");
  });

  if (data != null) {
    curlCommand.write("-d '$data' ");
  }

  curlCommand.write("'$url'");

  if (queryParameters.isNotEmpty) {
    curlCommand.write("?");
    final keys = queryParameters.keys.toList();
    for (int i = 0; i < keys.length; i++) {
      final key = keys[i];
      final value = queryParameters[key];
      curlCommand.write("$key=$value");
      if (i != keys.length - 1) {
        curlCommand.write("&");
      }
    }
    curlCommand.write("'");
  }

  log(curlCommand.toString());
}