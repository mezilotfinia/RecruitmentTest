import 'package:dio/dio.dart';
import 'package:recruitment_rest/features/features_home/data/models/api_model.dart';
import 'package:recruitment_rest/features/features_home/domain/entity/api_entity.dart';

import '../../../../core/resources/data_state.dart';
import '../../domain/repository/api_repository.dart';
import '../data_source/api/api_provider.dart';

class ApiRepositoryImpl extends ApiRepository {
  ApiProvider apiProvider;

  ApiRepositoryImpl(this.apiProvider);

  @override
  Future<DataState<List<ApiEntity>>> fetchData() async {
    try {
      Response response = await apiProvider.callGetData();
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;
        List<ApiEntity> apiEntities =
            responseData.map((item) => ApiModel.fromJson(item)).toList();
        return DataSuccess(apiEntities);
      } else {
        return const DataFailed("Something Went Wrong. try again...");
      }
    } catch (e) {
      return const DataFailed("please check your connection...");
    }
  }
}
