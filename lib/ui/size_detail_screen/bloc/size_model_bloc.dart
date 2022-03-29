import 'dart:developer';

import 'package:camicie_mockup/core/size_model/converters/size_model_builder.dart';
import 'package:camicie_mockup/core/size_model/models/size_model.dart';
import 'package:camicie_mockup/core/size_model/size_repository.dart';
import 'package:camicie_mockup/utils/constants.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:camicie_mockup/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'size_model_event.dart';
part 'size_model_state.dart';

class SizeBloc extends Bloc<SizeModelEvent, SizeModelState> {
  SizeBloc(BuildContext context, this.modelOfShirtEnum)
      : _sizeModelRepository = context.read<SizeModelRepository>(),
        super(SizeModelStateInitialState(modelOfShirtEnum)) {
    on<SizeModelEventInitialEvent>(_onSizeModelEventInitialEvent);
    on<SizeModelEventAddSize>(_onSizeModelEventAddSize);
    add(const SizeModelEventInitialEvent());
  }
  final ModelOfShirtEnum modelOfShirtEnum;
  final SizeModelRepository _sizeModelRepository;

  Future<void> _onSizeModelEventInitialEvent(
    SizeModelEventInitialEvent event,
    Emitter<SizeModelState> emit,
  ) async {
    emit(SizeModelStateInitialState(modelOfShirtEnum));
    try {
      final QuerySnapshot<dynamic> querySnapshot =
          await _sizeModelRepository.getAllSizeModels();
      final List<SizeModel> sizeModels = <SizeModel>[];
      querySnapshot.docs.map(
        (QueryDocumentSnapshot<dynamic> doc) {
          if (getModelEnumFromString(
                doc.data()['ModelOfShirtEnum'] as String,
              ) ==
              modelOfShirtEnum) {
            sizeModels.add(
              SizeModelBuilder.builder(
                doc.data(),
              ),
            );
          }
        },
      ).toList();
      if (sizeModels.isNotEmpty) {
        sizeModels.sort((SizeModel a, SizeModel b) => a.size.compareTo(b.size));
        emit(SizeModelStateLoadedState(sizeModels));
      } else {
        showToastError(
          text: anErrorHasOccurredWithError(
            retrievingSizeLabel,
          ),
        );
        emit(const SizeModelStateErrorState());
      }
    } catch (e) {
      showToastError(
        text: anErrorHasOccurredWithError(
          retrievingSizeLabel,
        ),
      );
      log(e.toString());
      emit(
        const SizeModelStateErrorState(),
      );
    }
  }

  Future<void> _onSizeModelEventAddSize(
    SizeModelEventAddSize event,
    Emitter<SizeModelState> emit,
  ) async {
    final SizeModelState oldState = state;
    if (oldState is SizeModelStateLoadedState) {
      try {
        final DocumentReference<dynamic> doc =
            await _sizeModelRepository.addSizeModel(event.sizeModel);
        await _sizeModelRepository
            .updateSizeModel(event.sizeModel.copyWith(id: doc.id));
        final List<SizeModel> sizeModels = oldState.sizes;
        sizeModels.add(event.sizeModel.copyWith(id: doc.id));
        emit(oldState.copyWith(sizeModels));
      } catch (e) {
        showToastError(
          text: anErrorHasOccurredWithError(
            addingNewSizeLabel,
          ),
        );
        log(e.toString());
        emit(
          const SizeModelStateErrorState(),
        );
      }
    } else {
      try {
        final DocumentReference<dynamic> doc =
            await _sizeModelRepository.addSizeModel(event.sizeModel);
        await _sizeModelRepository
            .updateSizeModel(event.sizeModel.copyWith(id: doc.id));
        final SizeModel sizeModel = event.sizeModel.copyWith(id: doc.id);
        emit(SizeModelStateLoadedState(<SizeModel>[sizeModel]));
      } catch (e) {
        showToastError(
          text: anErrorHasOccurredWithError(
            addingNewSizeLabel,
          ),
        );
        log(e.toString());
        emit(
          const SizeModelStateErrorState(),
        );
      }
    }
  }
}
