/// 협업자 조회 결과 엔티티입니다.
class CollaboratorLookupUser {
  /// 협업자 조회 결과 엔티티를 생성합니다.
  const CollaboratorLookupUser({
    required this.id,
    required this.nickname,
    this.profileImageUrl,
    this.publicCode,
  });

  /// 사용자 ID(UUID)입니다.
  final String id;

  /// 사용자 닉네임입니다.
  final String nickname;

  /// 사용자 프로필 이미지 URL입니다.
  final String? profileImageUrl;

  /// 사용자 공개 코드입니다.
  final String? publicCode;
}
