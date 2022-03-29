import 'dart:developer';

import 'package:camicie_mockup/core/model_of_shirt/converters/model_of_shirt_builder.dart';
import 'package:camicie_mockup/core/model_of_shirt/model_of_shirt_repository.dart';
import 'package:camicie_mockup/core/model_of_shirt/models/model_of_shirt.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:camicie_mockup/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'model_event.dart';
part 'model_state.dart';

class ModelBloc extends Bloc<ModelEvent, ModelState> {
  ModelBloc(
    BuildContext context,
  )   : _modelOfShirtRepository = context.read<ModelOfShirtRepository>(),
        super(const ModelStateInitialState()) {
    on<ModelEventInitialEvent>(_onModelEventInitialEvent);
    on<ModelEventAddModel>(_onModelEventAddModel);
    add(const ModelEventInitialEvent());
  }
  final ModelOfShirtRepository _modelOfShirtRepository;

  Future<void> _onModelEventInitialEvent(
    ModelEventInitialEvent event,
    Emitter<ModelState> emit,
  ) async {
    emit(const ModelStateInitialState());
    try {
      final QuerySnapshot<dynamic> querySnapshot =
          await _modelOfShirtRepository.getAllModelsOfShirt();
      final List<ModelOfShirt> modelsOfShirt = <ModelOfShirt>[];
      querySnapshot.docs
          .map(
            (QueryDocumentSnapshot<dynamic> doc) => modelsOfShirt.add(
              ModelOfShirtBuilder.builder(
                doc.data(),
              ),
            ),
          )
          .toList();
      if (modelsOfShirt.isNotEmpty) {
        emit(ModelStateLoadedState(modelsOfShirt));
      } else {
        showToastError(
          text: anErrorHasOccurredWithError(
            retrievingModelLabel,
          ),
        );
        emit(
          const ModelStateErrorState(),
        );
      }
    } catch (e) {
      showToastError(
        text: anErrorHasOccurredWithError(
          retrievingModelLabel,
        ),
      );
      log(e.toString());
      emit(
        const ModelStateErrorState(),
      );
    }
  }

  Future<void> _onModelEventAddModel(
    ModelEventAddModel event,
    Emitter<ModelState> emit,
  ) async {
    final ModelState oldState = state;
    if (oldState is ModelStateLoadedState) {
      try {
        final DocumentReference<dynamic> doc =
            await _modelOfShirtRepository.addModelOfShirt(event.modelOfShirt);
        await _modelOfShirtRepository
            .updateModelOfShirt(event.modelOfShirt.copyWith(id: doc.id));
        final List<ModelOfShirt> modelOfShirt = oldState.modelOfShirt;
        modelOfShirt.add(event.modelOfShirt.copyWith(id: doc.id));
        if (modelOfShirt.isNotEmpty) {
          emit(oldState.copyWith(modelOfShirt: modelOfShirt));
        } else {
          showToastError(
            text: anErrorHasOccurredWithError(
              addingNewModelLabel,
            ),
          );
          emit(const ModelStateErrorState());
        }
      } catch (e) {
        showToastError(
          text: anErrorHasOccurredWithError(
            addingNewModelLabel,
          ),
        );
        log(e.toString());
        emit(const ModelStateErrorState());
      }
    } else {
      try {
        final DocumentReference<dynamic> doc =
            await _modelOfShirtRepository.addModelOfShirt(event.modelOfShirt);
        await _modelOfShirtRepository
            .updateModelOfShirt(event.modelOfShirt.copyWith(id: doc.id));
        final ModelOfShirt modelOfShirt =
            event.modelOfShirt.copyWith(id: doc.id);
        emit(ModelStateLoadedState(<ModelOfShirt>[modelOfShirt]));
      } catch (e) {
        showToastError(
          text: anErrorHasOccurredWithError(
            addingNewModelLabel,
          ),
        );
        log(e.toString());
        emit(const ModelStateErrorState());
      }
    }
  }
}
