part of 'home_bloc.dart';

class HomeState extends Equatable {
  final ApiStatus apiStatus;

  const HomeState({
    required this.apiStatus,
  });

  HomeState copyWith({
    ApiStatus? newApiStatus,
  }) {
    return HomeState(
      apiStatus: newApiStatus ?? apiStatus,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [apiStatus];
}
