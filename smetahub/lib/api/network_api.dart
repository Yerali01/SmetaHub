import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:smetahub/api/api.dart';
import 'package:smetahub/api/base_dio.dart';
import 'package:smetahub/core/error/exceptions.dart';
import 'package:smetahub/features/user_smetas/domain/models/estimate_item_model.dart';
part 'urls.dart';

/// Апи для запросов в сеть
class NetworkApi implements Api {
  NetworkApi();

  Future<Response<dynamic>> postRequest({
    required String path,
    Map<String, dynamic>? body,
    String? accessToken,
  }) async {
    body ??= <String, dynamic>{};
    try {
      // Create options with headers
      final options = Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      final Response<dynamic> respData = await BaseDio().dio.post(
            path,
            data: jsonEncode(body),
            options: options,
          );
      return respData;
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        throw ValidationException();
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> postMultipartRequest({
    required String path,
    Map<String, dynamic>? fields,
    List<MapEntry<String, MultipartFile>>? files,
    String? accessToken,
  }) async {
    try {
      // Create FormData object
      final formData = FormData();

      // Add text fields if provided
      if (fields != null) {
        fields.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      // Add files if provided
      if (files != null) {
        formData.files.addAll(files);
      }

      // Create options with headers
      final options = Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'multipart/form-data',
        },
      );

      final Response<dynamic> respData = await BaseDio().dio.post(
            path,
            data: formData,
            options: options,
          );
      return respData;
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        throw ValidationException();
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> getRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
    String? parameters,
    bool checkAuth = true,
    String? accessToken,
  }) async {
    try {
      // Create options and add authorization header if accessToken is provided
      Options options = Options();
      if (checkAuth && accessToken != null) {
        options = Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        );
      }

      return await BaseDio().dio.get(
            '$path${parameters ?? ''}',
            queryParameters: queryParameters,
            options: options,
          );
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        throw ValidationException();
      }

      if (checkAuth) {
        if (e.response?.statusCode == 401) {
          // await refreshTokenRequest();

          // After refreshing token, retry with the same headers
          Options retryOptions = Options();
          if (accessToken != null) {
            retryOptions = Options(
              headers: {
                'Authorization': 'Bearer $accessToken',
              },
            );
          }

          return BaseDio().dio.get(
                '$path${parameters ?? ''}',
                queryParameters: queryParameters,
                options: retryOptions,
              );
        }
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> putRequest({
    required String path,
    Map<String, dynamic>? body,
    String? accessToken,
  }) async {
    body ??= <String, dynamic>{};
    try {
      // Create options with authorization header using JWT token
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      return await BaseDio().dio.put(
            path,
            data: jsonEncode(body),
            options: options,
          );
    } on DioException catch (e) {
      // if (e.response?.statusCode == 401) {
      //   // Token expired, try to refresh it
      //   final newToken = await refreshTokenRequest();

      //   // Retry the request with the new token
      //   Options options = Options(
      //     headers: {
      //       'Authorization': 'Bearer $newToken',
      //       'Content-Type': 'application/json',
      //     },
      //   );

      //   return await BaseDio().dio.put(
      //     path,
      //     data: jsonEncode(body),
      //     options: options,
      //   );
      // }
      rethrow;
    }
  }

// // Helper function to get the stored access token
// Future<String> getStoredAccessToken() async {
//   // Implement your logic to retrieve the token from secure storage
//   // Example using shared_preferences or flutter_secure_storage
//   // return await secureStorage.read(key: 'access_token') ?? '';

//   // Placeholder - replace with your actual implementation
//   return '';
// }

// // Function to refresh the token
// Future<String> refreshTokenRequest() async {
//   // Implement your token refresh logic here
//   // This would typically call your auth endpoint with a refresh token

//   // Example implementation:
//   // final refreshToken = await secureStorage.read(key: 'refresh_token');
//   // final response = await BaseDio().dio.post('/auth/refresh', data: {'refresh_token': refreshToken});
//   // final newAccessToken = response.data['access_token'];
//   // await secureStorage.write(key: 'access_token', value: newAccessToken);
//   // return newAccessToken;

//   // Placeholder - replace with your actual implementation
//   return '';
// }

  Future<Response<dynamic>> deleteRequest({
    required String path,
    Map<String, dynamic>? body,
    bool checkAuth = true,
    String? accessToken,
  }) async {
    body ??= <String, dynamic>{};
    try {
      final options = Options(
        headers: {
          if (accessToken != null) 'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      return await BaseDio().dio.delete(
            path,
            data: jsonEncode(body),
            options: options,
          );
    } on DioException catch (e) {
      if (checkAuth && e.response?.statusCode == 401) {
        // Uncomment and implement token refresh if needed
        // await refreshTokenRequest();
        // return BaseDio().dio.delete(
        //   path,
        //   data: jsonEncode(body),
        //   options: options,
        // );
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> accessTokenRefresh({
    required String refreshToken,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.refresh,
        body: <String, dynamic>{
          'refresh_token': refreshToken,
        },
      );

      /// TokenResponse
      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => accessTokenRefresh');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  // @override
  // Future<dynamic> getToken({
  //   String? countryCode,
  //   required String password,
  //   required String phoneNumber,
  // }) async {
  //   try {
  //     final Response<dynamic> data = await postRequest(
  //       path: Urls.token,
  //       body: <String, dynamic>{
  //         'code': countryCode,
  //         'password': password,
  //         'phone_number': phoneNumber,
  //       },
  //     );
  //     /// TokenResponse
  //     return data.data;
  //   } on DioException catch (e) {
  //     log('ERROR in NETWORK_API => getToken');
  //     if (e.response?.statusCode == 422) {
  //       throw HTTPValidationException();
  //     }
  //     rethrow;
  //   }
  // }

  @override
  Future getUserInformation() async {
    try {
      final Response<dynamic> data = await getRequest(
        path: Urls.me,
        // body: <String, dynamic>{
        //   'country_code': countryCode,
        //   'password': password,
        //   'phone_number': phoneNumber,
        // },
      );

      /// UserResponse
      log('USER DATA ${data.data}');
      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => getUserInformation');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<void> logout({
    required String refreshToken,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.logOut,
        body: <String, dynamic>{
          'refresh_token': refreshToken,
        },
      );

      /// "204": {
      ///     "description": "Successful Response"
      /// },
      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => logout');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> resetPasswordConfirm({
    required String newPassword,
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.resetPasswordConfirm,
        body: <String, dynamic>{
          'new_password': newPassword,
        },
        accessToken: accessToken,
      );

      /// VerificationResponse
      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => resetPasswordConfirm');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> resetPasswordRequest({
    required String phoneNumber,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.resetPasswordRequest,
        body: <String, dynamic>{
          'phone_number': phoneNumber,
        },
      );

      /// VerificationResponse
      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => resetPasswordRequest');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> sendVerificationCode({
    required String phoneNumber,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.sendVerification,
        body: <String, dynamic>{
          'phone_number': phoneNumber,
        },
      );

      /// VerificationResponse
      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => sendVerificationCode');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> userSignUp({
    String? countryCode,
    // required String password,
    required String phoneNumber,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.register,
        body: <String, dynamic>{
          'country_code': countryCode,
          'phone_number': phoneNumber,
        },
      );

      /// TokenResponse
      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => userSignUp');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> userSignIn({
    String? countryCode,
    required String password,
    required String phoneNumber,
  }) async {
    // try {
    final Response<dynamic> data = await postRequest(
      path: Urls.login,
      body: <String, dynamic>{
        'country_code': countryCode,
        'password': password,
        'phone_number': phoneNumber,
      },
    );

    log('data.data ${data.data}');

    /// TokenResponse
    return data.data;
    // } on DioException catch (e) {
    //   log('ERROR in NETWORK_API => userSignIn');
    //   if (e.response?.statusCode == 422) {
    //     throw HTTPValidationException();
    //   }
    //   rethrow;
    // }
  }

  @override
  Future<dynamic> verifyPhoneNumber({
    required String phoneNumber,
    required String code,
  }) async {
    // try {
    final Response<dynamic> data = await postRequest(
      path: Urls.verifyPhone,
      body: <String, dynamic>{
        'phone_number': phoneNumber,
        'code': code,
      },
    );

    /// VerificationResponse
    return data;
    // } on DioException catch (e) {
    // return e.response?.data["detail"];
    // }
  }

  @override
  Future<dynamic> verifyResetCode({
    required String code,
    required String phoneNumber,
  }) async {
    // try {
    final Response<dynamic> data = await postRequest(
      path: Urls.verifyReset,
      body: <String, dynamic>{
        'code': code,
        'phone_number': phoneNumber,
      },
    );

    return data;
    // } on DioException catch (e) {
    // log('ERROR in NETWORK_API => verifyPhoneNumber $e');
    // if (e.response?.statusCode == 422) {
    //   throw HTTPValidationException();
    // }
    // rethrow;
    // }
  }

  @override
  Future<dynamic> setPassword({
    required String password,
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.setPassword,
        body: <String, dynamic>{
          'password': password,
        },
        accessToken: accessToken,
      );

      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => setPassword $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> createProjectName({
    required String name,
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.createProjectName,
        body: <String, dynamic>{
          'name': name,
        },
        accessToken: accessToken,
      );

      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => createProjectName $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> selectObjectType({
    required int projectId,
    required int objectTypeId,
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.selectObjectType,
        body: <String, dynamic>{
          'project_id': projectId,
          'object_type_id': objectTypeId,
        },
        accessToken: accessToken,
      );

      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => selectObjectType $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> selectCategory({
    required int projectId,
    required int projectCategoryId,
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.selectCategory,
        body: <String, dynamic>{
          'project_id': projectId,
          'project_category_id': projectCategoryId,
        },
        accessToken: accessToken,
      );

      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => selectCategory $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> selectCurrentState({
    required int projectId,
    required int objectConditionId,
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.selectCurrentState,
        body: <String, dynamic>{
          'project_id': projectId,
          'object_condition_id': objectConditionId,
        },
        accessToken: accessToken,
      );

      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => selectCurrentState $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> createTechnicalCondition({
    required int projectId,
    required int area,
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.createTechCondition,
        body: <String, dynamic>{
          'project_id': projectId,
          'area': area,
        },
        accessToken: accessToken,
      );

      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => createTechCondition $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> getAllAgents({
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await getRequest(
        path: Urls.getAllAgents,
        accessToken: accessToken,
      );

      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => getAllAgents $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> addAiAgentsToProject({
    required int projectId,
    required int aiConsultantId,
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.addAiAgentsToProject,
        body: <String, dynamic>{
          'project_id': projectId,
          'agent_id': aiConsultantId,
        },
        accessToken: accessToken,
      );

      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => addAiAgentsToProject $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> getProjects({
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await getRequest(
        path: Urls.getProjects,
        accessToken: accessToken,
      );

      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => getProjects $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> getEstimates({
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await getRequest(
        path: Urls.getUserEstimates,
        accessToken: accessToken,
      );

      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => getEstimates $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> getEstimateItems({
    required String accessToken,
    required int estimateId,
  }) async {
    try {
      final Response<dynamic> data = await getRequest(
        path: '${Urls.getEstimateItems}/$estimateId/items',
        accessToken: accessToken,
      );

      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => getEstimateItems $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> updateEstimateItems({
    required String accessToken,
    required int estimateId,
    required List<dynamic> estimateItems,
  }) async {
    try {
      final Response<dynamic> data = await putRequest(
          path: Urls.updateEstimateItems,
          accessToken: accessToken,
          body: {
            'estimate_id': estimateId,
            'items': estimateItems,
          });

      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => updateEstimateItems $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> addEstimateItem({
    required String accessToken,
    required int estimateId,
    required EstimateItemModel estimateItem,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.addEstimateItem,
        accessToken: accessToken,
        body: {
          'estimate_id': estimateId,
          'item': {
            "work_type": estimateItem.workType,
            "unit": estimateItem.unit,
            "quantity": estimateItem.quantity,
            "price_per_one": estimateItem.pricePerOne,
            "cost": estimateItem.cost,
            "markup": estimateItem.markup,
            "client_price_per_one": estimateItem.clientPricePerOne,
            "client_cost": estimateItem.clientCost,
            "created_at": DateTime.now(),
          },
        },
      );

      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => addEstimateItem $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteProjectFile({
    required int fileId,
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await deleteRequest(
        path: '${Urls.deleteProjectFile}/$fileId',
        accessToken: accessToken,
      );
      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => deleteProjectFile $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> uploadProjectFile({
    required int projectId,
    required String file,
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await postMultipartRequest(
        path: Urls.uploadProjectFile,
        fields: {
          'project_id': projectId,
        },
        files: [
          MapEntry('file', MultipartFile.fromFileSync(file)),
        ],
        accessToken: accessToken,
      );

      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => uploadProjectFile $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> createSmeta({
    required int? projectId,
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: '${Urls.createSmeta}?project_id=$projectId',
        body: <String, dynamic>{
          'project_id': projectId,
        },
        accessToken: accessToken,
      );
      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => createSmeta $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> getWorkTypes({
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await getRequest(
        path: Urls.getWorkTypes,
        accessToken: accessToken,
      );
      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => getWorkTypes $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> selectSubspeciesWorkType({
    required int estimateId,
    required List<int> subspeciesWorkTypeIds,
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.addSubspeciesWorkType,
        body: <String, dynamic>{
          'estimate_id': estimateId,
          'subspecies_work_type_ids': subspeciesWorkTypeIds,
        },
        accessToken: accessToken,
      );
      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => selectSubspeciesWorkType $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> getMaterialTypes({
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await getRequest(
        path: Urls.getMaterialTypes,
        accessToken: accessToken,
      );
      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => getMaterialTypes $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> addMaterialType({
    required int estimateId,
    required int materialTypeId,
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.addMaterialType,
        body: <String, dynamic>{
          'estimate_id': estimateId,
          'material_type_id': materialTypeId,
        },
        accessToken: accessToken,
      );
      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => addMaterialType $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> addSpecialWish({
    required int estimateId,
    required String text,
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.addSpecialWish,
        body: <String, dynamic>{
          'estimate_id': estimateId,
          'special_wish': text,
        },
        accessToken: accessToken,
      );
      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => addSpecialWish $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> createSmetaName({
    required int estimateId,
    required String name,
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.createSmetaName,
        body: <String, dynamic>{
          'estimate_id': estimateId,
          'name': name,
        },
        accessToken: accessToken,
      );
      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => createSmetaName $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> generateEstimate({
    required int estimateId,
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.generalEstimate,
        body: <String, dynamic>{
          'estimate_id': estimateId,
        },
        accessToken: accessToken,
      );
      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => generateEstimate $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> createChat({
    required String title,
    int? projectId,
    required int aiAgentId,
    required String accessToken,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.createChat,
        body: <String, dynamic>{
          'title': title,
          'project_id': projectId,
          'agent_id': aiAgentId,
        },
        accessToken: accessToken,
      );

      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => createChat $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> getAllChats({
    required String accessToken,
    int? projectId,
  }) async {
    try {
      final Response<dynamic> data = await getRequest(
        path: Urls.getAllChats,
        accessToken: accessToken,
      );

      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => getAllChats $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> getChat({
    required String accessToken,
    required int chatId,
  }) async {
    try {
      final Response<dynamic> data = await getRequest(
        path: '${Urls.getChat}/$chatId',
        accessToken: accessToken,
      );

      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => getChat $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> sendMessage({
    required String accessToken,
    required int chatId,
    required String content,
    Object? metadata,
  }) async {
    try {
      final Response<dynamic> data = await postRequest(
        path: Urls.sendMessage,
        body: <String, dynamic>{
          'chat_id': chatId,
          'content': content,
          'metadata': metadata,
        },
        accessToken: accessToken,
      );

      return data.data;
    } on DioException catch (e) {
      log('ERROR in NETWORK_API => sendMessage $e');
      if (e.response?.statusCode == 422) {
        throw HTTPValidationException();
      }
      rethrow;
    }
  }
}
