import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_travels/core/app_colors.dart';
import 'package:my_travels/core/primary_text.dart';
import 'package:my_travels/core/responsive.dart';

import '../details/widgets/add_photo.dart';
import '../details/widgets/full_screen_image.dart';
import 'task_detail_controller.dart';

class TaskDetail extends StatelessWidget {
  TaskDetail({Key? key}) : super(key: key);
  static const routeName = '/task-detail';
  final String taskId = Get.arguments['id'] ?? '';

  @override
  Widget build(BuildContext context) {
    final Map arguments = Get.arguments ?? {};
    final String taskName = arguments['taskName'] ?? '';
    final changeTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.chevron_left_rounded),
        ),
        title: Text(taskName),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GetBuilder<TaskDetailController>(
                builder: (control) {
                  return PrimaryText(
                    DateFormat('d MMMM y h:mm a z')
                        .format(control.taskModel?.dateTime ?? DateTime.now()),
                    color: changeTheme ? lilyWhite : black,
                  );
                },
              ),
              SizedBox(height: 16),
              GetBuilder<TaskDetailController>(
                builder: (control) {
                  return PrimaryText(
                    control.taskModel?.description ?? '',
                    color: changeTheme ? lilyWhite : black,
                  );
                },
              ),
              SizedBox(height: 16),
              Expanded(
                child: GetBuilder<TaskDetailController>(
                  builder: (_controller) {
                    return GridView(
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0.wp,
                        mainAxisSpacing: 5.0.wp,
                      ),
                      children: [
                        ..._controller.imagesList
                            .asMap()
                            .map(
                              (index, e) {
                                print('URL da imagem: $e');
                                print(
                                    'Caminho da imagem no dispositivo: ${File(e).path}');
                                return MapEntry(
                                  index,
                                  GestureDetector(
                                    onLongPress: () {
                                      _controller.showDeleteConfirmationDialog(
                                        context,
                                        _controller,
                                        e,
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: FullScreenWidget(
                                          child: Hero(
                                            tag: "customTag_$index",
                                            child: CachedNetworkImage(
                                              imageUrl: e,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                'assets/images/1958006.jpg',
                                              ),
                                            ),
                                            /*  Image.file(
                                            File(e),
                                            fit: BoxFit.cover,
                                          ), */
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                            .values
                            .toList(),
                        AddPhoto(
                          onTap: () => _controller.getCameraOrGallery(context),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
