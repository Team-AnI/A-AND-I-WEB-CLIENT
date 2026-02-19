import 'dart:convert';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart' as web;

/// 압축 완료 이미지 결과다.
class UserProfileImageCompressionResult {
  const UserProfileImageCompressionResult({
    required this.bytes,
    required this.mimeType,
    required this.fileName,
  });

  final Uint8List bytes;
  final String mimeType;
  final String fileName;
}

/// 프로필 이미지를 WebP 우선으로 압축하고 용량 제한을 맞추는 서비스다.
class UserProfileImageCompressionService {
  static const int defaultMaxBytes = 1024 * 1024;

  /// 이미지를 WebP(우선)로 압축해 [maxBytes] 이하로 만든다.
  ///
  /// 브라우저에서 WebP 인코딩이 불가하면 JPEG로 폴백한다.
  static Future<UserProfileImageCompressionResult> compressWithinLimit(
    Uint8List originalBytes, {
    int maxBytes = defaultMaxBytes,
  }) async {
    final String sourceDataUrl =
        'data:image/*;base64,${base64Encode(originalBytes)}';
    final web.HTMLImageElement imageElement = web.HTMLImageElement()
      ..src = sourceDataUrl;

    await imageElement.decode().toDart;

    int targetWidth = imageElement.naturalWidth;
    int targetHeight = imageElement.naturalHeight;
    double quality = 0.90;
    const double minQuality = 0.40;
    const int resizePercent = 85;
    const int minWidth = 280;
    const int minHeight = 280;

    while (true) {
      final web.HTMLCanvasElement canvas = web.HTMLCanvasElement()
        ..width = targetWidth
        ..height = targetHeight;

      final web.CanvasRenderingContext2D context = canvas.context2D;
      context.drawImage(
        imageElement,
        0,
        0,
        targetWidth,
        targetHeight,
      );

      final String webpDataUrl = canvas.toDataUrl('image/webp', quality);
      final bool isWebp = webpDataUrl.startsWith('data:image/webp');
      final String encodedDataUrl =
          isWebp ? webpDataUrl : canvas.toDataUrl('image/jpeg', quality);
      final Uint8List encodedBytes = dataUrlToBytes(encodedDataUrl);

      if (encodedBytes.length <= maxBytes) {
        return UserProfileImageCompressionResult(
          bytes: encodedBytes,
          mimeType: isWebp ? 'image/webp' : 'image/jpeg',
          fileName: isWebp ? 'profile.webp' : 'profile.jpg',
        );
      }

      if (quality > minQuality) {
        quality = (quality - 0.10).clamp(minQuality, 1.0);
        continue;
      }

      final int nextWidth = (targetWidth * resizePercent / 100).round();
      final int nextHeight = (targetHeight * resizePercent / 100).round();
      if (nextWidth < minWidth || nextHeight < minHeight) {
        throw StateError('1MB 이하로 압축할 수 없습니다.');
      }

      targetWidth = nextWidth;
      targetHeight = nextHeight;
      quality = 0.90;
    }
  }

  /// Data URL 문자열을 바이트로 변환한다.
  static Uint8List dataUrlToBytes(String dataUrl) {
    final int commaIndex = dataUrl.indexOf(',');
    if (commaIndex < 0) {
      throw StateError('잘못된 이미지 데이터입니다.');
    }

    final String meta = dataUrl.substring(0, commaIndex);
    if (!meta.contains(';base64')) {
      throw StateError('지원하지 않는 이미지 인코딩입니다.');
    }

    final String base64Part = dataUrl.substring(commaIndex + 1);
    return Uint8List.fromList(base64Decode(base64Part));
  }
}
