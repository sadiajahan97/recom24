import 'package:flutter/material.dart';

enum RecommendationStatus { urgent, newItem, regular }

enum RecommendationCategory { all, strategy, networking, health, skill }

class Recommendation {
  final int index;
  final String title;
  final RecommendationStatus status;
  final String category;
  final int durationMinutes;
  final String difficulty;
  final bool isCompleted;

  const Recommendation({
    required this.index,
    required this.title,
    required this.status,
    required this.category,
    required this.durationMinutes,
    required this.difficulty,
    this.isCompleted = false,
  });
}

class LearnContent {
  final String title;
  final String subtitle;
  final String type; // SEMINAR, INTENSIVE, etc.
  final String duration;
  final String? imageUrl;
  final Color overlayColor;

  const LearnContent({
    required this.title,
    required this.subtitle,
    required this.type,
    required this.duration,
    this.imageUrl,
    this.overlayColor = Colors.black45,
  });
}

class NotificationItem {
  final String icon;
  final String title;
  final String body;
  final String time;
  final String group;
  final bool isRead;

  const NotificationItem({
    required this.icon,
    required this.title,
    required this.body,
    required this.time,
    required this.group,
    this.isRead = true,
  });
}

class ChatMessage {
  final String content;
  final bool isAi;
  final String time;
  final String? progressLabel;
  final int? progressPercent;
  final String? quote;

  const ChatMessage({
    required this.content,
    required this.isAi,
    required this.time,
    this.progressLabel,
    this.progressPercent,
    this.quote,
  });
}
