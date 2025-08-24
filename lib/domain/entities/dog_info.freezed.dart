// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dog_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DogInfo _$DogInfoFromJson(Map<String, dynamic> json) {
  return _DogInfo.fromJson(json);
}

/// @nodoc
mixin _$DogInfo {
  String get name => throw _privateConstructorUsedError;
  String get ownerName => throw _privateConstructorUsedError;
  String get countryOfOrigin => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  bool get saved => throw _privateConstructorUsedError;
  String? get ownerImageUrl => throw _privateConstructorUsedError;

  /// Serializes this DogInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DogInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DogInfoCopyWith<DogInfo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DogInfoCopyWith<$Res> {
  factory $DogInfoCopyWith(DogInfo value, $Res Function(DogInfo) then) =
      _$DogInfoCopyWithImpl<$Res, DogInfo>;
  @useResult
  $Res call(
      {String name,
      String ownerName,
      String countryOfOrigin,
      int age,
      String imageUrl,
      bool saved,
      String? ownerImageUrl});
}

/// @nodoc
class _$DogInfoCopyWithImpl<$Res, $Val extends DogInfo>
    implements $DogInfoCopyWith<$Res> {
  _$DogInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DogInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? ownerName = null,
    Object? countryOfOrigin = null,
    Object? age = null,
    Object? imageUrl = null,
    Object? saved = null,
    Object? ownerImageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: null == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      countryOfOrigin: null == countryOfOrigin
          ? _value.countryOfOrigin
          : countryOfOrigin // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      saved: null == saved
          ? _value.saved
          : saved // ignore: cast_nullable_to_non_nullable
              as bool,
      ownerImageUrl: freezed == ownerImageUrl
          ? _value.ownerImageUrl
          : ownerImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DogInfoImplCopyWith<$Res> implements $DogInfoCopyWith<$Res> {
  factory _$$DogInfoImplCopyWith(
          _$DogInfoImpl value, $Res Function(_$DogInfoImpl) then) =
      __$$DogInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String ownerName,
      String countryOfOrigin,
      int age,
      String imageUrl,
      bool saved,
      String? ownerImageUrl});
}

/// @nodoc
class __$$DogInfoImplCopyWithImpl<$Res>
    extends _$DogInfoCopyWithImpl<$Res, _$DogInfoImpl>
    implements _$$DogInfoImplCopyWith<$Res> {
  __$$DogInfoImplCopyWithImpl(
      _$DogInfoImpl _value, $Res Function(_$DogInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of DogInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? ownerName = null,
    Object? countryOfOrigin = null,
    Object? age = null,
    Object? imageUrl = null,
    Object? saved = null,
    Object? ownerImageUrl = freezed,
  }) {
    return _then(_$DogInfoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: null == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      countryOfOrigin: null == countryOfOrigin
          ? _value.countryOfOrigin
          : countryOfOrigin // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      saved: null == saved
          ? _value.saved
          : saved // ignore: cast_nullable_to_non_nullable
              as bool,
      ownerImageUrl: freezed == ownerImageUrl
          ? _value.ownerImageUrl
          : ownerImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DogInfoImpl implements _DogInfo {
  const _$DogInfoImpl(
      {required this.name,
      required this.ownerName,
      required this.countryOfOrigin,
      required this.age,
      required this.imageUrl,
      required this.saved,
      this.ownerImageUrl});

  factory _$DogInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DogInfoImplFromJson(json);

  @override
  final String name;
  @override
  final String ownerName;
  @override
  final String countryOfOrigin;
  @override
  final int age;
  @override
  final String imageUrl;
  @override
  final bool saved;
  @override
  final String? ownerImageUrl;

  @override
  String toString() {
    return 'DogInfo(name: $name, ownerName: $ownerName, countryOfOrigin: $countryOfOrigin, age: $age, imageUrl: $imageUrl, saved: $saved, ownerImageUrl: $ownerImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DogInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName) &&
            (identical(other.countryOfOrigin, countryOfOrigin) ||
                other.countryOfOrigin == countryOfOrigin) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.saved, saved) || other.saved == saved) &&
            (identical(other.ownerImageUrl, ownerImageUrl) ||
                other.ownerImageUrl == ownerImageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, ownerName, countryOfOrigin,
      age, imageUrl, saved, ownerImageUrl);

  /// Create a copy of DogInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DogInfoImplCopyWith<_$DogInfoImpl> get copyWith =>
      __$$DogInfoImplCopyWithImpl<_$DogInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DogInfoImplToJson(
      this,
    );
  }
}

abstract class _DogInfo implements DogInfo {
  const factory _DogInfo(
      {required final String name,
      required final String ownerName,
      required final String countryOfOrigin,
      required final int age,
      required final String imageUrl,
      required final bool saved,
      final String? ownerImageUrl}) = _$DogInfoImpl;

  factory _DogInfo.fromJson(Map<String, dynamic> json) = _$DogInfoImpl.fromJson;

  @override
  String get name;
  @override
  String get ownerName;
  @override
  String get countryOfOrigin;
  @override
  int get age;
  @override
  String get imageUrl;
  @override
  bool get saved;
  @override
  String? get ownerImageUrl;

  /// Create a copy of DogInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DogInfoImplCopyWith<_$DogInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
