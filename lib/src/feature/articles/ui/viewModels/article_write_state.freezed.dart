// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_write_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArticleWriteState {
  String get postId;
  String get editingPostStatus;
  String get title;
  String get contentMarkdown;
  String get summary;
  List<String> get tags;
  List<PostAuthor> get collaborators;
  String? get thumbnailUrl;
  Uint8List? get thumbnailBytes;
  String? get thumbnailFileName;
  bool get isUploadingImage;
  bool get isSubmitting;
  String get errorMsg;
  String get successMsg;

  /// Create a copy of ArticleWriteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ArticleWriteStateCopyWith<ArticleWriteState> get copyWith =>
      _$ArticleWriteStateCopyWithImpl<ArticleWriteState>(
          this as ArticleWriteState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ArticleWriteState &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.editingPostStatus, editingPostStatus) ||
                other.editingPostStatus == editingPostStatus) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.contentMarkdown, contentMarkdown) ||
                other.contentMarkdown == contentMarkdown) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            const DeepCollectionEquality()
                .equals(other.collaborators, collaborators) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            const DeepCollectionEquality()
                .equals(other.thumbnailBytes, thumbnailBytes) &&
            (identical(other.thumbnailFileName, thumbnailFileName) ||
                other.thumbnailFileName == thumbnailFileName) &&
            (identical(other.isUploadingImage, isUploadingImage) ||
                other.isUploadingImage == isUploadingImage) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.errorMsg, errorMsg) ||
                other.errorMsg == errorMsg) &&
            (identical(other.successMsg, successMsg) ||
                other.successMsg == successMsg));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      postId,
      editingPostStatus,
      title,
      contentMarkdown,
      summary,
      const DeepCollectionEquality().hash(tags),
      const DeepCollectionEquality().hash(collaborators),
      thumbnailUrl,
      const DeepCollectionEquality().hash(thumbnailBytes),
      thumbnailFileName,
      isUploadingImage,
      isSubmitting,
      errorMsg,
      successMsg);

  @override
  String toString() {
    return 'ArticleWriteState(postId: $postId, editingPostStatus: $editingPostStatus, title: $title, contentMarkdown: $contentMarkdown, summary: $summary, tags: $tags, collaborators: $collaborators, thumbnailUrl: $thumbnailUrl, thumbnailBytes: $thumbnailBytes, thumbnailFileName: $thumbnailFileName, isUploadingImage: $isUploadingImage, isSubmitting: $isSubmitting, errorMsg: $errorMsg, successMsg: $successMsg)';
  }
}

/// @nodoc
abstract mixin class $ArticleWriteStateCopyWith<$Res> {
  factory $ArticleWriteStateCopyWith(
          ArticleWriteState value, $Res Function(ArticleWriteState) _then) =
      _$ArticleWriteStateCopyWithImpl;
  @useResult
  $Res call(
      {String postId,
      String editingPostStatus,
      String title,
      String contentMarkdown,
      String summary,
      List<String> tags,
      List<PostAuthor> collaborators,
      String? thumbnailUrl,
      Uint8List? thumbnailBytes,
      String? thumbnailFileName,
      bool isUploadingImage,
      bool isSubmitting,
      String errorMsg,
      String successMsg});
}

/// @nodoc
class _$ArticleWriteStateCopyWithImpl<$Res>
    implements $ArticleWriteStateCopyWith<$Res> {
  _$ArticleWriteStateCopyWithImpl(this._self, this._then);

  final ArticleWriteState _self;
  final $Res Function(ArticleWriteState) _then;

  /// Create a copy of ArticleWriteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? editingPostStatus = null,
    Object? title = null,
    Object? contentMarkdown = null,
    Object? summary = null,
    Object? tags = null,
    Object? collaborators = null,
    Object? thumbnailUrl = freezed,
    Object? thumbnailBytes = freezed,
    Object? thumbnailFileName = freezed,
    Object? isUploadingImage = null,
    Object? isSubmitting = null,
    Object? errorMsg = null,
    Object? successMsg = null,
  }) {
    return _then(_self.copyWith(
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      editingPostStatus: null == editingPostStatus
          ? _self.editingPostStatus
          : editingPostStatus // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      contentMarkdown: null == contentMarkdown
          ? _self.contentMarkdown
          : contentMarkdown // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _self.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      collaborators: null == collaborators
          ? _self.collaborators
          : collaborators // ignore: cast_nullable_to_non_nullable
              as List<PostAuthor>,
      thumbnailUrl: freezed == thumbnailUrl
          ? _self.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailBytes: freezed == thumbnailBytes
          ? _self.thumbnailBytes
          : thumbnailBytes // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      thumbnailFileName: freezed == thumbnailFileName
          ? _self.thumbnailFileName
          : thumbnailFileName // ignore: cast_nullable_to_non_nullable
              as String?,
      isUploadingImage: null == isUploadingImage
          ? _self.isUploadingImage
          : isUploadingImage // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubmitting: null == isSubmitting
          ? _self.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMsg: null == errorMsg
          ? _self.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String,
      successMsg: null == successMsg
          ? _self.successMsg
          : successMsg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ArticleWriteState].
extension ArticleWriteStatePatterns on ArticleWriteState {
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
    TResult Function(_ArticleWriteState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ArticleWriteState() when $default != null:
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
    TResult Function(_ArticleWriteState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ArticleWriteState():
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
    TResult? Function(_ArticleWriteState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ArticleWriteState() when $default != null:
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
    TResult Function(
            String postId,
            String editingPostStatus,
            String title,
            String contentMarkdown,
            String summary,
            List<String> tags,
            List<PostAuthor> collaborators,
            String? thumbnailUrl,
            Uint8List? thumbnailBytes,
            String? thumbnailFileName,
            bool isUploadingImage,
            bool isSubmitting,
            String errorMsg,
            String successMsg)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ArticleWriteState() when $default != null:
        return $default(
            _that.postId,
            _that.editingPostStatus,
            _that.title,
            _that.contentMarkdown,
            _that.summary,
            _that.tags,
            _that.collaborators,
            _that.thumbnailUrl,
            _that.thumbnailBytes,
            _that.thumbnailFileName,
            _that.isUploadingImage,
            _that.isSubmitting,
            _that.errorMsg,
            _that.successMsg);
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
    TResult Function(
            String postId,
            String editingPostStatus,
            String title,
            String contentMarkdown,
            String summary,
            List<String> tags,
            List<PostAuthor> collaborators,
            String? thumbnailUrl,
            Uint8List? thumbnailBytes,
            String? thumbnailFileName,
            bool isUploadingImage,
            bool isSubmitting,
            String errorMsg,
            String successMsg)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ArticleWriteState():
        return $default(
            _that.postId,
            _that.editingPostStatus,
            _that.title,
            _that.contentMarkdown,
            _that.summary,
            _that.tags,
            _that.collaborators,
            _that.thumbnailUrl,
            _that.thumbnailBytes,
            _that.thumbnailFileName,
            _that.isUploadingImage,
            _that.isSubmitting,
            _that.errorMsg,
            _that.successMsg);
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
    TResult? Function(
            String postId,
            String editingPostStatus,
            String title,
            String contentMarkdown,
            String summary,
            List<String> tags,
            List<PostAuthor> collaborators,
            String? thumbnailUrl,
            Uint8List? thumbnailBytes,
            String? thumbnailFileName,
            bool isUploadingImage,
            bool isSubmitting,
            String errorMsg,
            String successMsg)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ArticleWriteState() when $default != null:
        return $default(
            _that.postId,
            _that.editingPostStatus,
            _that.title,
            _that.contentMarkdown,
            _that.summary,
            _that.tags,
            _that.collaborators,
            _that.thumbnailUrl,
            _that.thumbnailBytes,
            _that.thumbnailFileName,
            _that.isUploadingImage,
            _that.isSubmitting,
            _that.errorMsg,
            _that.successMsg);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ArticleWriteState implements ArticleWriteState {
  const _ArticleWriteState(
      {this.postId = '',
      this.editingPostStatus = '',
      this.title = '',
      this.contentMarkdown = '',
      this.summary = '',
      final List<String> tags = const <String>[],
      final List<PostAuthor> collaborators = const <PostAuthor>[],
      this.thumbnailUrl,
      this.thumbnailBytes,
      this.thumbnailFileName,
      this.isUploadingImage = false,
      this.isSubmitting = false,
      this.errorMsg = '',
      this.successMsg = ''})
      : _tags = tags,
        _collaborators = collaborators;

  @override
  @JsonKey()
  final String postId;
  @override
  @JsonKey()
  final String editingPostStatus;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String contentMarkdown;
  @override
  @JsonKey()
  final String summary;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<PostAuthor> _collaborators;
  @override
  @JsonKey()
  List<PostAuthor> get collaborators {
    if (_collaborators is EqualUnmodifiableListView) return _collaborators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_collaborators);
  }

  @override
  final String? thumbnailUrl;
  @override
  final Uint8List? thumbnailBytes;
  @override
  final String? thumbnailFileName;
  @override
  @JsonKey()
  final bool isUploadingImage;
  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  @JsonKey()
  final String errorMsg;
  @override
  @JsonKey()
  final String successMsg;

  /// Create a copy of ArticleWriteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ArticleWriteStateCopyWith<_ArticleWriteState> get copyWith =>
      __$ArticleWriteStateCopyWithImpl<_ArticleWriteState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ArticleWriteState &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.editingPostStatus, editingPostStatus) ||
                other.editingPostStatus == editingPostStatus) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.contentMarkdown, contentMarkdown) ||
                other.contentMarkdown == contentMarkdown) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality()
                .equals(other._collaborators, _collaborators) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            const DeepCollectionEquality()
                .equals(other.thumbnailBytes, thumbnailBytes) &&
            (identical(other.thumbnailFileName, thumbnailFileName) ||
                other.thumbnailFileName == thumbnailFileName) &&
            (identical(other.isUploadingImage, isUploadingImage) ||
                other.isUploadingImage == isUploadingImage) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.errorMsg, errorMsg) ||
                other.errorMsg == errorMsg) &&
            (identical(other.successMsg, successMsg) ||
                other.successMsg == successMsg));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      postId,
      editingPostStatus,
      title,
      contentMarkdown,
      summary,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_collaborators),
      thumbnailUrl,
      const DeepCollectionEquality().hash(thumbnailBytes),
      thumbnailFileName,
      isUploadingImage,
      isSubmitting,
      errorMsg,
      successMsg);

  @override
  String toString() {
    return 'ArticleWriteState(postId: $postId, editingPostStatus: $editingPostStatus, title: $title, contentMarkdown: $contentMarkdown, summary: $summary, tags: $tags, collaborators: $collaborators, thumbnailUrl: $thumbnailUrl, thumbnailBytes: $thumbnailBytes, thumbnailFileName: $thumbnailFileName, isUploadingImage: $isUploadingImage, isSubmitting: $isSubmitting, errorMsg: $errorMsg, successMsg: $successMsg)';
  }
}

/// @nodoc
abstract mixin class _$ArticleWriteStateCopyWith<$Res>
    implements $ArticleWriteStateCopyWith<$Res> {
  factory _$ArticleWriteStateCopyWith(
          _ArticleWriteState value, $Res Function(_ArticleWriteState) _then) =
      __$ArticleWriteStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String postId,
      String editingPostStatus,
      String title,
      String contentMarkdown,
      String summary,
      List<String> tags,
      List<PostAuthor> collaborators,
      String? thumbnailUrl,
      Uint8List? thumbnailBytes,
      String? thumbnailFileName,
      bool isUploadingImage,
      bool isSubmitting,
      String errorMsg,
      String successMsg});
}

/// @nodoc
class __$ArticleWriteStateCopyWithImpl<$Res>
    implements _$ArticleWriteStateCopyWith<$Res> {
  __$ArticleWriteStateCopyWithImpl(this._self, this._then);

  final _ArticleWriteState _self;
  final $Res Function(_ArticleWriteState) _then;

  /// Create a copy of ArticleWriteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? postId = null,
    Object? editingPostStatus = null,
    Object? title = null,
    Object? contentMarkdown = null,
    Object? summary = null,
    Object? tags = null,
    Object? collaborators = null,
    Object? thumbnailUrl = freezed,
    Object? thumbnailBytes = freezed,
    Object? thumbnailFileName = freezed,
    Object? isUploadingImage = null,
    Object? isSubmitting = null,
    Object? errorMsg = null,
    Object? successMsg = null,
  }) {
    return _then(_ArticleWriteState(
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      editingPostStatus: null == editingPostStatus
          ? _self.editingPostStatus
          : editingPostStatus // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      contentMarkdown: null == contentMarkdown
          ? _self.contentMarkdown
          : contentMarkdown // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _self.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      collaborators: null == collaborators
          ? _self._collaborators
          : collaborators // ignore: cast_nullable_to_non_nullable
              as List<PostAuthor>,
      thumbnailUrl: freezed == thumbnailUrl
          ? _self.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailBytes: freezed == thumbnailBytes
          ? _self.thumbnailBytes
          : thumbnailBytes // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      thumbnailFileName: freezed == thumbnailFileName
          ? _self.thumbnailFileName
          : thumbnailFileName // ignore: cast_nullable_to_non_nullable
              as String?,
      isUploadingImage: null == isUploadingImage
          ? _self.isUploadingImage
          : isUploadingImage // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubmitting: null == isSubmitting
          ? _self.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMsg: null == errorMsg
          ? _self.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String,
      successMsg: null == successMsg
          ? _self.successMsg
          : successMsg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
