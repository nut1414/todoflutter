import 'package:flutter/material.dart';

class TodoAddForm extends StatefulWidget {
  const TodoAddForm({super.key, required this.addtodo});

  final Function(String, String, bool) addtodo;

  @override
  _TodoAddFormState createState() => _TodoAddFormState();
}

class _TodoAddFormState extends State<TodoAddForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add Todo')
        ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text("Enter Todo Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: 'Enter Task Name',label: Text('Task Name')),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  }
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(hintText: 'Enter Task Description',label: Text('Task Description')),
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Adding Todo')),
                            );

                            widget.addtodo(titleController.text, descriptionController.text, false);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Add'),
                      ),
                    ),
                  ),]
                ),
              ],)
            ),
          ),
        ],
      ),
    );
  }
}