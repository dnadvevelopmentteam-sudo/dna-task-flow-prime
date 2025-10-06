import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/leadboard_section.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/my_assest_section.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/quick_action_section.dart';
import 'package:flutter/material.dart';

class BottomSectionsRow extends StatelessWidget {
  const BottomSectionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    const leaderboard = Expanded(flex: 3, child: LeaderboardSection());
    const quickActions = Expanded(flex: 2, child: QuickActionsSection());
    const myAssets = Expanded(flex: 2, child: MyAssetsSection());

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          LeaderboardSection(),
          SizedBox(height: 20),
          QuickActionsSection(),
          SizedBox(height: 20),
          MyAssetsSection(),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          leaderboard,
          SizedBox(width: 20),
          quickActions,
          SizedBox(width: 20),
          myAssets,
        ],
      );
    }
  }
}
