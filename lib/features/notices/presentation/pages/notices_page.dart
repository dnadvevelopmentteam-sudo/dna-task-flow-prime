import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/create_announcment_dialogbox.dart';
import 'package:dna_taskflow_prime/features/notices/data/models/notice_models.dart';
import 'package:dna_taskflow_prime/features/notices/presentation/widgets/action_button_notices.dart';
import 'package:dna_taskflow_prime/features/notices/presentation/widgets/active_tab_content.dart';
import 'package:dna_taskflow_prime/features/notices/presentation/widgets/archived_tab_content.dart';
import 'package:dna_taskflow_prime/features/notices/presentation/widgets/drafts_tab_content.dart';
import 'package:flutter/material.dart';

class AppColorss {
  static const Color primary = Color(0xFF1976D2);
  static const Color background = Color(0xFFF7F7F7);
  static const Color textDark = Color(0xFF333333);
  static const Color textLight = Color(0xFF999999);
  static const Color cardBackground = Colors.white;

  static const Color normal = Color(0xFF64B5F6);
  static const Color medium = Color(0xFFFFB74D);
  static const Color high = Color(0xFFE57373);
  static const Color critical = Color(0xFFD32F2F);

  static Color getPriorityColor(Priority p) {
    switch (p) {
      case Priority.normal:
        return normal;
      case Priority.medium:
        return medium;
      case Priority.high:
        return high;
      case Priority.critical:
        return critical;
    }
  }

  static Color getPriorityTextColor(Priority p) {
    if (p == Priority.critical) return Colors.white;
    return textDark;
  }
}

void showCreateDialog(BuildContext context, String title) {
  if (title.contains('Announcement')) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CreateAnnouncementDialog();
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text('This is the dialog box for $title.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class NoticeBoardScreen extends StatelessWidget {
  const NoticeBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const tabCount = 3;

    return DefaultTabController(
      length: tabCount,
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          // backgroundColor: Color(0xFFFFFFFF),
          // elevation: 0.0,
          toolbarHeight: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search notices...',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColorss.textLight,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: AppColorss.cardBackground,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ActionButtonNotices(
                        icon: Icons.add,
                        label: 'Create Announcement',
                        onPressed: () =>
                            showCreateDialog(context, 'Create Announcement'),
                      ),
                      // ActionButtonNotices(
                      //   icon: Icons.add,
                      //   label: 'Create Notice',
                      //   onPressed: () =>
                      //       showCreateDialog(context, 'Create Notice'),
                      // ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Container(
                height: 48,
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: AppColorss.textLight.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TabBar(
                  isScrollable: false,
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,

                  indicator: BoxDecoration(
                    color: AppColorss.cardBackground,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: AppColorss.textLight.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),

                  labelColor: AppColorss.textDark,
                  unselectedLabelColor: AppColorss.textDark.withOpacity(0.7),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),

                  tabs: const [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.notifications_none, size: 20),
                          SizedBox(width: 8),
                          Text('Active (8)'),
                        ],
                      ),
                    ),
                    Tab(text: 'Drafts (0)'),
                    Tab(text: 'Archived (0)'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Expanded(
                child: TabBarView(
                  children: [
                    ActiveTabContent(),
                    DraftsTabContent(),
                    ArchivedTabContent(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
