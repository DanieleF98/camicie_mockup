import 'package:camicie_mockup/core/size_model/models/size_model.dart';
import 'package:camicie_mockup/ui/main/main_navigation/utils/navigation_utils.dart';
import 'package:camicie_mockup/utils/constants.dart';
import 'package:camicie_mockup/utils/utils.dart';
import 'package:flutter/material.dart';

class ModelDetailGridView extends StatelessWidget {
  const ModelDetailGridView({Key? key, required this.sizes}) : super(key: key);

  final List<SizeModel> sizes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: twoColumns,
      ),
      itemCount: sizes.length,
      itemBuilder: (BuildContext context, int index) {
        return GridTile(
          child: ElevatedButton(
            onPressed: () => navigateToSizeInfo(context, <dynamic>[
              sizes[index].size,
              sizes[index].modelOfShirtEnum,
            ]),
            child: _getTextFromModelOfShirtEnum(sizes, index),
          ),
        );
      },
    );
  }

  Widget _getTextFromModelOfShirtEnum(List<SizeModel> sizes, int index) {
    final bool isSlim = sizes.any(
      (SizeModel element) => element.modelOfShirtEnum == ModelOfShirtEnum.slim,
    );
    return Text(
      isSlim
          ? getSlimSizeFromInt(
              sizes[index].size,
            )
          : sizes[index].size.toString(),
    );
  }
}
