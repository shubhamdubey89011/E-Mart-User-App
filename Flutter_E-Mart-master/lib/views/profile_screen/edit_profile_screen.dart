// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/profile_controller.dart';
//import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/common_buttons.dart';
import 'package:emart_app/widgets_common/customtextfield_widget.dart';
import 'package:get/get.dart';
//import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  final dynamic data;
  const EditProfile({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(imgBackground), fit: BoxFit.fill),
        ),
        child: Scaffold(
          appBar: AppBar(),
          body: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                    ? Image.asset(
                        imgProfile2,
                        width: 90,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : data['imageUrl'] != '' &&
                            controller.profileImgPath.isEmpty
                        ? Image.network(
                            data['imageUrl'],
                            width: 90,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.file(
                            File(controller.profileImgPath.value),
                            width: 90,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                commonButtons(
                    color: redColor,
                    onPress: () {
                      controller.changeImage(context);
                    },
                    textColor: whiteColor,
                    title: "Change"),
                const Divider(),
                20.heightBox,
                customTextField(
                  controller: controller.nameController,
                  hint: nameHint,
                  title: name,
                  isPass: false,
                ),
                10.heightBox,
                customTextField(
                  controller: controller.oldpassController,
                  hint: passwordHint,
                  title: oldpass,
                  isPass: true,
                ),
                10.heightBox,
                customTextField(
                  controller: controller.newpassController,
                  hint: passwordHint,
                  title: newpass,
                  isPass: true,
                ),
                20.heightBox,
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : SizedBox(
                        width: context.screenWidth - 60,
                        child: commonButtons(
                            color: redColor,
                            onPress: () async {
                              controller.isLoading(true);
                              if (controller.profileImgPath.value.isNotEmpty) {
                                await controller.uploadProfileImage();
                              } else {
                                controller.profileImageLink = data['imageUrl'];
                              }

                              if (data['password'] ==
                                  controller.oldpassController.text) {
                                await controller.changeAuthPassword(
                                    email: data['email'],
                                    password: controller.oldpassController.text,
                                    newpassword:
                                        controller.newpassController.text);
                                await controller.updateProfile(
                                    imgurl: controller.profileImageLink,
                                    name: controller.nameController.text,
                                    password:
                                        controller.newpassController.text);

                                VxToast.show(context,
                                    msg: "Updated Successfully");
                              } else {
                                VxToast.show(context,
                                    msg: "Wrong Old Password.");
                                controller.isLoading(false);
                              }
                            },
                            textColor: whiteColor,
                            title: "Save"),
                      ),
              ],
            )
                .box
                .white
                .shadowSm
                .padding(const EdgeInsets.all(16))
                .rounded
                .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
                .make(),
          ),
        ));
  }
}
