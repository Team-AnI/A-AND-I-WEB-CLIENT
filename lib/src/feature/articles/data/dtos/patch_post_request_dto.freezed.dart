// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patch_post_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PatchPostRequestDto {
  String? get title;
  String? get contentMarkdown;
  String? get status;

  /// Create a copy of PatchPostRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PatchPostRequestDtoCopyWith<PatchPostRequestDto> get copyWith =>
      _$PatchPostRequestDtoCopyWithImpl<PatchPostRequestDto>(
          this as PatchPostRequestDto, _$identity);

  /// Serializes this PatchPostRequestDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PatchPostRequestDto &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.contentMarkdown, contentMarkdown) ||
                other.contentMarkdown == contentMarkdown) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, contentMarkdown, status);

  @override
  String toString() {
    return 'PatchPostRequestDto(title: $title, contentMarkdown: $contentMarkdown, status: $status)';
  }
}

/// @nodoc
abstract mixin class $PatchPostRequestDtoCopyWith<$Res> {
  factory $PatchPostRequestDtoCopyWith(
          PatchPostRequestDto value, $Res Function(PatchPostRequestDto) _then) =
      _$PatchPostRequestDtoCopyWithImpl;
  @useResult
  $Res call({String? title, String? contentMarkdown, String? status});
}

/// @nodoc
class _$PatchPostRequestDtoCopyWithImpl<$Res>
    implements $PatchPostRequestDtoCopyWith<$Res> {
  _$PatchPostRequestDtoCopyWithImpl(this._self, this._then);

  final PatchPostRequestDto _self;
  final $Res Function(PatchPostRequestDto) _then;

  /// Create a copy of PatchPostRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? contentMarkdown = freezed,
    Object? status = freezed,
  }) {
    return _then(_self.copyWith(
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      contentMarkdown: freezed == contentMarkdown
          ? _self.contentMarkdown
          : contentMarkdown // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [PatchPostRequestDto].
extension PatchPostRequestDtoPatterns on PatchPostRequestDto {
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
    TResult Function(_PatchPostRequestDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PatchPostRequestDto() when $default != null:
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
    TResult Function(_PatchPostRequestDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PatchPostRequestDto():
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
    TResult? Function(_PatchPostRequestDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PatchPostRequestDto() when $default != null:
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
    TResult Function(String? title, String? contentMarkdown, String? status)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PatchPostRequestDto() when $default != null:
        return $default(_that.title, _that.contentMarkdown, _that.status);
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
    TResult Function(String? title, String? contentMarkdown, String? status)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PatchPostRequestDto():
        return $default(_that.title, _that.contentMarkdown, _that.status);
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
    TResult? Function(String? title, String? contentMarkdown, String? status)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PatchPostRequestDto() when $default != null:
        return $default(_that.title, _that.contentMarkdown, _that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PatchPostRequestDto implements PatchPostRequestDto {
  const _PatchPostRequestDto({this.title, this.contentMarkdown, this.status});
  factory _PatchPostRequestDto.fromJson(Map<String, dynamic> json) =>
      _$PatchPostRequestDtoFromJson(json);

  @override
  final String? title;
  @override
  final String? contentMarkdown;
  @override
  final String? status;

  /// Create a copy of PatchPostRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PatchPostRequestDtoCopyWith<_PatchPostRequestDto> get copyWith =>
      __$PatchPostRequestDtoCopyWithImpl<_PatchPostRequestDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PatchPostRequestDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PatchPostRequestDto &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.contentMarkdown, contentMarkdown) ||
                other.contentMarkdown == contentMarkdown) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, contentMarkdown, status);

  @override
  String toString() {
    return 'PatchPostRequestDto(title: $title, contentMarkdown: $contentMarkdown, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$PatchPostRequestDtoCopyWith<$Res>
    implements $PatchPostRequestDtoCopyWith<$Res> {
  factory _$PatchPostRequestDtoCopyWith(_PatchPostRequestDto value,
          $Res Function(_PatchPostRequestDto) _then) =
      __$PatchPostRequestDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String? title, String? contentMarkdown, String? status});
}

/// @nodoc
class __$PatchPostRequestDtoCopyWithImpl<$Res>
    implements _$PatchPostRequestDtoCopyWith<$Res> {
  __$PatchPostRequestDtoCopyWithImpl(this._self, this._then);

  final _PatchPostRequestDto _self;
  final $Res Function(_PatchPostRequestDto) _then;

  /// Create a copy of PatchPostRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = freezed,
    Object? contentMarkdown = freezed,
    Object? status = freezed,
  }) {
    return _then(_PatchPostRequestDto(
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      contentMarkdown: freezed == contentMarkdown
          ? _self.contentMarkdown
          : contentMarkdown // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
