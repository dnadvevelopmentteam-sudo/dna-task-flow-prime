import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// --- UTILITIES FOR RESPONSIVE TEXT AND WIDGET SPACING ---

extension ResponsiveTextExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  // Base mobile width for scaling comparison
  static const double mobileBreakpoint = 600;
  static const double desktopBreakpoint = 900;

  // Scales the font size based on screen width, with a minimum size limit.
  double scaleFont(double baseSize) {
    if (screenWidth >= mobileBreakpoint) {
      // Use the base size on tablet/desktop
      return baseSize;
    }
    // Calculate scale factor: ScreenWidth / MobileBreakpoint.
    // Clamp it to prevent font sizes from shrinking below 85% of the base size.
    final double scaleFactor = (screenWidth / mobileBreakpoint).clamp(
      0.85,
      1.0,
    );
    return baseSize * scaleFactor;
  }

  // Helper to determine if we are in mobile view for layout adjustments
  bool get isMobile => screenWidth < mobileBreakpoint;
  bool get isDrawerMode => screenWidth < desktopBreakpoint;
}

extension _WidgetListExtension on List<Widget> {
  // Utility extension to easily add spacing between Row children
  List<Widget> withSpacing(double space) {
    if (isEmpty) return [];
    List<Widget> list = [];
    for (int i = 0; i < length; i++) {
      list.add(this[i]);
      if (i < length - 1) {
        list.add(SizedBox(width: space));
      }
    }
    return list;
  }
}

// --- APP SETUP ---

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

// --- DATA MODELS ---

class Task {
  final String id; // Added ID for reliable identification during move
  final String title;
  final String company;
  final String priority;
  final Color priorityColor;
  final String overdue;
  final String loggedTime;
  final int assignees;
  final String statusLabel; // e.g., 'ToDo', 'Doing', 'Done', 'Review TM'

  const Task({
    required this.id,
    required this.title,
    required this.company,
    required this.priority,
    required this.priorityColor,
    required this.overdue,
    required this.loggedTime,
    required this.assignees,
    required this.statusLabel,
  });

  // Helper function to create a copy of the Task with a new status
  Task copyWith({String? statusLabel}) {
    return Task(
      id: id,
      title: title,
      company: company,
      priority: priority,
      priorityColor: priorityColor,
      overdue: overdue,
      loggedTime: loggedTime,
      assignees: assignees,
      statusLabel: statusLabel ?? this.statusLabel,
    );
  }
}

class KanbanColumn {
  final String title;
  final String status;
  final List<Task> tasks;
  final Color color;

  const KanbanColumn({
    required this.title,
    required this.status,
    required this.tasks,
    required this.color,
  });

  // Helper to create a copy of the column with a new list of tasks
  KanbanColumn copyWith({List<Task>? tasks}) {
    return KanbanColumn(
      title: title,
      status: status,
      tasks: tasks ?? this.tasks,
      color: color,
    );
  }
}

// Mutable list of Kanban data (moved outside for initial setup)
List<KanbanColumn> initialKanbanData = [
  KanbanColumn(
    title: 'To Do',
    status: 'todo',
    tasks: [
      Task(
        id: 'task-1',
        title: 'Urgent Tax Notice Response',
        company: 'Tech Innovations Pvt Ltd',
        priority: 'High',
        priorityColor: Colors.red.shade700,
        overdue: 'Overdue 46d 22h',
        loggedTime: '6h',
        assignees: 2,
        statusLabel: 'ToDo',
      ),
      Task(
        id: 'task-2',
        title: 'GSTR-3B Preparation',
        company: 'Green Energy Solutions',
        priority: 'High',
        priorityColor: Colors.red.shade700,
        overdue: 'Overdue 43d 22h',
        loggedTime: '2h',
        assignees: 2,
        statusLabel: 'ToDo',
      ),
    ],
    color: Colors.red.shade100,
  ),
  KanbanColumn(
    title: 'In Progress',
    status: 'in_progress',
    tasks: [
      Task(
        id: 'task-3',
        title: 'ESI Return Filing',
        company: 'Mumbai Retail Chain',
        priority: 'High',
        priorityColor: Colors.red.shade700,
        overdue: 'Overdue 44d 22h',
        loggedTime: '3h',
        assignees: 1,
        statusLabel: 'Doing',
      ),
      Task(
        id: 'task-4',
        title: 'Audit Trail Documentation',
        company: 'Healthcare Associates',
        priority: 'Medium',
        priorityColor: Colors.amber.shade700,
        overdue: 'Overdue 42d 22h',
        loggedTime: '3h',
        assignees: 1,
        statusLabel: 'Doing',
      ),
    ],
    color: Colors.yellow.shade100,
  ),
  KanbanColumn(
    title: 'Done',
    status: 'done',
    tasks: [
      Task(
        id: 'task-5',
        title: 'Client Onboarding - New Entity',
        company: 'Export Trading Co',
        priority: 'High',
        priorityColor: Colors.red.shade700,
        overdue: 'Overdue 34d 22h',
        loggedTime: '20h',
        assignees: 0,
        statusLabel: 'Done',
      ),
    ],
    color: Colors.green.shade100,
  ),
  KanbanColumn(
    title: 'Review (TM)',
    status: 'review_tm',
    tasks: [
      Task(
        id: 'task-6',
        title: 'Payroll Reconciliation',
        company: 'Mumbai Retail Chain',
        priority: 'High',
        priorityColor: Colors.red.shade700,
        overdue: 'Overdue 39d 22h',
        loggedTime: '12h',
        assignees: 0,
        statusLabel: 'Review TM',
      ),
    ],
    color: Colors.blue.shade100,
  ),
];

// --- MAIN SCREEN (Stateful for Navigation and Responsiveness) ---

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex =
      0; // State variable to track the currently selected index

  // List of all possible views corresponding to the sidebar items
  final List<Widget> _pages = const [
    MainDashboardContent(), // Index 0: Dashboard
    TaskKanbanScreen(), // Index 1: Tasks (NEW)
    PlaceholderPage(title: 'Clients'),
    PlaceholderPage(title: 'Timesheet'),
    PlaceholderPage(title: 'Timesheet-Team'),
    PlaceholderPage(title: 'Recurring Tasks'),
    PlaceholderPage(title: 'Escalations'),
    PlaceholderPage(title: 'Masters'),
    PlaceholderPage(title: 'Team'),
    PlaceholderPage(title: 'Reports'),
    PlaceholderPage(title: 'Leaderboards'),
    PlaceholderPage(title: 'Notices'),
  ];

  // Callback function passed to the Sidebar to update the selection
  void _onMenuItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // If on a screen where a drawer is used, close it on selection
    if (context.isDrawerMode) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = !context.isDrawerMode;

    return Scaffold(
      backgroundColor: const Color(
        0xFFF7F9FC,
      ), // Light background for the dashboard area
      appBar: _buildCustomAppBar(isDesktop, context),
      // Use Drawer on non-desktop screens
      drawer: isDesktop
          ? null
          : Drawer(
              child: Sidebar(
                selectedIndex: _selectedIndex,
                onItemTap: _onMenuItemSelected,
              ),
            ),
      body: Row(
        children: <Widget>[
          // Only show Sidebar inline on desktop
          if (isDesktop)
            Sidebar(
              selectedIndex: _selectedIndex,
              onItemTap: _onMenuItemSelected,
            ),

          // Right Partition: Dynamic Content Area
          Expanded(
            child: _pages[_selectedIndex], // Display the selected page
          ),
        ],
      ),
    );
  }

  // A simplified App Bar for the top controls and search box
  PreferredSizeWidget _buildCustomAppBar(bool isDesktop, BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 60,
      // Add a leading menu icon on mobile to open the Drawer
      leading: !isDesktop
          ? Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.grey),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            )
          : null,
      title: Container(
        // Reduce search bar width/padding on smaller screens
        width: isDesktop ? 400 : double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F3F6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search tasks, clients, or colleagues...',
            hintStyle: TextStyle(
              fontSize: context.scaleFont(14), // Scaled font
              color: Colors.grey,
            ),
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.grey),
          onPressed: () {},
        ),
        // Hide person icon and publish button on small mobile screens
        if (isDesktop || context.screenWidth > 500) ...[
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.grey),
            onPressed: () {},
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Publish',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: context.scaleFont(14), 
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// --- PLACEHOLDER PAGES ---
class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF7F9FC),
      child: Center(
        child: Text(
          'Welcome to the $title section!',
          style: TextStyle(
            fontSize: context.scaleFont(36),
            fontWeight: FontWeight.w300,
            color: Colors.blue.shade700,
          ),
        ),
      ),
    );
  }
}

// --- SIDEBAR WIDGETS (Unchanged) ---
class SidebarItem {
  final String title;
  final IconData icon;
  const SidebarItem(this.title, this.icon);
}

class Sidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTap;

  const Sidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemTap,
  });

  final List<SidebarItem> menuItems = const [
    SidebarItem('Dashboard', Icons.dashboard),
    SidebarItem('Tasks', Icons.task),
    SidebarItem('Clients', Icons.people_alt),
    SidebarItem('Timesheet', Icons.schedule),
    SidebarItem('Timesheet-Team', Icons.group),
    SidebarItem('Recurring Tasks', Icons.repeat),
    SidebarItem('Escalations', Icons.arrow_upward),
    SidebarItem('Masters', Icons.storage),
    SidebarItem('Team', Icons.diversity_3),
    SidebarItem('Reports', Icons.assessment),
    SidebarItem('Leaderboards', Icons.leaderboard),
    SidebarItem('Notices', Icons.campaign),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 12,
                  child: Text(
                    'd',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'dnA Consulting',
                  style: TextStyle(
                    fontSize: context.scaleFont(16),
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return SidebarMenuItem(
                  title: item.title,
                  icon: item.icon,
                  isSelected: index == selectedIndex,
                  onTap: () => onItemTap(index),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                const Icon(
                  Icons.settings_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: context.scaleFont(14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SidebarMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.shade50 : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? Colors.blue.shade700
                      : Colors.grey.shade600,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.blue.shade700
                        : Colors.grey.shade800,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                    fontSize: context.scaleFont(14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- DASHBOARD CONTENT (Index 0) (Unchanged) ---
class MainDashboardContent extends StatelessWidget {
  const MainDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Good morning, Priya!',
            style: TextStyle(
              fontSize: context.scaleFont(28),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Here's what's happening with your tasks today.",
            style: TextStyle(
              fontSize: context.scaleFont(16),
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),
          const StatsRow(),
          const SizedBox(height: 30),
          const BottomSectionsRow(),
        ],
      ),
    );
  }
}

// --- TASK KANBAN SCREEN (Index 1) (NOW STATEFUL) ---

class TaskKanbanScreen extends StatefulWidget {
  const TaskKanbanScreen({super.key});

  @override
  State<TaskKanbanScreen> createState() => _TaskKanbanScreenState();
}

class _TaskKanbanScreenState extends State<TaskKanbanScreen> {
  // State holds the mutable list of Kanban data
  late List<KanbanColumn> _kanbanData;

  @override
  void initState() {
    super.initState();
    // Use a deep copy of the initial data so we can modify it
    _kanbanData = List.from(initialKanbanData);
  }

  // CORE LOGIC: Function to move a task from one column to another
  void _moveTask(Task task, String targetStatus) {
    setState(() {
      Task? taskToMove;
      String? oldStatusLabel;
      int oldColIndex = -1;

      // 1. Find and remove the task from its source column
      for (int i = 0; i < _kanbanData.length; i++) {
        final column = _kanbanData[i];
        final taskIndex = column.tasks.indexWhere((t) => t.id == task.id);

        if (taskIndex != -1) {
          // Task found in this column
          taskToMove = column.tasks[taskIndex];
          oldStatusLabel = column.title; // Use column title for status label
          oldColIndex = i;

          // Create a mutable copy of the tasks list, remove the task
          List<Task> newTasks = List.from(column.tasks);
          newTasks.removeAt(taskIndex);

          // Update the column with the new, shorter task list
          _kanbanData[i] = column.copyWith(tasks: newTasks);
          break; // Task found, stop searching
        }
      }

      // 2. Add the task to the target column
      if (taskToMove != null) {
        // Find the target column index based on the target status (e.g., 'todo', 'done')
        final targetColIndex = _kanbanData.indexWhere(
          (col) => col.status == targetStatus,
        );

        if (targetColIndex != -1) {
          // Determine the new status label (using the target column's title)
          final newStatusLabel = _kanbanData[targetColIndex].title;

          // Update the task's status label
          final updatedTask = taskToMove.copyWith(statusLabel: newStatusLabel);

          // Create a mutable copy of the target tasks list, add the updated task
          List<Task> newTasks = List.from(_kanbanData[targetColIndex].tasks);
          newTasks.add(updatedTask);

          // Update the target column with the new, longer task list
          _kanbanData[targetColIndex] = _kanbanData[targetColIndex].copyWith(
            tasks: newTasks,
          );
        } else {
          // If the target column isn't found, revert the task back to the original column
          // (Basic error handling)
          print(
            'Error: Target column not found for status: $targetStatus. Reverting move.',
          );
          if (oldColIndex != -1) {
            List<Task> newTasks = List.from(_kanbanData[oldColIndex].tasks);
            newTasks.add(taskToMove);
            _kanbanData[oldColIndex] = _kanbanData[oldColIndex].copyWith(
              tasks: newTasks,
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // RBAC Demo Header (Omitted for brevity, assumed to be here)
          const SizedBox(height: 30),

          // Task Board Title and Controls
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Task Board',
                    style: TextStyle(
                      fontSize: context.scaleFont(24),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Drag and drop cards to update status.',
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              // Buttons (Omitted for brevity, assumed to be here)
            ],
          ),
          const SizedBox(height: 30),

          // Kanban Columns Grid/List - Pass the data and the move callback
          KanbanBoardLayout(columns: _kanbanData, onTaskMove: _moveTask),
        ],
      ),
    );
  }
}

class _TaskBoardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isPrimary;
  final bool isOutline;
  final double fontSize;

  const _TaskBoardButton({
    required this.title,
    required this.icon,
    required this.fontSize,
    this.isPrimary = false,
    this.isOutline = false,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor = isPrimary ? Colors.blue.shade700 : Colors.white;
    Color textColor = isPrimary ? Colors.white : Colors.grey.shade700;

    // Corrected type to BoxBorder?
    BoxBorder? border;

    if (isPrimary) {
      // Primary button: No border
      border = null;
    } else if (isOutline) {
      // Outline button: White background, grey text, requires Border.all()
      border = Border.all(color: Colors.grey.shade300, width: 1);
    }

    return Container(
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(8),
        border: border, // Now accepts BoxBorder? or null
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(icon, color: textColor, size: fontSize * 1.2),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KanbanBoardLayout extends StatelessWidget {
  final List<KanbanColumn> columns;
  final Function(Task task, String targetStatus) onTaskMove;

  const KanbanBoardLayout({
    super.key,
    required this.columns,
    required this.onTaskMove,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      // Stack vertically on mobile
      return Column(
        children: columns
            .map(
              (col) => Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: KanbanColumnWidget(column: col, onTaskMove: onTaskMove),
              ),
            )
            .toList(),
      );
    } else {
      // Horizontal layout on desktop/tablet
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: columns
              .map(
                (col) => Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: SizedBox(
                    width: 280, // Fixed width for each column
                    child: KanbanColumnWidget(
                      column: col,
                      onTaskMove: onTaskMove,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
    }
  }
}

class KanbanColumnWidget extends StatefulWidget {
  final KanbanColumn column;
  final Function(Task task, String targetStatus) onTaskMove;

  const KanbanColumnWidget({
    super.key,
    required this.column,
    required this.onTaskMove,
  });

  @override
  State<KanbanColumnWidget> createState() => _KanbanColumnWidgetState();
}

class _KanbanColumnWidgetState extends State<KanbanColumnWidget> {
  // State to track if a task is currently being dragged over this column
  bool isDraggingOver = false;

  @override
  Widget build(BuildContext context) {
    // 1. Wrap the entire column body in a DragTarget
    return DragTarget<Task>(
      // Determine if this target can accept the dragged data (accepts any Task)
      onWillAcceptWithDetails: (details) {
        // Prevent dropping a task onto its current column
        if (details.data.statusLabel == widget.column.title) {
          return false;
        }
        setState(() => isDraggingOver = true);
        return true;
      },
      // Reset the dragging state when the draggable leaves
      onLeave: (data) {
        setState(() => isDraggingOver = false);
      },
      // Handle the data drop when accepted
      onAcceptWithDetails: (task) {
        setState(() => isDraggingOver = false);
        // Call the external move function in the parent state
        widget.onTaskMove(task.data, widget.column.status);
      },
      builder:
          (
            BuildContext context,
            List<Object?> candidateData,
            List<dynamic> rejectedData,
          ) {
            return Container(
              decoration: BoxDecoration(
                // Change background color when dragging over
                color: isDraggingOver
                    ? widget.column.color
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Column Header
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        Text(
                          widget.column.title,
                          style: TextStyle(
                            fontSize: context.scaleFont(16),
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            widget.column.tasks.length.toString(),
                            style: TextStyle(
                              fontSize: context.scaleFont(12),
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Task Cards List - Now wrapped in Draggable
                  ...widget.column.tasks.map(
                    (task) => Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      // 2. TaskCard wrapped in Draggable
                      child: Draggable<Task>(
                        data: task,
                        // The widget shown at the original location while dragging
                        childWhenDragging: Opacity(
                          opacity: 0.5,
                          child: TaskCard(task: task, isPlaceholder: true),
                        ),
                        // The widget that follows the pointer during the drag
                        feedback: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: context.isMobile
                                ? context.screenWidth - 40
                                : 280,
                            child: TaskCard(task: task, isDragging: true),
                          ),
                        ),
                        child: TaskCard(task: task),
                      ),
                    ),
                  ),

                  // Add Task Button
                  Center(
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_circle_outline,
                        size: context.scaleFont(20),
                        color: Colors.blue.shade700,
                      ),
                      label: Text(
                        '+ Add Task',
                        style: TextStyle(
                          fontSize: context.scaleFont(14),
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
    );
  }
}

class TaskCard extends StatelessWidget {
  final Task task;
  final bool isDragging;
  final bool isPlaceholder;

  const TaskCard({
    super.key,
    required this.task,
    this.isDragging = false,
    this.isPlaceholder = false,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the color based on the task's current status for the card background
    Color cardBgColor = Colors.white;
    if (task.statusLabel == 'ToDo') {
      cardBgColor = Colors.red.shade50;
    } else if (task.statusLabel == 'Doing') {
      cardBgColor = Colors.yellow.shade50;
    } else if (task.statusLabel == 'Done') {
      cardBgColor = Colors.green.shade50;
    } else if (task.statusLabel == 'Review TM') {
      cardBgColor = Colors.blue.shade50;
    }

    // Adjust card style if it's currently the feedback widget
    double elevation = isDragging ? 8.0 : 0.0;
    Color borderColor = isPlaceholder
        ? Colors.transparent
        : const Color(0xFFEEEEEE);

    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: borderColor, width: 1),
      ),
      color: cardBgColor, // Card background color
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: Title and Priority
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: task.priorityColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    task.priority,
                    style: TextStyle(
                      fontSize: context.scaleFont(10),
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Row 2: Company Name
            Text(
              task.company,
              style: TextStyle(
                fontSize: context.scaleFont(12),
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 12),
            // Row 3: Overdue Info
            Row(
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  size: context.scaleFont(14),
                  color: Colors.red.shade700,
                ),
                const SizedBox(width: 4),
                Text(
                  task.overdue,
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.timer_outlined,
                  size: context.scaleFont(14),
                  color: Colors.grey.shade700,
                ),
                const SizedBox(width: 4),
                Text(
                  task.loggedTime,
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            // Row 4: Status and Assignees
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Assignees (Placeholder)
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: context.scaleFont(14),
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${task.assignees} assignee${task.assignees == 1 ? '' : 's'}',
                      style: TextStyle(
                        fontSize: context.scaleFont(12),
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                // Status Label (using task.statusLabel from the data)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: task
                        .priorityColor, // Re-using priority color for status chip
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    task.statusLabel,
                    style: TextStyle(
                      fontSize: context.scaleFont(10),
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- REMAINING DASHBOARD WIDGETS (Unchanged in Logic) ---

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color color;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle = '',
    this.color = Colors.blue,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0xFFEEEEEE), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: context.scaleFont(14),
                    color: Colors.grey,
                  ),
                ),
                Icon(icon, color: color.withOpacity(0.7), size: 18),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                fontSize: context.scaleFont(32),
                fontWeight: FontWeight.bold,
              ),
            ),
            if (subtitle.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isPrimary;

  const ActionButton({
    super.key,
    required this.title,
    required this.icon,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: isPrimary ? Colors.blue.shade700 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: isPrimary
              ? null
              : Border.all(color: const Color(0xFFEEEEEE), width: 1),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // Action logic goes here
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: isPrimary ? Colors.white : Colors.grey.shade700,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                      color: isPrimary ? Colors.white : Colors.black,
                      fontWeight: isPrimary ? FontWeight.w600 : FontWeight.w500,
                      fontSize: context.scaleFont(14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    const cards = <Widget>[
      StatCard(
        title: 'Active Tasks',
        value: '24',
        subtitle: '3 due today',
        icon: Icons.check_box,
        color: Colors.green,
      ),
      StatCard(
        title: 'Hours Logged',
        value: '42.5',
        subtitle: 'This week',
        icon: Icons.timer_outlined,
        color: Colors.green,
      ),
      StatCard(
        title: 'Overdue',
        value: '3',
        subtitle: 'Need attention',
        icon: Icons.warning_amber_rounded,
        color: Colors.amber,
      ),
      StatCard(
        title: 'Points',
        value: '156',
        subtitle: 'Monthly rank #4',
        icon: Icons.star_border,
        color: Colors.blue,
      ),
    ];

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: cards
            .map(
              (card) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: card,
              ),
            )
            .toList(),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cards
            .map((card) => Expanded(child: card))
            .toList()
            .withSpacing(20),
      );
    }
  }
}

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

class LeaderboardSection extends StatelessWidget {
  const LeaderboardSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> rankings = [
      {'name': 'Anjali Patel', 'points': 248, 'color': Colors.green},
      {'name': 'Rahul Kumar', 'points': 196, 'color': Colors.black},
      {'name': 'Vikram Singh', 'points': 156, 'color': Colors.black},
    ];

    return DashboardSection(
      title: 'Team Leaderboard',
      child: Column(
        children: [
          ...rankings.map(
            (r) => ListTile(
              leading: CircleAvatar(
                radius: 4,
                backgroundColor: r['color'] as Color,
              ),
              title: Text(
                r['name'] as String,
                style: TextStyle(fontSize: context.scaleFont(14)),
              ),
              trailing: Text(
                '${r['points']} pts',
                style: TextStyle(
                  color: r['color'] as Color,
                  fontSize: context.scaleFont(14),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const CircleAvatar(
              radius: 4,
              backgroundColor: Colors.blue,
            ),
            title: Text(
              'You',
              style: TextStyle(
                fontSize: context.scaleFont(14),
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              '156 pts',
              style: TextStyle(
                color: Colors.blue.shade700,
                fontSize: context.scaleFont(14),
                fontWeight: FontWeight.bold,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ],
      ),
    );
  }
}

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardSection(
      title: 'Quick Actions',
      child: Column(
        children: [
          ActionButton(
            title: 'Log Time Entry',
            icon: Icons.description_outlined,
          ),
          ActionButton(title: 'View Team Tasks', icon: Icons.group_outlined),
          ActionButton(title: 'Weekly Report', icon: Icons.bar_chart),
          ActionButton(
            title: 'Raise Service Request',
            icon: Icons.add_circle_outline,
            isPrimary: true,
          ),
        ],
      ),
    );
  }
}

class MyAssetsSection extends StatelessWidget {
  const MyAssetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardSection(
      title: 'My Assets',
      trailing: Text(
        '0 assigned',
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: context.scaleFont(14),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Icon(
            Icons.monitor,
            size: context.scaleFont(60),
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 10),
          Text(
            'No assets assigned to you yet',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: context.scaleFont(14),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class DashboardSection extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;

  const DashboardSection({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0xFFEEEEEE), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: context.scaleFont(18),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
            child: child,
          ),
        ],
      ),
    );
  }
}
