import 'package:freezed_annotation/freezed_annotation.dart';

part 'dog_info.freezed.dart';
part 'dog_info.g.dart';

@freezed
class DogInfo with _$DogInfo {
  const factory DogInfo(
      {required String name,
      required String ownerName,
      required String countryOfOrigin,
      required int age,
      required String imageUrl,
      required bool saved,
      String? ownerImageUrl}) = _DogInfo;

  factory DogInfo.fromJson(Map<String, dynamic> json) =>
      _$DogInfoFromJson(json);
}
