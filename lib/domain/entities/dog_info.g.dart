// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dog_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DogInfoImpl _$$DogInfoImplFromJson(Map<String, dynamic> json) =>
    _$DogInfoImpl(
      name: json['name'] as String,
      ownerName: json['ownerName'] as String,
      countryOfOrigin: json['countryOfOrigin'] as String,
      age: (json['age'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
      saved: json['saved'] as bool,
      ownerImageUrl: json['ownerImageUrl'] as String?,
    );

Map<String, dynamic> _$$DogInfoImplToJson(_$DogInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'ownerName': instance.ownerName,
      'countryOfOrigin': instance.countryOfOrigin,
      'age': instance.age,
      'imageUrl': instance.imageUrl,
      'saved': instance.saved,
      'ownerImageUrl': instance.ownerImageUrl,
    };
