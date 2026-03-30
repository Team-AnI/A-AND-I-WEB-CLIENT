import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/image_upload_payload.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/image_upload_result.dart';

/// 이미지 업로드 저장소 인터페이스입니다.
abstract class ImageRepository {
  /// 이미지를 업로드합니다.
  Future<ImageUploadResult> uploadImage({
    required ImageUploadPayload payload,
  });
}
