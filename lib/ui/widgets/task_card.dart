import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

enum TaskStatus { sNew, progress, completed, canceled }

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskStatus,
    required this.taskModel,
    required this.onTaskDeleted,
    this.updatedStatus,
    required this.refreshList,
  });
  final TaskStatus taskStatus;
  final TaskModel taskModel;
  final Function(TaskModel) onTaskDeleted;
  final String? updatedStatus;
  final VoidCallback refreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _inProgress = false;
  String? updatedValue;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(widget.taskModel.description),

            Text(
              'Date: ${DateFormat('yMMMMEEEEd').format(DateTime.parse(widget.taskModel.createdDate))}',
            ),

            Row(
              children: [
                Chip(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  label: Text(
                    widget.taskModel.status,
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: _getStatusChipColor(),
                  side: BorderSide.none,
                ),
                const Spacer(),
                Visibility(
                  visible: _inProgress == false,
                  replacement: CenteredCircularProgressIndicator(),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: _onTapDeleteTask,
                        icon: Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: _showUpdateStatucDialog,
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapDeleteTask() async {
    //TODO delete task using controller
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.deleteTaskUrl(widget.taskModel.id),
    );
    if (response.isSucess) {
      widget.onTaskDeleted(widget.taskModel);
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
  }



  Future<void> _changeTaskStatus(String status) async {
    _inProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.updateTaskStatusUrl(widget.taskModel.id, status),
    );
    _inProgress = false;

    if (response.isSucess) {
      widget.refreshList();
    } else {
      setState(() {});
      showSnackBarMessage(context, response.errorMessage!, true);
    }
  }

  bool isSelected(String status) => widget.taskModel.status == status;
  void _showUpdateStatucDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  _popDialog();
                  if (isSelected('New')) return;
                  _changeTaskStatus('New');
                },
                title: Text('New'),
                trailing: isSelected('New') ? Icon(Icons.done) : null,
              ),
              ListTile(
                onTap: () {
                  _popDialog();
                  if (isSelected('Progress')) return;
                  _changeTaskStatus('Progress');
                },
                title: Text('Progress'),
                trailing: isSelected('Progress') ? Icon(Icons.done) : null,
              ),
              ListTile(
                onTap: () {
                  _popDialog();
                  if (isSelected('Completed')) return;
                  _changeTaskStatus('Completed');
                },
                title: Text('Completed'),
                trailing: isSelected('Completed') ? Icon(Icons.done) : null,
              ),
              ListTile(
                onTap: () {
                  _popDialog();
                  if (isSelected('Cancelled')) return;
                  _changeTaskStatus('Cancelled');
                },
                title: Text('Cancelled'),
                trailing: isSelected('Cancelled') ? Icon(Icons.done) : null,
              ),
            ],
          ),
        );
      },
    );
  }

  void _popDialog() {
    Navigator.pop(context);
  }

  Color _getStatusChipColor() {
    late Color color;
    switch (widget.taskStatus) {
      case TaskStatus.sNew:
        color = Colors.blue;
      case TaskStatus.progress:
        color = Colors.purple;
      case TaskStatus.completed:
        color = Colors.green;
      case TaskStatus.canceled:
        color = Colors.red;
    }
    return color;
  }
}
