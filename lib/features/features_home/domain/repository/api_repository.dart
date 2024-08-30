import 'package:recruitment_rest/features/features_home/domain/entity/api_entity.dart';

import '../../../../core/resources/data_state.dart';

abstract class ApiRepository {
  Future<DataState<List<ApiEntity>>> fetchData();
}
