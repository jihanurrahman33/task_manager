import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/add_new_task_controller.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTeController = TextEditingController();
  final TextEditingController _descriptionTeController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Text(
                    'Add new Task',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your title';
                      }
                      return null;
                    },
                    controller: _titleTeController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Title'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your description';
                      }
                      return null;
                    },
                    controller: _descriptionTeController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<AddNewTaskController>(
                    builder:
                        (controller) => Visibility(
                          visible: controller.addNewTaskInProgress == false,
                          replacement: CenteredCircularProgressIndicator(),
                          child: ElevatedButton(
                            onPressed: _onTapSubmitButton,
                            child: Icon(Icons.arrow_circle_right_outlined),
                          ),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() async {
    if (_formKey.currentState!.validate()) {
      await addNewTask();
      Navigator.pop(context, true);
    }
  }

  Future<void> addNewTask() async {
    final isSuccess = await Get.find<AddNewTaskController>().addNewTask(
      _titleTeController.text.trim(),
      _descriptionTeController.text.trim(),
    );
    if (isSuccess) {
      _clearTextFiled();
      showSnackBarMessage(context, 'New Task Added');
    } else {
      showSnackBarMessage(
        context,
        Get.find<AddNewTaskController>().errorMessage!,
      );
    }
  }

  void _clearTextFiled() {
    _titleTeController.clear();
    _descriptionTeController.clear();
  }

  @override
  void dispose() {
    _titleTeController.dispose();
    _descriptionTeController.dispose();
    super.dispose();
  }
}
