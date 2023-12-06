import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/app_colors.dart';
import '../../infra/models/image_model.dart';
import '../../infra/models/tasks_model.dart';
import '../../infra/models/travels_model.dart';
import '../add_travel/widgets/gallery_buttons.dart';
import '../auth/auth_controller.dart';

class TaskDetailController extends GetxController {
  static TaskDetailController get to => Get.find();
  final String taskId = Get.arguments['id'] ?? '';
  final String travelId = Get.arguments['travelId'] ?? '';
  var isLoading = false;
  List<TasksModel> tasksList = [];
  List<String> imagesList = [];
  final db = FirebaseFirestore.instance;
  final String taskName = Get.arguments['taskName'] ?? '';
  TasksModel? taskModel;
  TravelsModel? travelModel;

  @override
  void onReady() {
    getTasksData(travelId);
    getImagesData(travelId);
    super.onReady();
  }

  Future<void> getTasksData(String id) async {
    try {
      var _taskSnap =
          await db.doc('travels/${id != '' ? id : null}/tasks/$taskName').get();

      taskModel = TasksModel(
        id,
        _taskSnap.data()!['isDone'],
        _taskSnap.data()!['task'],
        description: _taskSnap.data()!['description'],
        dateTime: _taskSnap.data()!['dateTime'].toDate(),
      );
      isLoading = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addImageToTask(String imagePath) async {
    try {
      String userId = AuthController.to.firebaseAuth.currentUser!.uid;

      // Fazer o upload da imagem para o Firebase Storage
      Reference storageReference = FirebaseStorage.instance.ref().child(
          'travels/$travelId/tasks/$taskName/images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask = storageReference.putFile(File(imagePath));
      await uploadTask.whenComplete(() => null);
      String imageUrl = await storageReference.getDownloadURL();

      // Salvar a URL no Firestore
      ImageModel imageModel = ImageModel(
        userId: userId,
        imageUrls: [imageUrl],
      );

      await db
          .collection('travels')
          .doc(travelId)
          .collection('tasks')
          .doc(taskName)
          .collection('images')
          .add(imageModel.toMap());

      await getImagesData(taskId);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getImagesData(String id) async {
    try {
      String userId = AuthController.to.firebaseAuth.currentUser!.uid;
      QuerySnapshot _imagesSnap = await db
          .collection('travels/$id/tasks/$taskName/images')
          .where('userId', isEqualTo: userId)
          .orderBy('imageUrls')
          .get();

      imagesList.clear();

      for (var item in _imagesSnap.docs) {
        var imageUrls = List<String>.from(item['imageUrls'] ?? []);
        imagesList.addAll(imageUrls);
      }

      isLoading = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  var selectedImagePath = ''.obs;
  var cropImagePath = ''.obs;

  late VoidCallback camera;
  late VoidCallback gallery;

  getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      final cropImageFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        cropStyle: CropStyle.circle,
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: purple,
            hideBottomControls: true,
            toolbarWidgetColor: lilyWhite,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,
          ),
          IOSUiSettings()
        ],
      );
      // ignore: unnecessary_null_comparison
      if (pickedFile != null) {
        cropImagePath.value = cropImageFile!.path;
        imagesList.add(cropImageFile.path);

        addImage(taskId, cropImageFile.path);
        //  File(cropImageFile.path);
      }
    } else {
      Get.snackbar(
        "Erro !",
        "Nenhuma Imagem Selecionada",
        backgroundColor: red,
        snackPosition: SnackPosition.TOP,
        colorText: lilyWhite,
      );
    }
  }

  void getCameraOrGallery(BuildContext context) {
    final changeTheme = Theme.of(context).brightness == Brightness.dark;
    Get.bottomSheet(
      backgroundColor: changeTheme ? secondaryDark : lilyWhite,
      SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GalleryButtons(
            camera: () async {
              await getImage(ImageSource.camera);
              Get.back();
            },
            gallery: () async {
              await getImage(ImageSource.gallery);
              Get.back();
            },
          ),
        ),
      ),
    );
  }

  Future<void> addImage(String taskName, String image) async {
    imagesList.add(image);
    // File(image);
    print('Task Name (before addImage): $taskName');
    await addImageToTask(image);
    //  File(image);
    print('Task Name (after addImage): $taskName');
  }

  Future<void> deleteImage(String image) async {
    try {
      String userId = AuthController.to.firebaseAuth.currentUser!.uid;

      await db
          .collection('travels')
          .doc(travelId)
          .collection('tasks')
          .doc(taskId)
          .collection('images')
          .where('userId', isEqualTo: userId)
          .where('imageUrls', arrayContains: image)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
          await doc.reference.update({
            'imageUrls': FieldValue.arrayRemove([image]),
          });
        });
      });

      imagesList.remove(image);
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> showDeleteConfirmationDialog(
    BuildContext context,
    TaskDetailController controller,
    String image,
  ) async {
    bool confirmDelete = await Get.defaultDialog(
      title: 'Confirmar Exclusão',
      content: Text('Você tem certeza que quer deletar essa image?'),
      textConfirm: 'Sim',
      textCancel: 'Não',
      onConfirm: () async {
        // Delete the image when the user confirms
        await controller.deleteImage(image);
        Get.back();
      },
      onCancel: () {
        Get.back();
      },
    );

    if (confirmDelete == true) {
      print('Image deleted!');
    } else {
      print('Image not deleted.');
    }
  }
}
