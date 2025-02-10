import 'package:dfine_task/controller/category_controller.dart';
import 'package:dfine_task/view/screens/add_category_card.dart';
import 'package:dfine_task/view/screens/category_task.dart';
import 'package:dfine_task/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key, required this.size});
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryController>(builder: (context, value, child) {
      if (value.isLoading) {
       return Center(
        child: CircularProgressIndicator(),
       );
      }
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: (size.width / 2) / (size.height / 4),
        ),
        itemCount: value.categories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.white.withOpacity(.8),
                  builder: (BuildContext context) {
                    return AddCategoryCard(size: size);
                  },
                );
              },
              child: Card(
                elevation: 5,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(Icons.add, size: 50),
                ),
              ),
            );
          } else {
            final category = value.categories[index - 1];
            return GestureDetector(
             
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryTasksScreen(
                    category: category,
                  ),
                ),
              ),
              child: Card(
                elevation: 5,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                category.task,
                                
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            PopupMenuButton<String>(
                              onSelected: (String result) {
                                if (result == 'Edit') {
                                  showDialog(
                                    context: context,
                                    barrierColor: Colors.white.withOpacity(.8),
                                    builder: (BuildContext context) {
                                      return AddCategoryCard(
                                        size: size,
                                        isEdit: true,
                                        category: category,
                                      );
                                    },
                                  );
                                } else if (result == 'Delete') {
                                  value.deleteCategory(category.id);
                                }
                              },
                              itemBuilder: (BuildContext context) => [
                                const PopupMenuItem(
                                  value: 'Edit',
                                  child: Text('Edit '),
                                ),
                                const PopupMenuItem(
                                  value: 'Delete',
                                  child: Text('Delete Category'),
                                ),
                              ],
                              icon: const Icon(Icons.more_vert),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${category.task.length} tasks',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}