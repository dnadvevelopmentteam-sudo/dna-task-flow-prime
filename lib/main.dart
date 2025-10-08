import 'package:dna_taskflow_prime/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Admin Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Inter', useMaterial3: true),
      home: const DashboardScreen(),
      // home: const SignInScreen(),
      // home: const TaskKanbanScreen(),
      // home: const ClientsScreenContent(),
      // home:  TimesheetScreen(),
      // home: TeamTimesheetScreen(),
      // home: EscalationsScreen(),
      // home: TeamDashboardScreen(),
    );
  }
}
