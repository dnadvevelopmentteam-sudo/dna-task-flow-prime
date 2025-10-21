import 'package:dna_taskflow_prime/features/clients/data/models/client.dart';
import 'package:dna_taskflow_prime/features/clients/presentation/widgets/clients_grid.dart';
import 'package:dna_taskflow_prime/features/clients/presentation/widgets/clients_header.dart';
import 'package:dna_taskflow_prime/features/clients/presentation/widgets/summary_statistics.dart';
import 'package:flutter/material.dart';

final List<Client> sampleClients = [
  Client(
    name: 'Acme Corporation',
    type: 'Private Limited',
    email: 'accounts@techsolutions.in',
    phone: '+91 87654 32109',
    contractEnd: DateTime(2024, 12, 31),
    activeTasks: 8,
    services: ['GST Filing', 'TDS', 'Payroll'],
    isActive: true,
  ),
  Client(
    name: 'Acme Corporation',
    type: 'Private Limited',
    email: 'accounts@techsolutions.in',
    phone: '+91 87654 32109',
    contractEnd: DateTime(2024, 12, 31),
    activeTasks: 8,
    services: ['GST Filing', 'TDS', 'Payroll'],
    isActive: true,
  ),
  Client(
    name: 'Acme Corporation',
    type: 'Private Limited',
    email: 'accounts@techsolutions.in',
    phone: '+91 87654 32109',
    contractEnd: DateTime(2024, 12, 31),
    activeTasks: 8,
    services: ['GST Filing', 'TDS', 'Payroll'],
    isActive: true,
  ),
  Client(
    name: 'Acme Corporation',
    type: 'Private Limited',
    email: 'accounts@techsolutions.in',
    phone: '+91 87654 32109',
    contractEnd: DateTime(2024, 12, 31),
    activeTasks: 8,
    services: ['GST Filing', 'TDS', 'Payroll'],
    isActive: true,
  ),
];

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 1000;
    final gridCrossAxisCount = isSmallScreen ? 1 : 4;
    final clientCardWidth = isSmallScreen ? double.infinity : 350.0;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24.0),
        color: const Color(0xFFFFFFFF),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ClientsHeader(),
              const SizedBox(height: 20),

              const SummaryStatistics(),
              const SizedBox(height: 30),

              ClientsGrid(
                clients: sampleClients,
                crossAxisCount: gridCrossAxisCount,
                cardWidth: clientCardWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
