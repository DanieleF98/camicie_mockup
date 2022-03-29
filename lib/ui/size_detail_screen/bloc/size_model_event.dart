part of 'size_model_bloc.dart';

abstract class SizeModelEvent {
  const SizeModelEvent();
}

class SizeModelEventInitialEvent extends SizeModelEvent {
  const SizeModelEventInitialEvent();
}

class SizeModelEventAddSize extends SizeModelEvent {
  const SizeModelEventAddSize(this.sizeModel);
  final SizeModel sizeModel;
}
