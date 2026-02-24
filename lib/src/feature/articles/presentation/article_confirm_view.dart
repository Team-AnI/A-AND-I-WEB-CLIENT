import 'dart:typed_data';

import 'package:a_and_i_report_web_server/src/core/auth/role_policy.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/user_view_model.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/ui/viewModels/user_view_state.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/ui/viewModels/article_write_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ArticleConfirmView extends ConsumerStatefulWidget {
  const ArticleConfirmView({super.key});

  @override
  ConsumerState<ArticleConfirmView> createState() => ArticleConfirmViewState();
}

class ArticleConfirmViewState extends ConsumerState<ArticleConfirmView> {
  late final TextEditingController summaryController;

  @override
  void initState() {
    super.initState();
    final composeState = ref.read(articleWriteViewModelProvider);
    summaryController = TextEditingController(text: composeState.summary);
    summaryController.addListener(_syncSummary);
  }

  @override
  void dispose() {
    summaryController.removeListener(_syncSummary);
    summaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userViewModelProvider);
    if (userState.status == UserStatus.loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final canManageArticles = canManageArticlesWithRole(userState.resolvedRole);
    if (!canManageArticles) {
      return const _ArticleConfirmPermissionDeniedView();
    }

    final composeState = ref.watch(articleWriteViewModelProvider);
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;
    final isTablet = width >= 768 && width < 1200;
    final maxWidth = isMobile ? 680.0 : (isTablet ? 980.0 : 1200.0);
    final outerHorizontal = isMobile ? 14.0 : (isTablet ? 22.0 : 32.0);
    final contentHorizontal = isMobile ? 6.0 : (isTablet ? 10.0 : 20.0);
    final topBottom = isMobile ? 18.0 : (isTablet ? 30.0 : 40.0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: topBottom),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: outerHorizontal),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: contentHorizontal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children: [
                          Text(
                            '포스트 출간 설정',
                            style: TextStyle(
                              fontSize: isMobile ? 28 : (isTablet ? 32 : 34),
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'PUBLISH SETTINGS',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF9CA3AF),
                              fontWeight: FontWeight.w600,
                              letterSpacing: isMobile ? 0.4 : 1.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isMobile ? 26 : (isTablet ? 40 : 56)),
                      ConfirmPreviewSection(
                        summaryController: summaryController,
                        thumbnailUrl: composeState.thumbnailUrl,
                        thumbnailBytes: composeState.thumbnailBytes,
                        isUploadingImage: composeState.isUploadingImage,
                        onPickThumbnail: () => onTapPickThumbnail(context),
                        isMobile: isMobile,
                        isTablet: isTablet,
                      ),
                      SizedBox(height: isMobile ? 34 : (isTablet ? 44 : 56)),
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Color(0xFFF3F4F6)),
                          ),
                        ),
                        child: Flex(
                          direction: isMobile ? Axis.vertical : Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: isMobile
                              ? CrossAxisAlignment.stretch
                              : CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () => context.go('/articles/write'),
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFF3F4F6),
                                foregroundColor: const Color(0xFF6B7280),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 14,
                                ),
                                minimumSize: Size(
                                  isMobile ? double.infinity : 0,
                                  48,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              child: const Text('취소'),
                            ),
                            SizedBox(
                              width: isMobile ? 0 : 34,
                              height: isMobile ? 12 : 0,
                            ),
                            FilledButton(
                              onPressed: composeState.isSubmitting ||
                                      composeState.isUploadingImage
                                  ? null
                                  : () => onTapPublish(context),
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 42,
                                  vertical: 18,
                                ),
                                minimumSize: Size(
                                  isMobile ? double.infinity : 0,
                                  52,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              child: const Text('출간하기'),
                            ),
                          ],
                        ),
                      ),
                      if (composeState.isUploadingImage ||
                          composeState.isSubmitting)
                        const Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: LinearProgressIndicator(minHeight: 2),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onTapPickThumbnail(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }

    final bytes = await pickedFile.readAsBytes();
    if (!context.mounted) {
      return;
    }

    ref.read(articleWriteViewModelProvider.notifier).setThumbnailImage(
          fileName: _resolveFileName(pickedFile, bytes),
          bytes: bytes,
        );
    _showMessage(context, '썸네일 이미지를 불러왔습니다.');
  }

  Future<void> onTapPublish(BuildContext context) async {
    final composeState = ref.read(articleWriteViewModelProvider);
    final success =
        await ref.read(articleWriteViewModelProvider.notifier).publish(
              title: composeState.title,
              contentMarkdown: composeState.contentMarkdown,
            );

    if (!context.mounted) {
      return;
    }

    final nextState = ref.read(articleWriteViewModelProvider);
    if (!success) {
      _showMessage(
        context,
        nextState.errorMsg.isEmpty ? '출간에 실패했습니다.' : nextState.errorMsg,
      );
      return;
    }

    _showMessage(context, nextState.successMsg);
    context.go('/articles');
  }

  void _syncSummary() {
    ref
        .read(articleWriteViewModelProvider.notifier)
        .setSummary(summaryController.text);
  }

  String _resolveFileName(XFile file, Uint8List bytes) {
    if (file.name.isNotEmpty) {
      return file.name;
    }
    return 'thumbnail_${DateTime.now().millisecondsSinceEpoch}_${bytes.length}.png';
  }

  void _showMessage(BuildContext context, String msg) {
    if (msg.trim().isEmpty) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}

class ConfirmPreviewSection extends StatelessWidget {
  const ConfirmPreviewSection({
    super.key,
    required this.summaryController,
    required this.thumbnailUrl,
    required this.thumbnailBytes,
    required this.isUploadingImage,
    required this.onPickThumbnail,
    required this.isMobile,
    required this.isTablet,
  });

  final TextEditingController summaryController;
  final String? thumbnailUrl;
  final Uint8List? thumbnailBytes;
  final bool isUploadingImage;
  final VoidCallback onPickThumbnail;
  final bool isMobile;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    final hasLocalThumbnail =
        thumbnailBytes != null && thumbnailBytes!.isNotEmpty;
    final hasRemoteThumbnail =
        thumbnailUrl != null && thumbnailUrl!.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ConfirmSectionTitle(
          title: '01. 포스트 미리보기',
        ),
        SizedBox(height: isMobile ? 16 : 20),
        const Text(
          '썸네일 이미지',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: isUploadingImage ? null : onPickThumbnail,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            height: isMobile ? 180 : (isTablet ? 200 : 220),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              border: Border.all(color: const Color(0xFFF3F4F6)),
              borderRadius: BorderRadius.circular(14),
              image: hasLocalThumbnail
                  ? DecorationImage(
                      image: MemoryImage(thumbnailBytes!),
                      fit: BoxFit.cover,
                    )
                  : hasRemoteThumbnail
                      ? DecorationImage(
                          image: NetworkImage(thumbnailUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
            ),
            child: Stack(
              children: [
                if (!hasLocalThumbnail && !hasRemoteThumbnail)
                  const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 30,
                          color: Color(0xFF9CA3AF),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '이미지 변경',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF9CA3AF),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Text(
                        '이미지 변경',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: isMobile ? 18 : 24),
        const Text(
          '포스트 요약',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            TextField(
              controller: summaryController,
              maxLength: 150,
              maxLines: isMobile ? 5 : 6,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFF9FAFB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide(color: Color(0xFFF3F4F6)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide(color: Color(0xFFD1D5DB)),
                ),
                hintText: '당신의 포스트를 짧게 요약해 보세요...',
                hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                counterText: '',
                contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 28),
              ),
              style: const TextStyle(
                color: Color(0xFF4B5563),
                fontSize: 14,
                height: 1.7,
              ),
            ),
            Positioned(
              bottom: 10,
              right: 12,
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: summaryController,
                builder: (context, value, child) {
                  return Text(
                    '${value.text.length} / 150',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFFD1D5DB),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ConfirmSectionTitle extends StatelessWidget {
  const ConfirmSectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFF3F4F6)),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF9CA3AF),
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _ArticleConfirmPermissionDeniedView extends StatelessWidget {
  const _ArticleConfirmPermissionDeniedView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'ORGANIZER 이상 권한이 필요합니다.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => context.go('/articles'),
                child: const Text('목록으로 이동'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
