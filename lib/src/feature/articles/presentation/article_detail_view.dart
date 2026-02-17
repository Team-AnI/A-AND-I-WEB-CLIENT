import 'package:a_and_i_report_web_server/src/feature/home/presentation/views/home_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArticleDetailView extends StatelessWidget {
  const ArticleDetailView({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;
    final isTablet = width >= 768 && width < 1200;
    final horizontal = isMobile ? 18.0 : (isTablet ? 28.0 : 24.0);
    final topPadding = isMobile ? 16.0 : 22.0;
    final bottomPadding = isMobile ? 40.0 : 56.0;
    final contentMaxWidth = isMobile ? 640.0 : 800.0;
    final headingFont = isMobile ? 32.0 : (isTablet ? 40.0 : 46.0);
    final subHeadingFont = isMobile ? 24.0 : 30.0;
    final introFont = isMobile ? 18.0 : (isTablet ? 20.0 : 23.0);
    final bodyFont = isMobile ? 16.0 : 18.0;
    final codeFont = isMobile ? 12.0 : 13.0;
    final mediaHeight = isMobile ? 200.0 : (isTablet ? 240.0 : 290.0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const ArticleDetailProgressHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(horizontal, topPadding, horizontal, bottomPadding),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: contentMaxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          TextButton(
                            onPressed: () => context.go('/'),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text('Home'),
                          ),
                          const Icon(Icons.chevron_right, size: 16),
                          TextButton(
                            onPressed: () => context.go('/articles'),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text('Articles'),
                          ),
                          const Icon(Icons.chevron_right, size: 16),
                          Text(
                            id,
                            style: const TextStyle(
                              color: HomeTheme.textMain,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isMobile ? 18 : 26),
                      Text(
                        'The Future of Artificial Intelligence in Modern Education',
                        style: TextStyle(
                          color: HomeTheme.textMain,
                          fontSize: headingFont,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                          letterSpacing: -1.1,
                        ),
                      ),
                      SizedBox(height: isMobile ? 16 : 24),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: isMobile ? 14 : 18),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.black.withValues(alpha: 0.06),
                            ),
                            bottom: BorderSide(
                              color: Colors.black.withValues(alpha: 0.06),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: isMobile ? 19 : 22,
                              backgroundColor: Colors.black.withValues(alpha: 0.06),
                              child: const Icon(Icons.person, color: HomeTheme.textMuted),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'By A&I Research Team',
                                    style: TextStyle(
                                      color: HomeTheme.textMain,
                                      fontSize: isMobile ? 13 : 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'October 24, 2023',
                                    style: TextStyle(
                                      color: HomeTheme.textMuted,
                                      fontSize: isMobile ? 10 : 11,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 8 : 10,
                                vertical: isMobile ? 5 : 6,
                              ),
                              decoration: BoxDecoration(
                                color: HomeTheme.primary,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                'RESEARCH',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isMobile ? 9 : 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: isMobile ? 18 : 26),
                      Text(
                        'Explore how adaptive learning algorithms and generative models are reshaping the pedagogical landscape for the next generation of scholars.',
                        style: TextStyle(
                          color: HomeTheme.textMuted.withValues(alpha: 0.9),
                          fontSize: introFont,
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: isMobile ? 16 : 24),
                      ArticleDetailParagraph(
                        fontSize: bodyFont,
                        text:
                            'As we stand at the precipice of a new era in educational technology, artificial intelligence is no longer a distant promise but a present reality. The integration of large language models and machine learning into the classroom is creating unprecedented opportunities for personalized learning at scale.',
                      ),
                      SizedBox(height: isMobile ? 16 : 20),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
                        ),
                        padding: EdgeInsets.all(isMobile ? 14 : 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Core Objectives of A&I Integration',
                              style: TextStyle(
                                color: HomeTheme.textMain,
                                fontSize: isMobile ? 20 : 24,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.4,
                              ),
                            ),
                            SizedBox(height: isMobile ? 10 : 14),
                            ArticleDetailObjectiveItem(
                              text: 'Personalized curriculum pacing tailored to individual student cognitive loads.',
                              index: '01',
                              fontSize: isMobile ? 14 : 16,
                            ),
                            SizedBox(height: isMobile ? 8 : 10),
                            ArticleDetailObjectiveItem(
                              text: 'Automated administrative tasks allowing educators to focus on mentorship.',
                              index: '02',
                              fontSize: isMobile ? 14 : 16,
                            ),
                            SizedBox(height: isMobile ? 8 : 10),
                            ArticleDetailObjectiveItem(
                              text: 'Real-time feedback loops for both learners and institutional researchers.',
                              index: '03',
                              fontSize: isMobile ? 14 : 16,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: isMobile ? 16 : 22),
                      Text(
                        'The Shift Toward Adaptive Systems',
                        style: TextStyle(
                          color: HomeTheme.textMain,
                          fontSize: subHeadingFont,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: isMobile ? 10 : 14),
                      ArticleDetailParagraph(
                        fontSize: bodyFont,
                        text:
                            'Adaptive learning systems utilize data-driven insights to adjust the difficulty and style of content delivered to a student. This ensures that a learner is neither bored by content that is too simple nor overwhelmed by material that is too advanced.',
                      ),
                      SizedBox(height: isMobile ? 16 : 22),
                      Container(
                        width: double.infinity,
                        height: mediaHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: const Color(0xFFF3F4F6),
                          border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.analytics,
                          size: isMobile ? 52 : 68,
                          color: Colors.black.withValues(alpha: 0.2),
                        ),
                      ),
                      SizedBox(height: isMobile ? 6 : 8),
                      Center(
                        child: Text(
                          'Figure 1.1: Data flow in centralized adaptive learning architectures.',
                          style: TextStyle(
                            color: HomeTheme.textMuted,
                            fontSize: isMobile ? 11 : 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 16 : 20),
                      ArticleDetailParagraph(
                        fontSize: bodyFont,
                        text:
                            'Our research indicates that institutions implementing these systems have seen a 24% increase in student engagement metrics. However, the ethical considerations of data privacy and algorithmic bias remain paramount in our ongoing investigations.',
                      ),
                      SizedBox(height: isMobile ? 14 : 18),
                      Text(
                        'Implementation Example',
                        style: TextStyle(
                          color: HomeTheme.textMain,
                          fontSize: subHeadingFont,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: isMobile ? 8 : 10),
                      ArticleDetailParagraph(
                        fontSize: bodyFont,
                        text:
                            'Below is a simplified conceptual model for a student progress tracking function within our proposed A&I framework:',
                      ),
                      SizedBox(height: isMobile ? 8 : 10),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF111827),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(isMobile ? 12 : 16),
                        child: SelectableText(
                          "# Adaptive Feedback Logic\n"
                          "def calculate_next_module(student_data):\n"
                          "    performance_score = student_data.get('avg_score')\n"
                          "    time_spent = student_data.get('session_minutes')\n\n"
                          "    if performance_score > 0.85 and time_spent < 30:\n"
                          "        return \"Advanced_Synthesis_A1\"\n"
                          "    elif performance_score < 0.60:\n"
                          "        return \"Review_Fundamentals_B2\"\n\n"
                          "    return \"Standard_Path_C1\"",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: codeFont,
                            height: 1.55,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 16 : 22),
                      ArticleDetailParagraph(
                        fontSize: bodyFont,
                        text:
                            'In conclusion, the future of AI in education is not about replacing the human element, but augmenting it. By leveraging these tools, we can create more inclusive, efficient, and inspiring educational environments for everyone.',
                      ),
                      SizedBox(height: isMobile ? 26 : 40),
                      Center(
                        child: TextButton.icon(
                          onPressed: () => context.go('/articles'),
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('목록으로 돌아가기'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ArticleDetailProgressHeader extends StatelessWidget {
  const ArticleDetailProgressHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 4,
      color: Colors.black.withValues(alpha: 0.05),
      alignment: Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        color: HomeTheme.primary,
      ),
    );
  }
}

class ArticleDetailParagraph extends StatelessWidget {
  const ArticleDetailParagraph({
    super.key,
    required this.text,
    this.fontSize = 18,
  });

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: Color(0xFF374151),
          height: 1.8,
        ).copyWith(fontSize: fontSize),
    );
  }
}

class ArticleDetailObjectiveItem extends StatelessWidget {
  const ArticleDetailObjectiveItem({
    super.key,
    required this.text,
    required this.index,
    this.fontSize = 16,
  });

  final String text;
  final String index;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$index.',
          style: TextStyle(
            color: HomeTheme.primary,
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Color(0xFF374151),
              fontSize: fontSize,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
