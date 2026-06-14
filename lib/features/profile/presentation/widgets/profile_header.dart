import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class ProfileHeader extends StatelessWidget {
  final String initial;
  final String firstName;
  final String lastName;
  final String email;

  const ProfileHeader({
    super.key,
    this.initial = 'H',
    this.firstName = 'Hira',
    this.lastName = 'Ahmed',
    this.email = 'hira.ahmed@gmail.com',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // .profile-avatar: 80x80 circle, pink gradient
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.pinkSoft, AppColors.pink],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x40D4537E),
                blurRadius: 20,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Text(
              initial,
              style: AppTypography.display(
                fontSize: 32,
                color: Colors.white,
              ).copyWith(letterSpacing: -0.5),
            ),
          ),
        ),

        const SizedBox(height: 14),

        // .profile-name: DM Serif 24px — plain + italic last name
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$firstName ',
                style: AppTypography.display(
                  fontSize: 24,
                  color: AppColors.ink,
                ).copyWith(letterSpacing: -0.3),
              ),
              TextSpan(
                text: lastName,
                style: AppTypography.displayItalic(
                  fontSize: 24,
                  color: AppColors.ink,
                ).copyWith(letterSpacing: -0.3),
              ),
            ],
          ),
        ),

        const SizedBox(height: 4),

        // .profile-email: 13px ink-4
        Text(
          email,
          style: AppTypography.body(
            fontSize: 13,
            color: AppColors.ink4,
          ),
        ),
      ],
    );
  }
}
