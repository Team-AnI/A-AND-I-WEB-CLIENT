// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_list_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$articleListViewModelHash() =>
    r'5df44a895a49f7916e73d87218f450adec34bfcb';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ArticleListViewModel
    extends BuildlessAutoDisposeAsyncNotifier<ArticleListState> {
  late final PostType postType;

  FutureOr<ArticleListState> build(
    PostType postType,
  );
}

/// 게시글 목록 화면 상태를 관리하는 ViewModel입니다.
///
/// Copied from [ArticleListViewModel].
@ProviderFor(ArticleListViewModel)
const articleListViewModelProvider = ArticleListViewModelFamily();

/// 게시글 목록 화면 상태를 관리하는 ViewModel입니다.
///
/// Copied from [ArticleListViewModel].
class ArticleListViewModelFamily extends Family<AsyncValue<ArticleListState>> {
  /// 게시글 목록 화면 상태를 관리하는 ViewModel입니다.
  ///
  /// Copied from [ArticleListViewModel].
  const ArticleListViewModelFamily();

  /// 게시글 목록 화면 상태를 관리하는 ViewModel입니다.
  ///
  /// Copied from [ArticleListViewModel].
  ArticleListViewModelProvider call(
    PostType postType,
  ) {
    return ArticleListViewModelProvider(
      postType,
    );
  }

  @override
  ArticleListViewModelProvider getProviderOverride(
    covariant ArticleListViewModelProvider provider,
  ) {
    return call(
      provider.postType,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'articleListViewModelProvider';
}

/// 게시글 목록 화면 상태를 관리하는 ViewModel입니다.
///
/// Copied from [ArticleListViewModel].
class ArticleListViewModelProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ArticleListViewModel, ArticleListState> {
  /// 게시글 목록 화면 상태를 관리하는 ViewModel입니다.
  ///
  /// Copied from [ArticleListViewModel].
  ArticleListViewModelProvider(
    PostType postType,
  ) : this._internal(
          () => ArticleListViewModel()..postType = postType,
          from: articleListViewModelProvider,
          name: r'articleListViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$articleListViewModelHash,
          dependencies: ArticleListViewModelFamily._dependencies,
          allTransitiveDependencies:
              ArticleListViewModelFamily._allTransitiveDependencies,
          postType: postType,
        );

  ArticleListViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postType,
  }) : super.internal();

  final PostType postType;

  @override
  FutureOr<ArticleListState> runNotifierBuild(
    covariant ArticleListViewModel notifier,
  ) {
    return notifier.build(
      postType,
    );
  }

  @override
  Override overrideWith(ArticleListViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: ArticleListViewModelProvider._internal(
        () => create()..postType = postType,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postType: postType,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ArticleListViewModel,
      ArticleListState> createElement() {
    return _ArticleListViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ArticleListViewModelProvider && other.postType == postType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postType.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ArticleListViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<ArticleListState> {
  /// The parameter `postType` of this provider.
  PostType get postType;
}

class _ArticleListViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ArticleListViewModel,
        ArticleListState> with ArticleListViewModelRef {
  _ArticleListViewModelProviderElement(super.provider);

  @override
  PostType get postType => (origin as ArticleListViewModelProvider).postType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
