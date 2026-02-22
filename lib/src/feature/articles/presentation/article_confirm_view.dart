import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArticleConfirmView extends StatefulWidget {
  const ArticleConfirmView({super.key});

  @override
  State<ArticleConfirmView> createState() => ArticleConfirmViewState();
}

class ArticleConfirmViewState extends State<ArticleConfirmView> {
  late final TextEditingController summaryController;
  late final TextEditingController tagController;
  final List<String> tags = <String>['Research', 'AI', 'Design'];

  @override
  void initState() {
    super.initState();
    summaryController = TextEditingController();
    tagController = TextEditingController();
  }

  @override
  void dispose() {
    summaryController.dispose();
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;
    final isTablet = width >= 768 && width < 1200;
    final maxWidth = isMobile ? 680.0 : (isTablet ? 980.0 : 1200.0);
    final outerHorizontal = isMobile ? 14.0 : (isTablet ? 22.0 : 32.0);
    final contentHorizontal = isMobile ? 6.0 : (isTablet ? 10.0 : 20.0);
    final topBottom = isMobile ? 18.0 : (isTablet ? 30.0 : 40.0);
    final gap = isMobile ? 0.0 : (isTablet ? 28.0 : 60.0);

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
                      if (isMobile)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ConfirmPreviewSection(
                              summaryController: summaryController,
                              isMobile: isMobile,
                              isTablet: isTablet,
                            ),
                            const SizedBox(height: 28),
                            ConfirmTagSection(
                              tagController: tagController,
                              tags: tags,
                              onAddTag: onAddTag,
                              onRemoveTag: onRemoveTag,
                              isMobile: isMobile,
                              isTablet: isTablet,
                            ),
                          ],
                        )
                      else
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ConfirmPreviewSection(
                                summaryController: summaryController,
                                isMobile: isMobile,
                                isTablet: isTablet,
                              ),
                            ),
                            SizedBox(width: gap),
                            Expanded(
                              child: ConfirmTagSection(
                                tagController: tagController,
                                tags: tags,
                                onAddTag: onAddTag,
                                onRemoveTag: onRemoveTag,
                                isMobile: isMobile,
                                isTablet: isTablet,
                              ),
                            ),
                          ],
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
                              onPressed: () {},
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

  void onAddTag() {
    final tag = tagController.text.trim();
    if (tag.isEmpty) return;
    if (tags.any((e) => e.toLowerCase() == tag.toLowerCase())) {
      tagController.clear();
      return;
    }
    setState(() {
      tags.add(tag);
      tagController.clear();
    });
  }

  void onRemoveTag(String tag) {
    setState(() {
      tags.remove(tag);
    });
  }
}

class ConfirmPreviewSection extends StatelessWidget {
  const ConfirmPreviewSection({
    super.key,
    required this.summaryController,
    required this.isMobile,
    required this.isTablet,
  });

  final TextEditingController summaryController;
  final bool isMobile;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
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
        Container(
          height: isMobile ? 180 : (isTablet ? 200 : 220),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            border: Border.all(color: const Color(0xFFF3F4F6)),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Center(
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

class ConfirmTagSection extends StatelessWidget {
  const ConfirmTagSection({
    super.key,
    required this.tagController,
    required this.tags,
    required this.onAddTag,
    required this.onRemoveTag,
    required this.isMobile,
    required this.isTablet,
  });

  final TextEditingController tagController;
  final List<String> tags;
  final VoidCallback onAddTag;
  final ValueChanged<String> onRemoveTag;
  final bool isMobile;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ConfirmSectionTitle(
          title: '02. 태그 설정',
        ),
        SizedBox(height: isMobile ? 16 : 20),
        const Text(
          '태그 추가',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: tagController,
          onSubmitted: (_) => onAddTag(),
          decoration: InputDecoration(
            hintText: '태그를 입력하고 엔터를 누르세요',
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black),
            ),
            suffixIcon: IconButton(
              onPressed: onAddTag,
              icon: const Icon(Icons.add, size: 18),
            ),
          ),
        ),
        SizedBox(height: isMobile ? 14 : 18),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: tags
              .map(
                (tag) => Container(
                  padding: const EdgeInsets.only(left: 14, right: 6, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        tag.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                      IconButton(
                        onPressed: () => onRemoveTag(tag),
                        constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                        padding: const EdgeInsets.only(left: 6),
                        icon: const Icon(Icons.close, size: 14, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 14),
        const Text(
          '* 적절한 태그는 포스트가 더 많은 독자에게 노출되는 데 도움이 됩니다.',
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFF9CA3AF),
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
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
