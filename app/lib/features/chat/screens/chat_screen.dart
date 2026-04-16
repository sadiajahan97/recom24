import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recom24/core/models/models.dart';
import 'package:recom24/core/theme/app_theme.dart';
import 'package:recom24/shared/widgets/recom_app_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  final List<ChatMessage> _messages = const [
    ChatMessage(
      content:
          "Hello Alex! I've analyzed your upcoming schedule. You have a networking event tonight and three strategic tasks pending. How can I help you excel today?",
      isAi: true,
      time: '09:15 AM',
    ),
    ChatMessage(
      content:
          'Where should I focus today to maximize my growth impact?',
      isAi: false,
      time: '09:16 AM',
    ),
    ChatMessage(
      content:
          'Based on your KPIs, your primary focus should be the **Market Expansion Proposal**. Completing this today unlocks three subsequent projects.',
      isAi: true,
      time: '09:17 AM',
      progressLabel: 'PROPOSAL PROGRESS',
      progressPercent: 65,
      quote:
          '"Growth is never by mere chance; it is the result of forces working together." — James Cash Penney',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const RecomAppBar(title: 'Chat', showBack: false),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              itemCount: _messages.length,
              itemBuilder: (context, i) => _ChatBubble(
                message: _messages[i],
              )
                  .animate()
                  .fadeIn(
                    delay: Duration(milliseconds: i * 150),
                    duration: 400.ms,
                  )
                  .slideY(begin: 0.05, end: 0),
            ),
          ),
          _ChatInputBar(controller: _controller, onSend: _onSend),
        ],
      ),
    );
  }

  void _onSend() {
    // API integration will be added later
    _controller.clear();
  }
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isAi = message.isAi;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment:
            isAi ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
                isAi ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              if (isAi) ...[
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.smart_toy_rounded,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isAi ? AppColors.primary : AppColors.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isAi ? 4 : 16),
                      topRight: Radius.circular(isAi ? 16 : 4),
                      bottomLeft: const Radius.circular(16),
                      bottomRight: const Radius.circular(16),
                    ),
                    border: isAi
                        ? null
                        : Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMessageText(message.content, isAi),
                      if (message.progressLabel != null) ...[
                        const SizedBox(height: 12),
                        _ProgressWidget(
                          label: message.progressLabel!,
                          percent: message.progressPercent ?? 0,
                        ),
                      ],
                      if (message.quote != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          message.quote!,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (!isAi) const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: EdgeInsets.only(left: isAi ? 46 : 0),
            child: Text(
              '${isAi ? 'RECOM AI' : 'YOU'} • ${message.time}',
              style: GoogleFonts.inter(
                fontSize: 10,
                color: AppColors.textHint,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageText(String text, bool isAi) {
    // Simple bold markdown parsing
    final parts = text.split('**');
    return RichText(
      text: TextSpan(
        style: GoogleFonts.inter(
          fontSize: 14,
          color: isAi ? Colors.white : AppColors.textPrimary,
          height: 1.5,
        ),
        children: parts.asMap().entries.map((e) {
          final isBold = e.key.isOdd;
          return TextSpan(
            text: e.value,
            style: isBold
                ? const TextStyle(fontWeight: FontWeight.w700)
                : null,
          );
        }).toList(),
      ),
    );
  }
}

class _ProgressWidget extends StatelessWidget {
  final String label;
  final int percent;

  const _ProgressWidget({required this.label, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.white.withValues(alpha: 0.8),
                letterSpacing: 0.5,
              ),
            ),
            Text(
              '$percent%',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percent / 100,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            valueColor: const AlwaysStoppedAnimation(Colors.white),
            minHeight: 5,
          ),
        ),
      ],
    );
  }
}

class _ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const _ChatInputBar({
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file_outlined,
                color: AppColors.textHint),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: controller,
              style: GoogleFonts.inter(
                  fontSize: 14, color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Message Recom...',
                hintStyle: GoogleFonts.inter(
                    fontSize: 14, color: AppColors.textHint),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          GestureDetector(
            onTap: onSend,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.send_rounded,
                  color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
