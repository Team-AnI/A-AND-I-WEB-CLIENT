/// 블로그 관리 가능 권한의 최소 기준입니다.
const String minimumArticleManagerRole = 'ORGANIZER';

/// 블로그 생성/수정/삭제 가능 여부를 반환합니다.
bool canManageArticlesWithRole(String? role) {
  final normalized = role?.trim().toUpperCase();
  if (normalized == null || normalized.isEmpty) {
    return false;
  }

  const roleRank = <String, int>{
    'USER': 0,
    'ORGANIZER': 1,
    'ADMIN': 2,
    'OWNER': 3,
    'SUPER_ADMIN': 4,
  };

  final current = roleRank[normalized] ?? 0;
  final required = roleRank[minimumArticleManagerRole] ?? 1;
  return current >= required;
}
