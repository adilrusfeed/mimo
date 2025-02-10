// ignore_for_file: use_build_context_synchronously

import 'package:dfine_task/controller/task_controller.dart';
import 'package:dfine_task/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class AddTaskCard extends StatefulWidget {
  final String categoryId;
  const AddTaskCard({
    super.key,
    required this.categoryId,
  });

  @override
  State<AddTaskCard> createState() => _AddTaskCardState();
}

class _AddTaskCardState extends State<AddTaskCard> {
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final taskController = Provider.of<TaskController>(context, listen: false);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.12),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFields(
                  controller: taskController.taskController,
                  hint: 'Task',
                ),
                const SizedBox(height: 10),
                 GestureDetector(
                  onTap: () async {
                   DateTime? pickedTime = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        selectedDate = pickedTime;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedDate != null
                              ? DateFormat("dd-mm-yyyy").format(selectedDate!) // Format selected time
                              : "Pick Date",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Icon(Icons.access_time, color: Colors.grey),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(84, 115, 187, 1)),
                      onPressed: () async {
                        if (selectedDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please select a time')),
                          );
                          return;
                        }

                        await taskController.addTask(
                          widget.categoryId,
                          selectedDate!, // Pass formatted time
                        );

                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}