import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo_app_two/adapters/todo_adapter.dart';
import 'package:todo_app_two/style.dart';

class EditTodo extends StatefulWidget {
  final String title;
  final String dec;

  const EditTodo({Key? key, required this.title, required this.dec})
      : super(key: key);

  @override
  _EditTodoState createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  @override
  void initState() {
    super.initState();
    title = widget.title;
    description = widget.dec;
  }

  final formKey = GlobalKey<FormState>();

  String title = '', description = '';

  submitData() async {
    if (formKey.currentState!.validate()) {
      Box<Todo> todoBox = Hive.box<Todo>('todoBox');
      todoBox.put('todoBox', Todo(title: title, description: description));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: IconButton(
                        onPressed: () {
                          if (title.isNotEmpty && description.isNotEmpty) {
                            Box<Todo> todoBox = Hive.box<Todo>('todoBox');
                            todoBox.add(Todo(
                              title: title,
                              description: description,
                            ));
                          } else if (title == '' && description == '') {
                            Get.back();
                          }
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                  ),
                  IconButton(
                      onPressed: () => submitData(),
                      icon: const Icon(
                        Icons.save_alt,
                        color: Colors.white,
                      ))
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: title,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          decoration: const InputDecoration(
                              hintText: 'Add title',
                              hintStyle: TextStyle(
                                  color: Colors.white70, fontSize: 25),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent))),
                          validator: (text) {
                            if (text!.isEmpty) {}
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              title = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          initialValue: description,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          decoration: const InputDecoration(
                              hintText: 'Add description',
                              hintStyle: TextStyle(
                                  color: Colors.white70, fontSize: 25),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent))),
                          onChanged: (value) {
                            setState(() {
                              description = value;
                            });
                          },
                        ),
                        // ElevatedButton(
                        //     onPressed: submitData,
                        //     child: const Text('Submit Data'))
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
