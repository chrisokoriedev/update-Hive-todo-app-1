import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_two/adapters/todo_adapter.dart';
import 'package:todo_app_two/style.dart';

import 'add_todo.dart';

class ViewTodoList extends StatelessWidget {
  const ViewTodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        splashColor: kPrimaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(
            const AddTodo(),
            transition: Transition.downToUp,
            duration: const Duration(milliseconds: 500),
          );
        },
      ),
      appBar: AppBar(
        leading: const Icon(Icons.task),
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: const Text('All Task'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Todo>('todoBox').listenable(),
          builder: (context, Box<Todo> box, _) {
            if (box.values.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.inbox_outlined, size: 80.0, color: Colors.white70),
                  Center(
                    child: Text(
                      'No task available',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            }
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  Todo? todoContent = box.getAt(index);
                  return Card(
                    color: kPrimaryColor.withOpacity(0.5),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      // leading: Checkbox(onChanged: (bool? value) {  }, value: true,),
                      trailing: IconButton(
                        onPressed: () {
                          Get.bottomSheet(Container(
                            height: 200,
                            color: kPrimaryColor.withOpacity(0.5),
                            child: Column(
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    width: 150,
                                    child: Image.asset('assets/delete.gif')),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () async {
                                          await box.deleteAt(index);
                                          Get.back();
                                        },
                                        child: const Text('Yes')),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text('No')),
                                  ],
                                )
                              ],
                            ),
                          ));
                          // await box.deleteAt(index);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white70,
                        ),
                      ),
                      title: Text(
                        todoContent!.title,
                        style: const TextStyle(
                            // decoration: TextDecoration.lineThrough,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      subtitle: Text(
                        todoContent.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
