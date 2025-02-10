// ignore_for_file: prefer_const_constructors

import 'package:dfine_task/controller/category_controller.dart';
import 'package:dfine_task/controller/user_controller.dart';
import 'package:dfine_task/view/screens/category_list.dart';
import 'package:dfine_task/view/widgets/custom_text_field.dart';
import 'package:dfine_task/view/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

   
      Provider.of<CategoryController>(context, listen: false).fetchCategories();
      Provider.of<UserController>(context, listen: false).getCurrentUser();
    
  }
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Consumer<UserController>(builder: (context, value, child) {
          return Row(
            children: [
              const SizedBox(width: 10),
              CustomText(
                text: value.user?.fullname ?? ''.toUpperCase(),
                fontWeight: FontWeight.bold,
                size: 25,
              ),
            ],
          );
        }),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          
        ],
      ),
      drawerEnableOpenDragGesture: false,
      drawer: drawer_widget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage(
                        'assets/dp.png',
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Believe you can and you're halfway there.",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 16.0,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "—Theodore Roosevelt",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(child: CategoryList(size: size)),
          ],
        ))
      
    );
  }
}
