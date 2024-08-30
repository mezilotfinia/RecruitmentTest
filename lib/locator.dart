import 'package:get_it/get_it.dart';
import 'package:recruitment_rest/features/features_home/data/repository/api_repository_impl.dart';
import 'package:recruitment_rest/features/features_home/domain/repository/api_repository.dart';
import 'package:recruitment_rest/features/features_home/domain/usecase/api_usecase.dart';

import 'features/features_home/data/data_source/api/api_provider.dart';
import 'features/features_home/presentation/bloc/home_bloc.dart';

GetIt locator = GetIt.instance;

setup() async {
  ///api
  locator.registerSingleton<ApiProvider>(ApiProvider());

  /// repositories
  locator.registerSingleton<ApiRepository>(ApiRepositoryImpl(locator()));

  /// use case
  locator.registerSingleton<ApiUseCase>(ApiUseCase(locator()));

  /// bloc
  locator.registerSingleton<HomeBloc>(HomeBloc(locator()));
}
