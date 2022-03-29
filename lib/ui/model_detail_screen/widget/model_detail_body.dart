import 'package:camicie_mockup/ui/model_detail_screen/widget/model_detail_grid_view.dart';
import 'package:camicie_mockup/ui/size_detail_screen/bloc/size_model_bloc.dart';
import 'package:camicie_mockup/utils/widgets/dialog/full_screen_loader.dart';
import 'package:camicie_mockup/utils/widgets/widget/error_and_retry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModelDetailBody extends StatelessWidget {
  const ModelDetailBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SizeBloc, SizeModelState>(
      builder: (BuildContext context, SizeModelState state) {
        if (state is SizeModelStateLoadedState) {
          return ModelDetailGridView(sizes: state.sizes);
        } else if (state is SizeModelStateErrorState) {
          return Center(
            child: ErrorAndRetry(
              retryFunction: () => context.read<SizeBloc>().add(
                    const SizeModelEventInitialEvent(),
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
