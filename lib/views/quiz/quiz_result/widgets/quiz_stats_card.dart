import 'package:e_learning_application_clone/core/theme/app_colors.dart';
import 'package:e_learning_application_clone/models/quiz.dart';
import 'package:e_learning_application_clone/models/quiz_attempt.dart';
import 'package:flutter/material.dart';

class QuizStatsCard extends StatelessWidget {
  final QuizAttempt attempt;
  final Quiz quiz;
  const QuizStatsCard({super.key, required this.attempt, required this.quiz});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final correctAnswer = quiz.questions
        .where((q) => attempt.answers[q.id] == q.correctOptionId)
        .length;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quiz Statistics',
            style: theme.textTheme.titleLarge?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildStatRow(
            theme,
            'Time Spent',
            '${attempt.timeSpent ~/ 60 > 0 ? '${attempt.timeSpent ~/ 60}m ' : ''}${attempt.timeSpent % 60}s',
            Icons.timer,
          ),
          _buildStatRow(
            theme,
            'Correct Answers',
            '$correctAnswer/${quiz.questions.length}',
            Icons.check_circle,
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(
    ThemeData theme,
    String label,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Text(
            label,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.secondary,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
