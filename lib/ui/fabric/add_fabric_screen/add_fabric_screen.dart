import 'dart:io';

import 'package:camicie_mockup/core/fabric/models/fabric.dart';
import 'package:camicie_mockup/ui/fabric/bloc/fabric_bloc.dart';
import 'package:camicie_mockup/ui/main/main_navigation/utils/navigation_utils.dart';
import 'package:camicie_mockup/utils/constants.dart';
import 'package:camicie_mockup/utils/storage_service.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:camicie_mockup/utils/style.dart';
import 'package:camicie_mockup/utils/utils.dart';
import 'package:camicie_mockup/utils/widgets/dialog/custom_loader_dialog.dart';
import 'package:camicie_mockup/utils/widgets/widget/custom_input.dart';
import 'package:camicie_mockup/utils/widgets/widget/custom_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddFabricScreen extends StatefulWidget {
  const AddFabricScreen({
    Key? key,
    required this.info,
  }) : super(key: key);

  final List<dynamic> info;

  @override
  State<AddFabricScreen> createState() => _AddFabricScreenState();
}

XFile? imageFile;

class _AddFabricScreenState extends State<AddFabricScreen> {
  final TextEditingController fabricNameController = TextEditingController();
  double totalAmount = 0;

  @override
  void dispose() {
    fabricNameController.dispose();
    image = null;
    imageFile = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int size = widget.info[0] as int;
    final ModelOfShirtEnum modelOfShirtEnum =
        widget.info[1] as ModelOfShirtEnum;

    final bool? isLoading =
        context.watch<FabricBloc>().state is FabricStateLoadedState
            ? (context.watch<FabricBloc>().state as FabricStateLoadedState)
                .isLoading
            : null;
    if (isLoading == false && Navigator.canPop(context)) {
      Navigator.pop(context);
      navigateBack(context);
    }
    return Column(
      children: <Widget>[
        const Spacer(),
        const FabricImagePicker(),
        const Spacer(),
        Text(
          modelOfShirtEnum == ModelOfShirtEnum.slim
              ? slimSizeIsLabel(size)
              : sizeIsLabel(size),
          style: boldTextStyle.copyWith(fontSize: 20),
        ),
        const Spacer(),
        Text(
          modelIsLabel(modelOfShirtEnum),
          style: boldTextStyle.copyWith(fontSize: 20),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomInput(
            inputController: fabricNameController,
            hintText: insertNameOfFabricLabel,
          ),
        ),
        const Spacer(),
        Text(
          insertTotalAmountOfFabricToAdd,
          style: boldTextStyle.copyWith(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomSlider(
            min: minSliderValue,
            max: maxSliderValue,
            onChange: (double amount) {
              totalAmount = amount;
            },
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () async {
            showCustomLoaderDialog(context);
            if (image == null) {
              showToastError(text: noPhotoSelected);
              Navigator.pop(context);
              return;
            } else if (fabricNameController.text.isEmpty) {
              showToastError(text: insertAtLeastOneCharacterLabel);
              Navigator.pop(context);
              return;
            } else if (totalAmount == 0) {
              showToastError(text: insertAtLeastOneItem);
              Navigator.pop(context);
              return;
            }
            try {
              await uploadImage(image!);
              final String imageUrl =
                  await StorageService().downloadImageUrl(image!.name);
              final Fabric newFabric = Fabric(
                '',
                size,
                modelOfShirtEnum,
                totalAmount.toInt(),
                imageUrl,
                fabricNameController.text,
              );
              if (!mounted) return;
              context.read<FabricBloc>().add(FabricEventAddFabric(newFabric));
            } catch (e) {
              showToastError(text: genericErrorLabel);
              return;
            }
          },
          child: const Text(
            confirmLabel,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class FabricImagePicker extends StatefulWidget {
  const FabricImagePicker({Key? key}) : super(key: key);

  @override
  State<FabricImagePicker> createState() => _FabricImagePickerState();
}

XFile? image;

class _FabricImagePickerState extends State<FabricImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          await showCameraDialog(context);
          setState(() {
            image = imageFile;
          });
        },
        child: Stack(
          children: <Widget>[
            ClipOval(
              child: Container(
                child: image == null
                    ? Container(
                        color: Colors.grey,
                        height: 100,
                        width: 100,
                      )
                    : Image.file(
                        File(image!.path),
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
              ),
            ),
            const Positioned(
              right: 0,
              bottom: 0,
              child: Icon(
                Icons.photo_camera_rounded,
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> showCameraDialog(
  BuildContext context,
) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) => const CameraAlert(),
  );
}

class CameraAlert extends StatefulWidget {
  const CameraAlert({
    Key? key,
  }) : super(key: key);

  @override
  State<CameraAlert> createState() => _CameraAlertState();
}

class _CameraAlertState extends State<CameraAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(chooseWhereToPickImageLabel),
      content: const Text(
        byPressingOneOfTheButtonYouChooseTheScourceOfTheImageLabel,
      ),
      actions: <ElevatedButton>[
        ElevatedButton(
          onPressed: () async {
            imageFile = await pickImage(
              ImageSource.gallery,
            );
            if (mounted) {
              Navigator.pop(context);
            }
          },
          child: Text(
            galleryLabel,
            style: boldTextStyle.copyWith(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            imageFile = await pickImage(
              ImageSource.camera,
            );
            if (mounted) {
              Navigator.pop(context);
            }
          },
          child: Text(
            cameraLabel,
            style: boldTextStyle.copyWith(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
