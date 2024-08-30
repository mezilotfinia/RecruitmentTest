import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recruitment_rest/features/features_home/domain/entity/api_entity.dart';

@immutable
abstract class ApiStatus extends Equatable {}

class ApiLoading extends ApiStatus {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ApiCompleted extends ApiStatus {
  final List<ApiEntity> apiEntity;
  ApiCompleted(this.apiEntity);

  @override
  // TODO: implement props
  List<Object?> get props => [apiEntity];
}

class ApiError extends ApiStatus {
  final String message;
  ApiError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
