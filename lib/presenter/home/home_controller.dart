// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_travels/core/primary_text.dart';

import '../../core/app_colors.dart';
import '../../core/theme_controller.dart';
import '../../infra/models/travels_model.dart';
import '../../shared/get_colors.dart';
import '../add_travel/add_travel_page.dart';
import '../auth/auth_controller.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  var isLoading = false;

  List<TravelsModel> travelsList = [];
  List<TravelsModel> get tasks => travelsList;

  final formKey = GlobalKey<FormState>();
  final TextEditingController travelController = TextEditingController();

  final db = FirebaseFirestore.instance;

  RxString selectedItem = ''.obs;

  late final LocalAuthentication auth;

  bool supportedState = false;

  onSelected(String v) {
    selectedItem.value = v.toString();
    update();
  }

  @override
  void onReady() {
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) {
      supportedState = isSupported;
      update();
    });
    getData();
    super.onReady();
  }

  Future<void> addTravel(TravelsModel travelsModel) async {
    try {
      String userId = AuthController.to.firebaseAuth.currentUser!.uid;

      int selectedColorIndex = chipIndex.value;
      Color selectedColor = colors[selectedColorIndex];
      String color = '#${selectedColor.value.toRadixString(16).substring(2)}';

      await db.collection('travels').add(
        {
          'userId': userId,
          'travel': travelsModel.travel,
          'color': color,
          'startAt': travelsModel.startAt,
          'endAt': travelsModel.endAt,
        },
      );
      getData();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> getData() async {
    try {
      isLoading = true;
      String userId = AuthController.to.firebaseAuth.currentUser?.uid ?? '';
      QuerySnapshot taskSnap = await db
          .collection('travels')
          .where('userId', isEqualTo: userId)
          .orderBy('travel')
          .get();
      if (kDebugMode) {
        print('object $userId');
      }
      travelsList.clear();

      for (var item in taskSnap.docs) {
        TravelsModel travelsModel = TravelsModel(
          item.id,
          item['travel'],
          item['color'],
          (item['startAt'] as Timestamp).toDate(),
          (item['endAt'] as Timestamp).toDate(),
        );
        QuerySnapshot taskSnapshot =
            await db.collection('travels/${item.id}/tasks').get();

        travelsModel.numberOfTasks = taskSnapshot.docs.length;

        travelsList.add(travelsModel);
      }
      isLoading = false;
      update();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void deleteTask(String id) {
    db.collection('travels').doc(id).delete();
  }

  Future<void> addTravelButton() async {
    TravelsModel travelsModel = TravelsModel(
      '',
      travelController.text.trim(),
      '',
      dateRange.value.start,
      dateRange.value.end,
    );

    await addTravel(travelsModel);

    travelController.clear();
    update();
    Get.back();
  }

  ////////////////////////////////////////////////////////////////////

  final deleting = false.obs;
  final tabIndex = 0.obs;
  final chipIndex = 0.obs;

  @override
  void onClose() {
    travelController.dispose();
    super.onClose();
  }

  final colors = getColors();

  Widget getTravelColors() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: colors
          .map(
            (e) => Obx(
              () {
                final index = colors.indexOf(e);
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ChoiceChip(
                    avatar: CircleAvatar(
                      radius: 30,
                      backgroundColor: e.withOpacity(0.5),
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    backgroundColor: e,
                    selectedColor: e,
                    labelPadding: const EdgeInsets.all(6),
                    label: ColoredBox(color: e),
                    selected: chipIndex.value == index,
                    onSelected: (bool selected) {
                      chipIndex.value = selected ? index : 0;
                    },
                  ),
                );
              },
            ),
          )
          .toList(),
    );
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  Future<void> deleteTravel(BuildContext context, TravelsModel travel) async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    // ignore: use_build_context_synchronously
    bool useBiometrics = await _showAuthenticationMethodBottomSheet(context);

    if (useBiometrics && canCheckBiometrics) {
      bool isBiometricAuthenticated = await auth.authenticate(
        localizedReason: 'Authenticate to delete the travel',
      );
      if (!isBiometricAuthenticated) {
        return;
      }
    } else {
      bool isPasswordAuthenticated = await _showPasswordDialog();
      if (!isPasswordAuthenticated) {
        return;
      }
    }
    try {
      await db.collection('travels').doc(travel.id).delete();
      EasyLoading.showToast('Viagem deletada com sucesso!');
      getData();
    } catch (e) {
      print('Error deleting travel: $e');
    }
  }

  Future<bool> _showAuthenticationMethodBottomSheet(
      BuildContext context) async {
    final changeTheme = Theme.of(context).brightness == Brightness.dark;
    return await showModalBottomSheet<bool>(
          context: Get.overlayContext!,
          isDismissible: false,
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      Get.back(result: true);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
                ListTile(
                  title: PrimaryText(
                    'Usar senha do celular',
                    textAlign: TextAlign.center,
                    color: changeTheme ? lilyWhite : black,
                  ),
                  onTap: () {
                    Get.back(result: true);
                  },
                ),
                ListTile(
                  title: PrimaryText(
                    'Usar senha do App',
                    textAlign: TextAlign.center,
                    color: changeTheme ? lilyWhite : black,
                  ),
                  onTap: () {
                    Get.back(result: false);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<bool> _showPasswordDialog() async {
    TextEditingController passwordController = TextEditingController();
    bool isPasswordCorrect = false;

    await Get.defaultDialog(
      title: 'Senha do App',
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                AuthController.to.password = passwordController.text;
                isPasswordCorrect =
                    AuthController.to.password == passwordController.text;
                passwordController.clear();

                Get.back();
              },
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );

    return isPasswordCorrect;
  }

  void backButton() {
    Get.back();
    travelController.clear();
  }

  void addAndDeleteButton() {
    Get.to(() => AddTravelPage());
    travelController.clear();
    dateRange.value = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now(),
    );
    changeChipIndex(0);
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
    update();
  }

  var dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day + 6,
    ),
  ).obs;

  void chooseDateRangePicker() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: Get.context!,
      firstDate: DateTime(DateTime.now().year - 20),
      lastDate: DateTime(DateTime.now().year + 20),
      initialDateRange: dateRange.value,
    );

    if (picked != null && picked != dateRange.value) {
      dateRange.value = picked;

      dateRange.value.start;
      dateRange.value.end;
    }

    update();
  }

  //Biometrics
  Future<void> biometricPermission() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    print('Biometrics available $availableBiometrics');
  }

  void changeTheme() {
    ThemeController().switchTheme();
  }
}
