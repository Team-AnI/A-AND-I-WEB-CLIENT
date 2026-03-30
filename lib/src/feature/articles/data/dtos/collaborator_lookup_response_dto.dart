/// 협업자 조회 응답 DTO입니다.
class CollaboratorLookupResponseDto {
  /// 협업자 조회 응답 DTO를 생성합니다.
  const CollaboratorLookupResponseDto({
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

  /// JSON에서 DTO를 생성합니다.
  static CollaboratorLookupResponseDto? fromJson(Map<String, dynamic> json) {
    final id = json['id']?.toString();
    final nickname = json['nickname']?.toString() ??
        json['nickName']?.toString() ??
        json['username']?.toString();
    if (id == null || id.isEmpty || nickname == null || nickname.isEmpty) {
      return null;
    }

    final profileImageUrl = json['profileImageUrl']?.toString() ??
        json['profileImage']?.toString() ??
        json['profileImagePath']?.toString();
    final publicCode = json['publicCode']?.toString() ??
        json['public_code']?.toString() ??
        json['publiccode']?.toString();

    return CollaboratorLookupResponseDto(
      id: id,
      nickname: nickname,
      profileImageUrl: profileImageUrl,
      publicCode: publicCode,
    );
  }
}
