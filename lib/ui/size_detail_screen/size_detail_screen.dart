import 'package:camicie_mockup/ui/fabric/bloc/fabric_bloc.dart';
import 'package:camicie_mockup/ui/size_detail_screen/widget/size_detail_body.dart';
import 'package:camicie_mockup/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SizeDetailScreen extends StatelessWidget {
  const SizeDetailScreen({Key? key, required this.info}) : super(key: key);

  final List<dynamic> info;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FabricBloc>(
      create: (BuildContext context) => FabricBloc(
        context,
        info[0] as int,
        info[1] as ModelOfShirtEnum,
      ),
      lazy: false,
      child: SizeDetailBody(info[0] as int, info[1] as ModelOfShirtEnum),
    );
  }
}
