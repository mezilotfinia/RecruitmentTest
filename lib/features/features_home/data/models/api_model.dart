import 'package:recruitment_rest/features/features_home/domain/entity/api_entity.dart';

class ApiModel extends ApiEntity {
  const ApiModel({
    super.id,
    super.userId,
    super.title,
    super.body,
  });

  factory ApiModel.fromJson(Map<String, dynamic> json) {
    return ApiModel(
      id: json["id"],
      userId: json["userId"],
      title: json["title"],
      body: json["body"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["userId"] = userId;
    data["id"] = id;
    data["title"] = title;
    data["body"] = body;
    return data;
  }
}
