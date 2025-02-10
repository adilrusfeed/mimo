import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dfine_task/controller/task_controller.dart';
import 'package:dfine_task/model/category_model.dart';
import 'package:dfine_task/model/task_model.dart';
import 'package:dfine_task/utils/get_day.dart';
import 'package:dfine_task/view/screens/add_task_card.dart';
import 'package:dfine_task/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CategoryTasksScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryTasksScreen({super.key, required this.category});

  @override
  State<CategoryTasksScreen> createState() => _CategoryTasksScreenState();
}

class _CategoryTasksScreenState extends State<CategoryTasksScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskController>(context, listen: false)
        .fetchTasks(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CustomText(text: widget.category.task, size: 25,fontWeight: FontWeight.bold,),centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {_showSearchDialog(context);},
          ),
        ],
      ),
      body: Consumer<TaskController>(builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final tasks = value.tasks;

        final groupedTasks = <String, List<TaskModel>>{};
        final dateOrder = <String, DateTime>{};
        for (var task in tasks) {
          final dateLabel =
              task.date != null ? getDayDescription(task.date!) : 'No Date';

          if (!groupedTasks.containsKey(dateLabel)) {
            groupedTasks[dateLabel] = [];
            if (task.date != null) {
              dateOrder[dateLabel] = task.date is Timestamp?(task.date as Timestamp).toDate():task.date as DateTime;
            }
          }  
            groupedTasks[dateLabel]!.add(task);
        }
        final sortedKeys = groupedTasks.keys.toList()
          ..sort((a, b) {
      if (a == "Today") return -1;
      if (b == "Today") return 1;
      if (a == "Tomorrow") return -1;
      if (b == "Tomorrow") return 1;
      return dateOrder[a]?.compareTo(dateOrder[b] ?? DateTime(2100)) ?? 1;
    });

        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            children: sortedKeys.map((dateLabel) {
              
              final tasksForDate = groupedTasks[dateLabel]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomText(
                      text: dateLabel,
                      size: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(131, 97, 97, 97),
                    ),
                  ),
                  ...tasksForDate.map((task) => ListTile(
                        trailing: IconButton(
                            onPressed: () {
                              _confirmDelete(context, value, task.id!);
                            },
                            icon: const Icon(Icons.delete)),
                        leading: InkWell(
                          onTap: () {
                            value.updateTask(TaskModel(
                                categoryId: widget.category.id,
                                id: task.id,
                                task: task.task,
                                date: task.date,
                                isComplete: !task.isComplete!));
                          },
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.grey,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: task.isComplete!
                                  ? Colors.green
                                  : Colors.white,
                              child: task.isComplete!
                                  ? const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        title: CustomText(
                          text: task.task ?? '',size: 20,fontWeight: FontWeight.w400,
                          textAlign: TextAlign.start,
                          color: task.isComplete! ? Colors.grey : Colors.black,
                        ),
                      )),
                ],
              );
            }).toList(),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierColor: Colors.white.withOpacity(.8),
            builder: (BuildContext context) {
              return AddTaskCard(categoryId: widget.category.id);
            },
          );
        },
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
  void _confirmDelete(BuildContext context, TaskController controller, String taskId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                controller.deleteTask(widget.category.id, taskId);
                Navigator.pop(context);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
      
    );
  }
  void _showSearchDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      String query = "";
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("Search Tasks"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Enter task name",
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      query = value.toLowerCase();
                    });
                  },
                ),
                const SizedBox(height: 10),
                Consumer<TaskController>(
                  builder: (context, value, child) {
                    final filteredTasks = value.tasks
                        .where((task) =>
                            task.task!.toLowerCase().contains(query))
                        .toList();

                    return SizedBox(
                      height: filteredTasks.isEmpty ? 50 : 200,
                      child: filteredTasks.isEmpty
                          ? const Center(
                              child: Text("No tasks found"),
                            )
                          :
                      ListView.builder(
                        itemCount: filteredTasks.length,
                        itemBuilder: (context, index) {
                          final task = filteredTasks[index];
                          return ListTile(
                            title: Text(task.task!),
                            onTap: () {
                              Navigator.pop(context);
                            }
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

}