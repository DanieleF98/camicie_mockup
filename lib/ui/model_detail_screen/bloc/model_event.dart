part of 'model_bloc.dart';

abstract class ModelEvent {
  const ModelEvent();
}

class ModelEventInitialEvent extends ModelEvent {
  const ModelEventInitialEvent();
}

class ModelEventAddModel extends ModelEvent {
  const ModelEventAddModel(this.modelOfShirt);

  final ModelOfShirt modelOfShirt;
}
