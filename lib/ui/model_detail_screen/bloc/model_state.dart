part of 'model_bloc.dart';

abstract class ModelState {
  const ModelState();
}

class ModelStateInitialState extends ModelState {
  const ModelStateInitialState();
}

class ModelStateLoadedState extends ModelState {
  const ModelStateLoadedState(this.modelOfShirt);

  ModelStateLoadedState copyWith({List<ModelOfShirt>? modelOfShirt}) {
    return ModelStateLoadedState(modelOfShirt ?? this.modelOfShirt);
  }

  final List<ModelOfShirt> modelOfShirt;
}

class ModelStateErrorState extends ModelState {
  const ModelStateErrorState();
}
