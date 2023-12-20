// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AnitectionClient implements AnitectionClient {
  _AnitectionClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://anitection-api.yumekiti.net/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<User> me() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<User>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/users/me',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = User.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AuthResult> login(Map<String, dynamic> request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<AuthResult>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/auth/local',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AuthResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AuthResult> register(Map<String, dynamic> request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<AuthResult>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/auth/local/register',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AuthResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PagingData<Model<AnimalAttributes>>> getAnimals() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PagingData<Model<AnimalAttributes>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/animals',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PagingData<Model<AnimalAttributes>>.fromJson(
      _result.data!,
      (json) => Model<AnimalAttributes>.fromJson(
        json as Map<String, dynamic>,
        (json) => AnimalAttributes.fromJson(json as Map<String, dynamic>),
      ),
    );
    return value;
  }

  @override
  Future<SingleData<Model<AnimalAttributes>>> getAnimal(int id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleData<Model<AnimalAttributes>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/animals/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SingleData<Model<AnimalAttributes>>.fromJson(
      _result.data!,
      (json) => Model<AnimalAttributes>.fromJson(
        json as Map<String, dynamic>,
        (json) => AnimalAttributes.fromJson(json as Map<String, dynamic>),
      ),
    );
    return value;
  }

  @override
  Future<SingleData<Model<InstitutionAttributes>>> getInstitution(
      int id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SingleData<Model<InstitutionAttributes>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/institutions/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SingleData<Model<InstitutionAttributes>>.fromJson(
      _result.data!,
      (json) => Model<InstitutionAttributes>.fromJson(
        json as Map<String, dynamic>,
        (json) => InstitutionAttributes.fromJson(json as Map<String, dynamic>),
      ),
    );
    return value;
  }

  @override
  Future<PagingData<Model<PatternAttributes>>> getPatterns(int? page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'pagination[page]': page};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PagingData<Model<PatternAttributes>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/patterns',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PagingData<Model<PatternAttributes>>.fromJson(
      _result.data!,
      (json) => Model<PatternAttributes>.fromJson(
        json as Map<String, dynamic>,
        (json) => PatternAttributes.fromJson(json as Map<String, dynamic>),
      ),
    );
    return value;
  }

  @override
  Future<PagingData<Model<PedigreeAttributes>>> getPedigree(int? page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'pagination[page]': page};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PagingData<Model<PedigreeAttributes>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/pedigrees',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PagingData<Model<PedigreeAttributes>>.fromJson(
      _result.data!,
      (json) => Model<PedigreeAttributes>.fromJson(
        json as Map<String, dynamic>,
        (json) => PedigreeAttributes.fromJson(json as Map<String, dynamic>),
      ),
    );
    return value;
  }

  @override
  Future<PagingData<Model<AnimalAttributes>>> searchAnimals(
      Map<String, dynamic> query) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(query);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PagingData<Model<AnimalAttributes>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/animals',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PagingData<Model<AnimalAttributes>>.fromJson(
      _result.data!,
      (json) => Model<AnimalAttributes>.fromJson(
        json as Map<String, dynamic>,
        (json) => AnimalAttributes.fromJson(json as Map<String, dynamic>),
      ),
    );
    return value;
  }

  @override
  Future<PagingData<Model<FavoriteAttributes>>> getFavorites(int? page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'pagination[page]': page};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PagingData<Model<FavoriteAttributes>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/favorites',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PagingData<Model<FavoriteAttributes>>.fromJson(
      _result.data!,
      (json) => Model<FavoriteAttributes>.fromJson(
        json as Map<String, dynamic>,
        (json) => FavoriteAttributes.fromJson(json as Map<String, dynamic>),
      ),
    );
    return value;
  }

  @override
  Future<void> createFavorite(Map<String, dynamic> request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request);
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/api/favorites',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
