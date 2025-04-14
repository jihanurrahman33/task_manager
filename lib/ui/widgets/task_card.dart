import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

enum TaskStatus { sNew, progress, completed, canceled }

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskStatus,
    required this.taskModel,
    required this.onTaskDeleted,
    this.updatedStatus,
  });
  final TaskStatus taskStatus;
  final TaskModel taskModel;
  final Function(TaskModel) onTaskDeleted;
  final String? updatedStatus;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
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
                IconButton(
                  onPressed: _onTapDeleteTask,
                  icon: Icon(Icons.delete),
                ),
                IconButton(onPressed: _onTapEditTask, icon: Icon(Icons.edit)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapDeleteTask() async {
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.deleteTaskUrl(widget.taskModel.id),
    );
    if (response.isSucess) {
      widget.onTaskDeleted(widget.taskModel);
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
  }

  Future<void> _onTapEditTask() async {
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.updateTaskStatusUrl(widget.taskModel.id, widget.updatedStatus!),
    );
    if (response.isSucess) {
    } else {
      showSnackBarMessage(context, response.errorMessage!, true);
    }
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
