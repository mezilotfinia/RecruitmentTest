import 'package:recruitment_rest/features/features_home/domain/entity/api_entity.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/api_repository.dart';

class ApiUseCase extends UseCase<DataState<List<ApiEntity>>, NoParams> {
  final ApiRepository apiRepository;
  ApiUseCase(this.apiRepository);

  @override
  Future<DataState<List<ApiEntity>>> call(NoParams param) {
    return apiRepository.fetchData();
  }
}
