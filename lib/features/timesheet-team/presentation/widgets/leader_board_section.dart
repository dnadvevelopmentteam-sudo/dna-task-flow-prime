import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF3B82F6);
const Color kTextLightColor = Color(0xFF6B7280);
const Color kCardBorderColor = Color(0xFFE5E7EB);
const Color kRankTextColor = Color(0xFF8F8F8F);

const Color kGoldColor = Color(0xFFFFD700);
const Color kSilverColor = Color(0xFFC0C0C0);
const Color kBronzeColor = Color(0xFFCD7F32);
const Color kRankCircleColor = Color(0xFFD9D9D9);
const Color kRank1Color = Color(0xFF4285F4);

class StaffMember {
  final String name;
  final String fullName;
  final String team;
  final String avatarLetter;
  final double hoursTracked;
  final String hoursAvg;
  final int btrDaysPercentage;
  final int onTimePercentage;
  final int coveragePercentage;

  StaffMember({
    required this.name,
    required this.fullName,
    required this.team,
    required this.avatarLetter,
    required this.hoursTracked,
    required this.hoursAvg,
    required this.btrDaysPercentage,
    required this.onTimePercentage,
    required this.coveragePercentage,
  });
}

final List<StaffMember> mockStaffData = [
  StaffMember(
    name: 'John Doe',
    fullName: 'John Doe',
    team: 'Development Team',
    avatarLetter: 'JD',
    hoursTracked: 42.5,
    hoursAvg: '8.5h avg/day',
    btrDaysPercentage: 85,
    onTimePercentage: 92,
    coveragePercentage: 88,
  ),
  StaffMember(
    name: 'Jane Smith',
    fullName: 'Jane Smith',
    team: 'Development Team',
    avatarLetter: 'JS',
    hoursTracked: 41.0,
    hoursAvg: '8.2h avg/day',
    btrDaysPercentage: 80,
    onTimePercentage: 94,
    coveragePercentage: 91,
  ),
  StaffMember(
    name: 'Bob Wilson',
    fullName: 'Bob Wilson',
    team: 'QA Team',
    avatarLetter: 'BW',
    hoursTracked: 40.5,
    hoursAvg: '8.1h avg/day',
    btrDaysPercentage: 78,
    onTimePercentage: 89,
    coveragePercentage: 85,
  ),
  StaffMember(
    name: 'Alice Brown',
    fullName: 'Alice Brown',
    team: 'Design Team',
    avatarLetter: 'AB',
    hoursTracked: 39.5,
    hoursAvg: '7.9h avg/day',
    btrDaysPercentage: 75,
    onTimePercentage: 87,
    coveragePercentage: 83,
  ),
];

Widget buildLeaderboardSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kCardBorderColor),
        ),
        child: const Text(
          'Team Performance Overview',
          style: TextStyle(
            fontFamily: 'Inter',
            color: Color(0xFF000000),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SizedBox(height: 30),
      _chartCard(
        'Staff Leaderboard',
        _buildLeaderboardTable(),
        headerActions: _buildViewAllMetrics(),
      ),
    ],
  );
}

Widget _buildViewAllMetrics() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: kCardBorderColor),
    ),
    child: const Row(
      children: [
        Icon(Icons.remove_red_eye_outlined, size: 18, color: kTextLightColor),
        SizedBox(width: 6),
        Text(
          'View All Metrics',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: kTextLightColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}

Widget _chartCard(String title, Widget content, {Widget? headerActions}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kCardBorderColor),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.bar_chart, size: 24, color: Color(0xFF0A0A0A)),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    color: Color(0xFF0A0A0A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            if (headerActions != null) headerActions,
          ],
        ),
        const SizedBox(height: 20),
        content,
      ],
    ),
  );
}

Widget _buildLeaderboardTable() {
  return Column(
    children: [
      _leaderboardRow(
        rank: 'Rank',
        staffMember: 'Staff Member',
        hoursTracked: 'Hours',
        onTime: 'On-time %',
        coverage: 'Coverage %',
        btrDays: '8h+ Days',
        isHeader: true,
      ),
      SizedBox(height: 4),
      const Divider(height: 1, thickness: 1, color: kCardBorderColor),
      const SizedBox(height: 15),
      ...mockStaffData.asMap().entries.map((entry) {
        int index = entry.key;
        StaffMember member = entry.value;

        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: _buildClickableContainerRow(
            child: _leaderboardRow(
              rank: '${index + 1}',
              staffMember: member.fullName,
              team: member.team,
              avatarLetter: member.avatarLetter,
              hoursTracked: '${member.hoursTracked}h\n${member.hoursAvg}',
              onTime: '${member.onTimePercentage}',
              coverage: '${member.coveragePercentage}',
              btrDays: '${member.btrDaysPercentage}',
              isHeader: false,
            ),
          ),
        );
      }),
    ],
  );
}

Widget _buildClickableContainerRow({required Widget child}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kCardBorderColor, width: 1),
    ),
    child: InkWell(
      onTap: () {
        print('Staff member row clicked!');
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: child,
      ),
    ),
  );
}

Widget _leaderboardRow({
  required String rank,
  required String staffMember,
  String? team,
  String? avatarLetter,
  required String hoursTracked,
  required String btrDays,
  required String onTime,
  required String coverage,
  required bool isHeader,
}) {
  TextStyle headerStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: kTextLightColor,
  );

  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: isHeader
              ? Center(child: Text(rank, style: headerStyle))
              : Center(child: _buildRankWidget(int.parse(rank))),
        ),

        Expanded(
          flex: 6,
          child: isHeader
              ? Text(staffMember, style: headerStyle)
              : Row(
                  children: [
                    _avatar(avatarLetter!),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          staffMember,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            color: Color(0xFF0A0A0A),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          team!,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: kTextLightColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),

        Expanded(
          flex: 3,
          child: Text(
            hoursTracked,
            style: isHeader
                ? headerStyle
                : const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Color(0xFF0A0A0A),
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
          ),
        ),

        _buildPercentageCell(btrDays, isHeader, headerStyle),
        _buildPercentageCell(onTime, isHeader, headerStyle),
        _buildPercentageCell(coverage, isHeader, headerStyle),
      ],
    ),
  );
}

Widget _buildRankWidget(int rank) {
  if (rank < 4) {
    Color badgeColor;
    IconData icon;
    Color iconColor = Colors.white;

    if (rank == 1) {
      badgeColor = kRank1Color;
      icon = Icons.emoji_events;
    } else if (rank == 2) {
      badgeColor = kSilverColor;
      icon = Icons.emoji_events;
    } else {
      badgeColor = kBronzeColor;
      icon = Icons.emoji_events;
    }

    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: BoxShape.circle, color: badgeColor),
      child: Icon(icon, size: 18, color: iconColor),
    );
  } else {
    return Container(
      alignment: Alignment.center,
      child: Text(
        '#$rank',
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: kRankTextColor,
        ),
      ),
    );
  }
}

Widget _avatar(String letter) {
  return Container(
    width: 35,
    height: 35,
    alignment: Alignment.center,
    decoration: BoxDecoration(shape: BoxShape.circle, color: kRankCircleColor),
    child: Text(
      letter,
      style: const TextStyle(
        fontFamily: 'Inter',
        color: Color(0xFF0A0A0A),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _buildPercentageCell(String text, bool isHeader, TextStyle headerStyle) {
  int value = int.tryParse(text) ?? 0;
  String display = '$value%';

  return Expanded(
    flex: 5,
    child: isHeader
        ? Center(child: Text(text, style: headerStyle))
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                display,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0A0A0A),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: value / 100,
                    backgroundColor: kCardBorderColor,
                    color: kPrimaryColor,
                    minHeight: 8,
                  ),
                ),
              ),
            ],
          ),
  );
}
