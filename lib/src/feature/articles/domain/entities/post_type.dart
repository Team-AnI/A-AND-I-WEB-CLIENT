/// 게시글 종류를 나타냅니다.
enum PostType {
  /// 블로그 글입니다.
  blog,

  /// 강의자료입니다.
  lecture,
}

/// 게시글 종류 관련 확장입니다.
extension PostTypeX on PostType {
  /// API 요청/응답에서 사용하는 값을 반환합니다.
  String get apiValue {
    switch (this) {
      case PostType.blog:
        return 'Blog';
      case PostType.lecture:
        return 'Lecture';
    }
  }

  /// 화면에 표시할 한국어 이름을 반환합니다.
  String get label {
    switch (this) {
      case PostType.blog:
        return '블로그';
      case PostType.lecture:
        return '강의자료';
    }
  }

  /// 게시글 목록 경로를 반환합니다.
  String get listPath {
    switch (this) {
      case PostType.blog:
        return '/articles';
      case PostType.lecture:
        return '/materials';
    }
  }

  /// 게시글 작성 경로를 반환합니다.
  String get writePath => '$listPath/write';

  /// 게시글 설정 경로를 반환합니다.
  String get confirmPath => '$listPath/confirm';
}

/// API 문자열을 게시글 종류로 변환합니다.
PostType postTypeFromApiValue(String? value) {
  switch (value?.trim().toLowerCase()) {
    case 'lecture':
      return PostType.lecture;
    case 'blog':
    default:
      return PostType.blog;
  }
}
