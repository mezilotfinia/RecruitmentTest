import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recruitment_rest/core/usecase/use_case.dart';

import '../../../../core/resources/data_state.dart';
import '../../domain/usecase/api_usecase.dart';
import 'api_status.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiUseCase apiUseCase;

  HomeBloc(
    this.apiUseCase,
  ) : super(HomeState(
          apiStatus: ApiLoading(),
        )) {
    on<LoadApiEvent>((event, emit) async {
      emit(state.copyWith(newApiStatus: ApiLoading()));

      DataState dataState = await apiUseCase(NoParams());

      if (dataState is DataSuccess) {
        emit(state.copyWith(newApiStatus: ApiCompleted(dataState.data)));
      }

      if (dataState is DataFailed) {
        emit(state.copyWith(newApiStatus: ApiError(dataState.error!)));
      }
    });
  }
}
