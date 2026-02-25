// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_upload_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImageUploadResponseDto {
  String get url;
  String get key;
  String get contentType;
  int get size;

  /// Create a copy of ImageUploadResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ImageUploadResponseDtoCopyWith<ImageUploadResponseDto> get copyWith =>
      _$ImageUploadResponseDtoCopyWithImpl<ImageUploadResponseDto>(
          this as ImageUploadResponseDto, _$identity);

  /// Serializes this ImageUploadResponseDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ImageUploadResponseDto &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.size, size) || other.size == size));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, key, contentType, size);

  @override
  String toString() {
    return 'ImageUploadResponseDto(url: $url, key: $key, contentType: $contentType, size: $size)';
  }
}

/// @nodoc
abstract mixin class $ImageUploadResponseDtoCopyWith<$Res> {
  factory $ImageUploadResponseDtoCopyWith(ImageUploadResponseDto value,
          $Res Function(ImageUploadResponseDto) _then) =
      _$ImageUploadResponseDtoCopyWithImpl;
  @useResult
  $Res call({String url, String key, String contentType, int size});
}

/// @nodoc
class _$ImageUploadResponseDtoCopyWithImpl<$Res>
    implements $ImageUploadResponseDtoCopyWith<$Res> {
  _$ImageUploadResponseDtoCopyWithImpl(this._self, this._then);

  final ImageUploadResponseDto _self;
  final $Res Function(ImageUploadResponseDto) _then;

  /// Create a copy of ImageUploadResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? key = null,
    Object? contentType = null,
    Object? size = null,
  }) {
    return _then(_self.copyWith(
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: null == contentType
          ? _self.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [ImageUploadResponseDto].
extension ImageUploadResponseDtoPatterns on ImageUploadResponseDto {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ImageUploadResponseDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ImageUploadResponseDto() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ImageUploadResponseDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImageUploadResponseDto():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ImageUploadResponseDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImageUploadResponseDto() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String url, String key, String contentType, int size)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ImageUploadResponseDto() when $default != null:
        return $default(_that.url, _that.key, _that.contentType, _that.size);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String url, String key, String contentType, int size)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImageUploadResponseDto():
        return $default(_that.url, _that.key, _that.contentType, _that.size);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String url, String key, String contentType, int size)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ImageUploadResponseDto() when $default != null:
        return $default(_that.url, _that.key, _that.contentType, _that.size);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ImageUploadResponseDto implements ImageUploadResponseDto {
  const _ImageUploadResponseDto(
      {required this.url,
      required this.key,
      required this.contentType,
      required this.size});
  factory _ImageUploadResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ImageUploadResponseDtoFromJson(json);

  @override
  final String url;
  @override
  final String key;
  @override
  final String contentType;
  @override
  final int size;

  /// Create a copy of ImageUploadResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ImageUploadResponseDtoCopyWith<_ImageUploadResponseDto> get copyWith =>
      __$ImageUploadResponseDtoCopyWithImpl<_ImageUploadResponseDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ImageUploadResponseDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ImageUploadResponseDto &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.size, size) || other.size == size));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, key, contentType, size);

  @override
  String toString() {
    return 'ImageUploadResponseDto(url: $url, key: $key, contentType: $contentType, size: $size)';
  }
}

/// @nodoc
abstract mixin class _$ImageUploadResponseDtoCopyWith<$Res>
    implements $ImageUploadResponseDtoCopyWith<$Res> {
  factory _$ImageUploadResponseDtoCopyWith(_ImageUploadResponseDto value,
          $Res Function(_ImageUploadResponseDto) _then) =
      __$ImageUploadResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String url, String key, String contentType, int size});
}

/// @nodoc
class __$ImageUploadResponseDtoCopyWithImpl<$Res>
    implements _$ImageUploadResponseDtoCopyWith<$Res> {
  __$ImageUploadResponseDtoCopyWithImpl(this._self, this._then);

  final _ImageUploadResponseDto _self;
  final $Res Function(_ImageUploadResponseDto) _then;

  /// Create a copy of ImageUploadResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? url = null,
    Object? key = null,
    Object? contentType = null,
    Object? size = null,
  }) {
    return _then(_ImageUploadResponseDto(
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: null == contentType
          ? _self.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
