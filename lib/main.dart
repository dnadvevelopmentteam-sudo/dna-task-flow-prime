import 'package:dna_taskflow_prime/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/dashboard/presentation/pages/dashboard_page.dart';

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
      home: MultiBlocProvider(
        providers: [BlocProvider<DashboardBloc>.value(value: DashboardBloc())],
        child: DashboardScreen(),
        // child: SignInScreen(),
      ),
    );
  }
}
