import 'package:equatable/equatable.dart';

class ApiEntity extends Equatable {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  const ApiEntity({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        userId,
        id,
        title,
        body,
      ];
}
