import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_commute/common/toast.dart';
import 'package:shared_commute/consts/global_consts.dart';
import 'package:shared_commute/controllers/user_auth/user_auth_controller.dart';
import 'package:shared_commute/controllers/user_data/user_data_controller.dart';
import 'package:shared_commute/models/user_model.dart';
import 'package:shared_commute/provider/user_provider.dart';
import 'package:shared_commute/views/widgets/sc_button.dart';
import 'package:shared_commute/views/widgets/sc_icon_button.dart';
import 'package:shared_commute/views/widgets/sc_text_input.dart';
import 'package:shared_commute/views/widgets/widget_builders.dart';

class EditProfile extends StatefulWidget {
  static const pageId = '/editProfile';
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController dobController;
  Uint8List? image;
  File? imageFile;

  void pickImage() async {
    final imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      showToast('Image not selected');
    } else {
      Uint8List img = await file.readAsBytes();
      setState(() {
        image = img;
        imageFile = File(file.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = context.read<UserProvider>().user;
    nameController = TextEditingController(text: user.displayName);
    phoneController = TextEditingController(text: user.pNo);
    dobController = TextEditingController(text: user.dob);

    return Scaffold(
      appBar: scAppBar('Edit Profile'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: image == null
                        ? NetworkImage(user.displayPic ?? GlobalConsts.altPfp)
                        : MemoryImage(image!),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: ScIconButton(
                      onPressed: pickImage,
                      icon: Icons.edit,
                      isOutlined: true,
                      buttonColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ScTextInput.fullWidth(
                controller: nameController,
                labelText: "Edit Name",
                hintText: "John Doe...",
              ),
              const SizedBox(
                height: 20,
              ),
              ScTextInput.fullWidth(
                controller: phoneController,
                hintText: "+91 9876543210",
                labelText: "Edit Phone Number",
              ),
              const SizedBox(
                height: 20,
              ),
              ScTextInput.fullWidth(
                controller: dobController,
                hintText: "DD/MM/YYYY",
                labelText: "Edit Date of Birth",
              ),
              const SizedBox(
                height: 20,
              ),
              ScButton(
                onTap: () async {
                  if (imageFile != null) {
                    UserDataController().uploadProfilePicture(imageFile!);
                  }
                  await UserDataController().updateUserDetails(
                      context: context,
                      newName: nameController.text,
                      newPNo: phoneController.text,
                      newDob: dobController.text);
                  if (context.mounted) {
                    context
                        .read<UserProvider>()
                        .updateUserFromUid(UserAuthController().getUser!.uid);
                    Navigator.pop(context);
                  }
                },
                text: "Submit",
              )
            ],
          ),
        ),
      ),
    );
  }
}
