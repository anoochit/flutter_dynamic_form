import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TextEditingController> listTextController = [];

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    listTextController = [
      TextEditingController(),
    ];
  }

  @override
  void dispose() {
    listTextController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dynamic Form"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Column(
                children: [
                  // list text form field
                  Column(
                    children: listTextController.asMap().entries.map((element) {
                      final index = element.key;
                      final controller = element.value;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: controller,
                          decoration:
                              InputDecoration(hintText: 'Topic ${index + 1}'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter topic ${index + 1}';
                            }

                            return null;
                          },
                        ),
                      );
                    }).toList(),
                  ),

                  //button
                  FilledButton(
                    onPressed: () {
                      // submit
                      if (formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text('Saved!'),
                          ),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add topic'),
        onPressed: () {
          setState(() {
            listTextController.add(TextEditingController());
          });
        },
      ),
    );
  }
}
