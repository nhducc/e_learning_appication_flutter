import 'package:e_learning_application_clone/core/theme/app_colors.dart';
import 'package:e_learning_application_clone/views/profile/widgets/profile_app_bar.dart';
import 'package:e_learning_application_clone/views/profile/widgets/profile_options.dart';
import 'package:e_learning_application_clone/views/profile/widgets/profile_stats_card.dart';
import 'package:flutter/material.dart';

class ProflieScreen extends StatelessWidget {
  const ProflieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          ProfileAppBar(
            initials: 'DL',
            fullName: 'D Lucas',
            email: 'dlucas7523@gmail.com',
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ProfileStatsCard(),
                  SizedBox(height: 24),
                  ProfileOptions(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
