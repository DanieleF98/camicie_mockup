import 'package:cached_network_image/cached_network_image.dart';
import 'package:camicie_mockup/core/fabric/models/fabric.dart';
import 'package:camicie_mockup/ui/fabric/bloc/fabric_bloc.dart';
import 'package:camicie_mockup/ui/home_screen/floating_action_button/floating_action_button.dart';
import 'package:camicie_mockup/ui/main/main_navigation/utils/navigation_utils.dart';
import 'package:camicie_mockup/utils/constants.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:camicie_mockup/utils/style.dart';
import 'package:camicie_mockup/utils/widgets/dialog/custom_loader_dialog.dart';
import 'package:camicie_mockup/utils/widgets/dialog/custom_simple_dialog.dart';
import 'package:camicie_mockup/utils/widgets/dialog/full_screen_loader.dart';
import 'package:camicie_mockup/utils/widgets/dialog/quantity_picker_dialog.dart';
import 'package:camicie_mockup/utils/widgets/widget/error_and_retry.dart';
import 'package:camicie_mockup/utils/widgets/widget/slidable_with_edit_and_delete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SizeDetailBody extends StatelessWidget {
  const SizeDetailBody(this.size, this.modelOfShirtEnum, {Key? key})
      : super(key: key);

  final int size;
  final ModelOfShirtEnum modelOfShirtEnum;

  @override
  Widget build(BuildContext context) {
    bool isLoaded = false;

    return BlocConsumer<FabricBloc, FabricState>(
      listener: (BuildContext context, FabricState state) {
        if (state is FabricStateLoadedState) {
          final bool? isLoading = state.isLoading;
          if (isLoading == true) {
            isLoaded = true;
            showCustomLoaderDialog(context);
          } else if (isLoaded == true && isLoading == false) {
            isLoaded = false;
            const CustomLoaderAlert().dismissDialog(context);
          }
        }
      },
      builder: (BuildContext context, FabricState state) {
        if (state is FabricStateLoadedState) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.fabrics.length,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    final Fabric fabric = state.fabrics[index];
                    return SlidableWithEditAndDelete(
                      onEditPressed: () => showQuantityPickerDialog(
                        context,
                        fabric: fabric,
                        title: editFabricLabel,
                      ),
                      key: Key(fabric.id),
                      onDeletePressed: () => showCustomAlert(
                        context,
                        areYouSureYouWantToDeleteThisFabricLabel,
                        byPressingConfirmYouWillDeleteTheFabricLabel,
                        () {
                          context.read<FabricBloc>().add(
                                FabricEventRemoveFabric(fabric),
                              );
                          Navigator.pop(context);
                        },
                      ),
                      child: Card(
                        margin: const EdgeInsets.all(5),
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => navigateToFabricImage(
                                context,
                                fabric.imageUrl,
                                fabric.id,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipOval(
                                  child: Hero(
                                    tag: fabric.id,
                                    child: CachedNetworkImage(
                                      imageUrl: fabric.imageUrl,
                                      width: 75,
                                      height: 75,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        fabric.fabricName,
                                        style: boldTextStyle.copyWith(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      getTotalAvailableAmountWithLabel(
                                        fabric.totalAmount,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        modelIsLabel(modelOfShirtEnum),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        modelOfShirtEnum ==
                                                ModelOfShirtEnum.slim
                                            ? slimSizeIsLabel(fabric.size)
                                            : sizeIsLabel(fabric.size),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: floatingActionButton(
                  context,
                  size,
                  modelOfShirtEnum,
                ),
              ),
            ],
          );
        } else if (state is FabricStateErrorState) {
          return Center(
            child: ErrorAndRetry(
              retryFunction: () => context.read<FabricBloc>().add(
                    const FabricEventInitialEvent(),
                  ),
            ),
          );
        } else {
          return const FullScreenLoader();
        }
      },
    );
  }
}
