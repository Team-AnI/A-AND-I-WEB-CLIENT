// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_list_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostListResponseDto {
  List<PostResponseDto> get items;
  int get page;
  int get size;
  int get totalElements;
  int get totalPages;

  /// Create a copy of PostListResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostListResponseDtoCopyWith<PostListResponseDto> get copyWith =>
      _$PostListResponseDtoCopyWithImpl<PostListResponseDto>(
          this as PostListResponseDto, _$identity);

  /// Serializes this PostListResponseDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostListResponseDto &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.totalElements, totalElements) ||
                other.totalElements == totalElements) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(items),
      page,
      size,
      totalElements,
      totalPages);

  @override
  String toString() {
    return 'PostListResponseDto(items: $items, page: $page, size: $size, totalElements: $totalElements, totalPages: $totalPages)';
  }
}

/// @nodoc
abstract mixin class $PostListResponseDtoCopyWith<$Res> {
  factory $PostListResponseDtoCopyWith(
          PostListResponseDto value, $Res Function(PostListResponseDto) _then) =
      _$PostListResponseDtoCopyWithImpl;
  @useResult
  $Res call(
      {List<PostResponseDto> items,
      int page,
      int size,
      int totalElements,
      int totalPages});
}

/// @nodoc
class _$PostListResponseDtoCopyWithImpl<$Res>
    implements $PostListResponseDtoCopyWith<$Res> {
  _$PostListResponseDtoCopyWithImpl(this._self, this._then);

  final PostListResponseDto _self;
  final $Res Function(PostListResponseDto) _then;

  /// Create a copy of PostListResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? page = null,
    Object? size = null,
    Object? totalElements = null,
    Object? totalPages = null,
  }) {
    return _then(_self.copyWith(
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PostResponseDto>,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      totalElements: null == totalElements
          ? _self.totalElements
          : totalElements // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [PostListResponseDto].
extension PostListResponseDtoPatterns on PostListResponseDto {
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
    TResult Function(_PostListResponseDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostListResponseDto() when $default != null:
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
    TResult Function(_PostListResponseDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostListResponseDto():
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
    TResult? Function(_PostListResponseDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostListResponseDto() when $default != null:
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
    TResult Function(List<PostResponseDto> items, int page, int size,
            int totalElements, int totalPages)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostListResponseDto() when $default != null:
        return $default(_that.items, _that.page, _that.size,
            _that.totalElements, _that.totalPages);
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
    TResult Function(List<PostResponseDto> items, int page, int size,
            int totalElements, int totalPages)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostListResponseDto():
        return $default(_that.items, _that.page, _that.size,
            _that.totalElements, _that.totalPages);
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
    TResult? Function(List<PostResponseDto> items, int page, int size,
            int totalElements, int totalPages)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostListResponseDto() when $default != null:
        return $default(_that.items, _that.page, _that.size,
            _that.totalElements, _that.totalPages);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PostListResponseDto implements PostListResponseDto {
  const _PostListResponseDto(
      {final List<PostResponseDto> items = const <PostResponseDto>[],
      this.page = 0,
      this.size = 0,
      this.totalElements = 0,
      this.totalPages = 0})
      : _items = items;
  factory _PostListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PostListResponseDtoFromJson(json);

  final List<PostResponseDto> _items;
  @override
  @JsonKey()
  List<PostResponseDto> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int size;
  @override
  @JsonKey()
  final int totalElements;
  @override
  @JsonKey()
  final int totalPages;

  /// Create a copy of PostListResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostListResponseDtoCopyWith<_PostListResponseDto> get copyWith =>
      __$PostListResponseDtoCopyWithImpl<_PostListResponseDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PostListResponseDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PostListResponseDto &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.totalElements, totalElements) ||
                other.totalElements == totalElements) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      page,
      size,
      totalElements,
      totalPages);

  @override
  String toString() {
    return 'PostListResponseDto(items: $items, page: $page, size: $size, totalElements: $totalElements, totalPages: $totalPages)';
  }
}

/// @nodoc
abstract mixin class _$PostListResponseDtoCopyWith<$Res>
    implements $PostListResponseDtoCopyWith<$Res> {
  factory _$PostListResponseDtoCopyWith(_PostListResponseDto value,
          $Res Function(_PostListResponseDto) _then) =
      __$PostListResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<PostResponseDto> items,
      int page,
      int size,
      int totalElements,
      int totalPages});
}

/// @nodoc
class __$PostListResponseDtoCopyWithImpl<$Res>
    implements _$PostListResponseDtoCopyWith<$Res> {
  __$PostListResponseDtoCopyWithImpl(this._self, this._then);

  final _PostListResponseDto _self;
  final $Res Function(_PostListResponseDto) _then;

  /// Create a copy of PostListResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
    Object? page = null,
    Object? size = null,
    Object? totalElements = null,
    Object? totalPages = null,
  }) {
    return _then(_PostListResponseDto(
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PostResponseDto>,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      totalElements: null == totalElements
          ? _self.totalElements
          : totalElements // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
