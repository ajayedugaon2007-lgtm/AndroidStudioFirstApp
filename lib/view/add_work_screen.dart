import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/work_controller.dart';
import '../controller/auth_controller.dart';
import '../model/work_model.dart';

class AddWorkScreen extends StatefulWidget {
  const AddWorkScreen({super.key});

  @override
  State<AddWorkScreen> createState() => _AddWorkScreenState();
}

class _AddWorkScreenState extends State<AddWorkScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  String _category = 'Electrician';

  final List<String> _categories = [
    'Electrician', 'Plumber', 'Carpenter', 'Painter', 'AC Repair', 'Cleaner'
  ];

  @override
  Widget build(BuildContext context) {
    final workController = Provider.of<WorkController>(context);
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Post a Job"), backgroundColor: Colors.blue, foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Job Title', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Enter title' : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                initialValue: _category,
                items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => setState(() => _category = v!),
                decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
                maxLines: 3,
                validator: (v) => v!.isEmpty ? 'Enter description' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Estimated Price', border: OutlineInputBorder(), prefixText: '\$'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Enter price' : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.blue,
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    WorkModel work = WorkModel(
                      title: _titleController.text,
                      description: _descController.text,
                      category: _category,
                      price: double.tryParse(_priceController.text),
                      workerId: authController.user?.uid,
                      workerName: authController.user?.name,
                      status: 'available',
                    );
                    await workController.addWork(work);
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Job Posted!')));
                    _titleController.clear();
                    _descController.clear();
                    _priceController.clear();
                  }
                },
                child: const Text("Post Job", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
