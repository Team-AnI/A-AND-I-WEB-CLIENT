import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/presentation/widgets/article_editor_markdown_actions.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/presentation/widgets/article_editor_panel.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/presentation/widgets/article_preview_panel.dart';

const String articleWriteDefaultTitle =
    'The Future of Artificial Intelligence in Modern Education';
const String articleWriteDefaultMarkdown =
    '> Explore how adaptive learning algorithms and generative models are reshaping the pedagogical landscape for the next generation of scholars.\n\n'
    'As we stand at the precipice of a new era in educational technology, artificial intelligence is no longer a distant promise but a present reality. The integration of large language models and machine learning into the classroom is creating unprecedented opportunities for personalized learning at scale.\n\n'
    '## The Shift Toward Adaptive Systems\n\n'
    'Adaptive learning systems utilize data-driven insights to adjust the difficulty and style of content delivered to a student. This ensures that a learner is neither bored by content that is too simple nor overwhelmed by material that is too advanced.';

class ArticleWriteView extends StatefulWidget {
  const ArticleWriteView({super.key});

  @override
  State<ArticleWriteView> createState() => ArticleWriteViewState();
}

class ArticleWriteViewState extends State<ArticleWriteView> {
  late final TextEditingController titleController;
  late final TextEditingController contentController;
  late final FocusNode contentFocusNode;
  late final UndoHistoryController contentUndoController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: articleWriteDefaultTitle);
    contentController = TextEditingController(text: articleWriteDefaultMarkdown);
    contentFocusNode = FocusNode();
    contentUndoController = UndoHistoryController();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    contentFocusNode.dispose();
    contentUndoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final split = width >= 1100;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Shortcuts(
          shortcuts: const <ShortcutActivator, Intent>{
            SingleActivator(LogicalKeyboardKey.keyZ, control: true):
                ArticleUndoIntent(),
            SingleActivator(LogicalKeyboardKey.keyZ, meta: true):
                ArticleUndoIntent(),
            SingleActivator(LogicalKeyboardKey.keyZ, control: true, shift: true):
                ArticleRedoIntent(),
            SingleActivator(LogicalKeyboardKey.keyZ, meta: true, shift: true):
                ArticleRedoIntent(),
          },
          child: Actions(
            actions: <Type, Action<Intent>>{
              ArticleUndoIntent: CallbackAction<ArticleUndoIntent>(
                onInvoke: (intent) {
                  if (contentFocusNode.hasFocus &&
                      contentUndoController.value.canUndo) {
                    contentUndoController.undo();
                  }
                  return null;
                },
              ),
              ArticleRedoIntent: CallbackAction<ArticleRedoIntent>(
                onInvoke: (intent) {
                  if (contentFocusNode.hasFocus &&
                      contentUndoController.value.canRedo) {
                    contentUndoController.redo();
                  }
                  return null;
                },
              ),
            },
            child: Stack(
              children: [
                ListenableBuilder(
                  listenable: Listenable.merge([
                    titleController,
                    contentController,
                  ]),
                  builder: (context, child) {
                    if (split) {
                      return Row(
                        children: [
                          Expanded(
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Color(0xFFE5E7EB)),
                                ),
                              ),
                              child: ArticleEditorPanel(
                                titleController: titleController,
                                contentController: contentController,
                                contentFocusNode: contentFocusNode,
                                contentUndoController: contentUndoController,
                                onExit: () => context.go('/articles'),
                                onBold: onTapBold,
                                onItalic: onTapItalic,
                                onStrikethrough: onTapStrikethrough,
                                onQuote: onTapQuote,
                                onCodeBlock: onTapCodeBlock,
                                onImage: onTapImage,
                                onLink: onTapLink,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ArticlePreviewPanel(
                              title: titleController.text.trim(),
                              markdown: contentController.text,
                            ),
                          ),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: ArticleEditorPanel(
                            titleController: titleController,
                            contentController: contentController,
                            contentFocusNode: contentFocusNode,
                            contentUndoController: contentUndoController,
                            onExit: () => context.go('/articles'),
                            onBold: onTapBold,
                            onItalic: onTapItalic,
                            onStrikethrough: onTapStrikethrough,
                            onQuote: onTapQuote,
                            onCodeBlock: onTapCodeBlock,
                            onImage: onTapImage,
                            onLink: onTapLink,
                          ),
                        ),
                        const Divider(height: 1, color: Color(0xFFE5E7EB)),
                        Expanded(
                          child: ArticlePreviewPanel(
                            title: titleController.text.trim(),
                            markdown: contentController.text,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Positioned(
                  right: split ? 32 : 16,
                  bottom: split ? 24 : 16,
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFF3F4F6),
                          foregroundColor: const Color(0xFF374151),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          '임시저장',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(width: 10),
                      FilledButton(
                        onPressed: () => context.go('/articles/confirm'),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF111827),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 26,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          '출간하기',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapBold() {
    ArticleEditorMarkdownActions.applyBold(contentController, contentFocusNode);
  }

  void onTapItalic() {
    ArticleEditorMarkdownActions.applyItalic(contentController, contentFocusNode);
  }

  void onTapStrikethrough() {
    ArticleEditorMarkdownActions.applyStrikethrough(
      contentController,
      contentFocusNode,
    );
  }

  void onTapQuote() {
    ArticleEditorMarkdownActions.applyQuote(contentController, contentFocusNode);
  }

  void onTapCodeBlock() {
    ArticleEditorMarkdownActions.applyCodeBlock(
      contentController,
      contentFocusNode,
    );
  }

  void onTapImage() {
    ArticleEditorMarkdownActions.applyImage(contentController, contentFocusNode);
  }

  void onTapLink() {
    ArticleEditorMarkdownActions.applyLink(contentController, contentFocusNode);
  }
}

class ArticleUndoIntent extends Intent {
  const ArticleUndoIntent();
}

class ArticleRedoIntent extends Intent {
  const ArticleRedoIntent();
}
