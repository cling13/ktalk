import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ktalk/chat/models/message_model.dart';
import 'package:ktalk/common/providers/custom_theme_provider.dart';

class MessageCardWidget extends ConsumerStatefulWidget {
  final MessageModel messageModel;

  const MessageCardWidget({
    super.key,
    required this.messageModel,
  });

  @override
  ConsumerState<MessageCardWidget> createState() => _MessageCardWidgetState();
}

class _MessageCardWidgetState extends ConsumerState<MessageCardWidget> {
  @override
  Widget build(BuildContext context) {
    final themeColor = ref.watch(customThemeProvider).themeColor;
    final messageModel = widget.messageModel;

    return const Placeholder();
  }
}
