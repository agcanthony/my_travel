import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_travels/core/responsive.dart';

import '../../core/app_colors.dart';
import '../../core/primary_text.dart';
import '../../infra/models/travels_model.dart';
import '../add_travel/add_travel_page.dart';
import '../auth/auth_controller.dart';
import '../details/detail_page.dart';
import '../report/report_page.dart';
import './home_controller.dart';
import 'widgets/add_card.dart';
import 'widgets/add_floating_button.dart';
import 'widgets/add_travel_card.dart';
import 'widgets/custom_bottom_bar.dart';
import 'widgets/gridview_task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final changeTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        actions: [
          GetBuilder<AuthController>(
            builder: (control) {
              return PrimaryText(control.firebaseAuth.currentUser?.email ?? '');
            },
          ),
          GetBuilder<HomeController>(
            builder: (control) {
              return PopupMenuButton(
                icon: Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: lilyWhite,
                ),
                onSelected: (v) {
                  control.onSelected(v);

                  print(v);
                },
                itemBuilder: (BuildContext bc) {
                  return [
                    PopupMenuItem(
                      child: TextButton.icon(
                        onPressed: () {
                          AuthController.to.logout();
                        },
                        icon: Icon(
                          Icons.logout,
                          color: changeTheme ? lilyWhite : black,
                        ),
                        label: PrimaryText(
                          'Sair',
                          color: changeTheme ? lilyWhite : black,
                        ),
                      ),
                      value: '/Bye',
                    ),
                    PopupMenuItem(
                      child: TextButton.icon(
                        onPressed: () {
                          controller.changeTheme();
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          changeTheme
                              ? Icons.light_mode_outlined
                              : Icons.dark_mode_outlined,
                          color: changeTheme ? lilyWhite : black,
                        ),
                        label: PrimaryText(
                          changeTheme ? 'Claro' : 'Escuro',
                          color: changeTheme ? lilyWhite : black,
                        ),
                      ),
                      value: '/Theme',
                    ),
                  ];
                },
              );
            },
          ),
        ],
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            ListView(
              padding: EdgeInsets.all(4.5.wp),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2.5.hp, left: 2.0.wp),
                  child: PrimaryText(
                    'Diário de Viagens',
                    color: changeTheme ? lilyWhite : black,
                    fontWeight: FontWeight.w500,
                    size: 24.0.tx,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 5.0.hp),
                GetBuilder<HomeController>(
                  builder: (control) {
                    if (control.isLoading) {
                      return Lottie.asset(
                          'assets/images/Animation - 1701735290225.json');
                    }
                    return GridviewTaskCard(
                      children: [
                        ...control.tasks
                            .map(
                              (element) => LongPressDraggable(
                                data: element,
                                onDragStarted: () =>
                                    controller.changeDeleting(true),
                                onDraggableCanceled: (_, __) =>
                                    controller.changeDeleting(false),
                                onDragEnd: (_) =>
                                    controller.changeDeleting(false),
                                feedback: Opacity(
                                  opacity: 0.8,
                                  child: AddTravelCard(
                                    ontTap: () {},
                                    travel: element,
                                    cardColor: element.color,
                                    totalSteps: element.numberOfTasks > 0
                                        ? element.numberOfTasks
                                        : 1,
                                    currentStep: element.numberOfTasks,
                                  ),
                                ),
                                child: AddTravelCard(
                                  ontTap: () async {
                                    await Get.to(
                                        () => DetailPage(
                                              taskName: element.travel,
                                              id: element.id,
                                            ),
                                        arguments: {
                                          'id': element.id,
                                          'taskName': element.travel,
                                        });
                                    print(element.id);
                                  },
                                  travel: element,
                                  cardColor: element.color,
                                  totalSteps: element.numberOfTasks > 0
                                      ? element.numberOfTasks
                                      : 1,
                                  currentStep: element.numberOfTasks,
                                ),
                              ),
                            )
                            .toList(),
                        AddCard(
                          onTap: () {
                            Get.to(() => AddTravelPage());
                            controller.travelController.clear();
                            controller.dateRange.value = DateTimeRange(
                              start: DateTime.now(),
                              end: DateTime.now(),
                            );
                            controller.changeChipIndex(0);
                          },
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
            ReportPage(),
          ],
        ),
      ),
      floatingActionButton: DragTarget(
        builder: (_, __, ___) {
          return Obx(
            () => AddFloatingButton(
              onTap: controller.addAndDeleteButton,
              backgroundColor:
                  controller.deleting.value ? redDark : defaultIconColor,
              iconData: controller.deleting.value ? Icons.delete : Icons.add,
              iconColor: lilyWhite,
            ),
          );
        },
        onAccept: (TravelsModel travelModel) {
          controller.deleteTravel(context, travelModel);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => CustomBottomBar(
          onTap: (int index) {
            controller.changeTabIndex(index);
          },
          currentIndex: controller.tabIndex.value,
        ),
      ),
    );
  }
}
