// ignore_for_file: use_build_context_synchronously

import 'package:dfine_task/controller/category_controller.dart';
import 'package:dfine_task/model/category_model.dart';
import 'package:dfine_task/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategoryCard extends StatelessWidget {
  final Size size;
  final bool isEdit;
  final CategoryModel? category;
  const AddCategoryCard({
    super.key,
    this.isEdit = false,
    this.category,
    required this.size,
  });

  

  @override
  Widget build(BuildContext context) {
    final categoryController =
        Provider.of<CategoryController>(context, listen: false);
        if(isEdit && category != null){
          categoryController.titleController.text = category!.title;
        }
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
                SizedBox(
                  height: 70,
                  child: CustomTextFields(
                    controller: categoryController.iconController,
                    hint: "Title",
                  ),
                ),
                CustomTextFields(
                  controller: categoryController.titleController,
                  hint: 'Task',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const CustomText(text: 'Cancel'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:  const Color(0xFF5473BB)),
                      onPressed: () async {
                        if(isEdit && category != null){
                          await categoryController.updateCategory(category!);
                        // await categoryController.addCategory();
                        // Navigator.pop(context);
                      }else{
                        await categoryController.addCategory();
                        
                      }Navigator.pop(context);
                      },
                      child:  CustomText(
                        text: isEdit?'Update':'Save',
                        color: Colors.white,
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
