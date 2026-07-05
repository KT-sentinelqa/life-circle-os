import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'timeline_event.freezed.dart';

/// Represents a unified chronological event across all family domains
/// (Medicine, EMI, Insurance, Duties).
@freezed
class TimelineEvent with _$TimelineEvent {
  /// Creates an immutable timeline event.
  const factory TimelineEvent({
    required String id,
    required String title,
    required DateTime time,
    required IconData icon,
    required Color color,
    required bool isCompleted,
    @Default(false) bool isCritical,
  }) = _TimelineEvent;
}
