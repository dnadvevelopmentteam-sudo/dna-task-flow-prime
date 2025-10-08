class Client {
  final String name;
  final String type;
  final String email;
  final String phone;
  final DateTime contractEnd;
  final int activeTasks;
  final List<String> services;
  final bool isActive;

  Client({
    required this.name,
    required this.type,
    required this.email,
    required this.phone,
    required this.contractEnd,
    required this.activeTasks,
    required this.services,
    required this.isActive,
  });
}
