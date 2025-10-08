import 'package:dna_taskflow_prime/features/clients/data/models/client.dart';
import 'package:flutter/material.dart';

class ClientCard extends StatelessWidget {
  final Client client;
  final double width;

  const ClientCard({super.key, required this.client, required this.width});

  // Helper for contact/info rows
  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF95A5A6)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Color(0xFF34495E)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Client Name and Status Tag
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    client.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  Text(
                    client.type,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF7F8C8D),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: client.isActive
                      ? const Color(0xFF2ECC71)
                      : const Color(0xFF95A5A6),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  client.isActive ? 'Active' : 'Inactive',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 25, color: Color(0xFFECF0F1)),

          // Contact and Contract Info
          _buildInfoRow(Icons.email_outlined, client.email),
          _buildInfoRow(Icons.phone_outlined, client.phone),
          _buildInfoRow(
            Icons.calendar_today_outlined,
            'Contract ends: ${client.contractEnd.day}/${client.contractEnd.month}/${client.contractEnd.year}',
          ),
          _buildInfoRow(
            Icons.task_alt_outlined,
            '${client.activeTasks} active tasks',
          ),
          const SizedBox(height: 10),

          // Services Tags
          const Text(
            'Services:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7F8C8D),
            ),
          ),
          const SizedBox(height: 5),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: client.services
                .map(
                  (service) => Chip(
                    label: Text(
                      service,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF34495E),
                      ),
                    ),
                    backgroundColor: const Color(0xFFECF0F1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF34495E),
                    side: const BorderSide(color: Color(0xFFBDC3C7)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('View Details'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3498DB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text('Manage Tasks'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
