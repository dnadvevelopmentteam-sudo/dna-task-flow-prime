import 'package:dna_taskflow_prime/features/clients/data/models/client.dart';
import 'package:dna_taskflow_prime/features/clients/presentation/widgets/client_card.dart';
import 'package:flutter/material.dart';

class ClientsGrid extends StatelessWidget {
  final List<Client> clients;
  final int crossAxisCount;
  final double cardWidth;

  const ClientsGrid({
    super.key,
    required this.clients,
    required this.crossAxisCount,
    required this.cardWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20.0,
      runSpacing: 20.0,
      children: clients
          .map((client) => ClientCard(client: client, width: cardWidth))
          .toList(),
    );
  }
}
