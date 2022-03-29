import 'package:camicie_mockup/ui/model_detail_screen/widget/model_detail_body.dart';
import 'package:camicie_mockup/ui/size_detail_screen/bloc/size_model_bloc.dart';
import 'package:camicie_mockup/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModelDetailScreen extends StatelessWidget {
  const ModelDetailScreen({Key? key, required this.modelOfShirtEnum})
      : super(key: key);

  final ModelOfShirtEnum modelOfShirtEnum;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SizeBloc>(
      create: (BuildContext context) => SizeBloc(context, modelOfShirtEnum),
      lazy: false,
      child: const ModelDetailBody(),
    );
  }
}
