// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'dart:io';

import 'package:deps/packages/dio.dart';
import 'package:deps/packages/dio_smart_retry.dart';
import 'package:deps/packages/fpdart.dart';
import 'package:deps/packages/injectable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/_core/commons/enums/request_type.enum.dart';
import 'package:infrastructure/_core/commons/failures/parsing_failures.dart';
import 'package:infrastructure/_core/commons/failures/unexpected_failures.dart';
import 'package:infrastructure/_core/commons/typedefs/either.typedef.dart';
import 'package:infrastructure/_core/commons/typedefs/model_from_json.typedef.dart';
import 'package:infrastructure/analytics/failure/failure.dart';
import 'package:infrastructure/analytics/reporters/i_logger.dart';
import 'package:infrastructure/networking/api_client/dio/dio_failure.dart';
import 'package:infrastructure/networking/api_client/dio/dio_token_refresh.dart';
import 'package:infrastructure/networking/api_client/dio/interceptors/dio_http_failures_interceptor.dart';
import 'package:infrastructure/networking/api_client/dio/interceptors/dio_other_failures_interceptor.dart';
import 'package:infrastructure/networking/api_client/i_api_client.dart';
import 'package:infrastructure/networking/models/token.model.dart';
import 'package:infrastructure/presentation/models/paginated.model.dart';
import 'package:infrastructure/storage/file_storage/token/token_file_storage_mixin.dart';

@LazySingleton(as: IApiClient)
class DioClient implements IApiClient {
  DioClient(this._dio, this._logger, this._tokenRefresh) {
    _dio
      ..options.headers['Accept-Language'] =
          kIsWeb ? 'en-US' : Platform.localeName.characters.getRange(0, 2)
      ..options.connectTimeout = const Duration(seconds: 5)
      ..options.receiveTimeout = const Duration(seconds: 5)
      ..interceptors.add(_tokenRefresh.interceptor)
      ..interceptors.add(const DioHttpFailuresInterceptor())
      ..interceptors.add(const DioOtherFailuresInterceptor())
      ..interceptors.add(
        RetryInterceptor(dio: _dio, logPrint: _logger.debug, retries: 2),
      );
  }

  final Dio _dio;

  final ILogger _logger;

  final DioTokenRefresh _tokenRefresh;

  @override
  AsyncEither<M> invoke<SM, M>(
    String path,
    RequestTypeEnum requestType, {
    ModelFromJson<dynamic>? fromJson,
    Map<String, String>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    Response<dynamic> response;

    final bool isMbasicType = M.toString() == 'String' ||
        M.toString() == 'double' ||
        M.toString() == 'int' ||
        M.toString() == 'bool';
    final bool isSMbasicType = SM.toString() == 'String' ||
        SM.toString() == 'double' ||
        SM.toString() == 'int' ||
        SM.toString() == 'bool';
    final bool isMCollection = M.toString().startsWith('List<') ||
        M.toString().startsWith('PaginatedModel<');
    final bool isSMCollection = SM.toString().startsWith('List<') ||
        SM.toString().startsWith('PaginatedModel<');

    assert(
      M != Unit && !isMbasicType && fromJson != null,
      'When (M)odel is not void and not a basic type then fromJson cannot be null.',
    );

    assert(
      !isMCollection || SM.toString() != 'void',
      'When (M)odel is a List<SM> or PaginatedModel<SM>, then (S)ingle (M)odel cannot be void.',
    );

    assert(
      !isMCollection || (SM.toString() != 'void' && !isSMCollection),
      'When (M)odel is a List<SM> or PaginatedModel<SM>, then (S)ingle (M)odel cannot be void or another List or PaginatedModel.',
    );

    assert(
      !isMCollection || !isSMbasicType || fromJson != null,
      'When (M)odel is a List<SM> or PaginatedModel<SM> and (S)ingle (M)odel is not a basic type, then fromJson cannot be null.',
    );

    try {
      // Handling different request types.
      switch (requestType) {
        case RequestTypeEnum.get:
          response = await _dio.get(
            path,
            queryParameters: queryParameters,
          );

        case RequestTypeEnum.post:
          response = await _dio.post(
            path,
            data: data,
            queryParameters: queryParameters,
          );

        case RequestTypeEnum.put:
          response = await _dio.put(
            path,
            data: data,
          );

        case RequestTypeEnum.delete:
          response = await _dio.delete(
            path,
            data: data,
            queryParameters: queryParameters,
          );

        case RequestTypeEnum.patch:
          response = await _dio.patch(
            path,
            data: data,
            queryParameters: queryParameters,
          );
      }

      try {
        if (M == Unit) {
          return Right<Failure, M>(unit as M);
        } else {
          if (isMbasicType) {
            return Right<Failure, M>(response.data as M);
          } else if (M.toString().startsWith('List<')) {
            final List<SM> list =
                (response.data as List<dynamic>).map((dynamic item) {
              if (isSMbasicType) {
                return item as SM;
              }

              return fromJson!(item as Map<String, dynamic>) as SM;
            }).toList();

            return Right<Failure, M>(list as M);
          } else if (M.toString().startsWith('PaginatedModel<')) {
            final PaginatedModel<SM> paginatedList =
                PaginatedModel<SM>.fromJson(
              response.data as Map<String, dynamic>,
              (dynamic json) => fromJson!(json as Map<String, dynamic>),
            );
            return Right<Failure, M>(paginatedList as M);
          } else {
            return Right<Failure, M>(
                fromJson!(response.data as Map<String, dynamic>) as M);
          }
        }
      } catch (exception) {
        return Left<Failure, M>(ApiResponseParsingError(exception: exception));
      }
    } on DioFailure catch (exception) {
      return Left<Failure, M>(exception.failure);
    } catch (exception) {
      return Left<Failure, M>(UnexpectedError(exception: exception));
    }
  }

  @override
  void changeBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  @override
  void setObserver(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  @override
  TokenFileStorageMixin<TokenModel> get tokenStorage =>
      _tokenRefresh.interceptor;
}
