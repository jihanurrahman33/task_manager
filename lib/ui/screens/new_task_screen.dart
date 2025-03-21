import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/summary_card.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSummarySection(),
            ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return TaskCard();
              },
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemCount: 6,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummarySection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SummaryCard(title: 'New', count: 12),
            SummaryCard(title: 'Progress', count: 23),
            SummaryCard(title: 'Completed', count: 3),
            SummaryCard(title: 'Canceled', count: 25),
          ],
        ),
      ),
    );
  }
}
