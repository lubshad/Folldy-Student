import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/screens/add_edit_batch/add_edit_batch_controller.dart';
import 'package:folldy_student/utils/constants.dart';
import 'package:folldy_utils/data/models/course_list_response.dart';

class AddEditBatchScreen extends StatelessWidget {
  const AddEditBatchScreen({
    Key? key,
    required this.refreshBatches,
  }) : super(key: key);

  final VoidCallback refreshBatches;

  @override
  Widget build(BuildContext context) {
    AddEditBatchController addEditBatchController =
        AddEditBatchController(refreshBatches);
    addEditBatchController.getCourses();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new batch"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: AnimatedBuilder(
            animation: addEditBatchController,
            builder: (context, child) {
              return Form(
                  key: addEditBatchController.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Batch name",
                        ),
                        controller: addEditBatchController.batchNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter batch name";
                          }
                          return null;
                        },
                      ),
                      DropdownButtonFormField<Course>(
                        decoration: const InputDecoration(
                          hintText: "Select course",
                        ),
                        items: addEditBatchController.courseDropdownItems,
                        onChanged: addEditBatchController.selectCourse,
                        validator: (value) {
                          if (value == null) {
                            return "Please select a course";
                          }
                          return null;
                        },
                      ),
                      DropdownButtonFormField<DateTimeRange>(
                        decoration: const InputDecoration(
                          hintText: "Select batch",
                        ),
                        value: addEditBatchController.batchDuration,
                        items: addEditBatchController.batchItems,
                        onChanged: addEditBatchController.selectBatch,
                        validator: (value) {
                          if (value == null) {
                            return "Please select a batch";
                          }
                          return null;
                        },
                      ),
                    ],
                  ));
            }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding),
        child: ElevatedButton(
          onPressed: addEditBatchController.addOrEditBatch,
          child: const Text("Add"),
        ),
      ),
    );
  }
}
