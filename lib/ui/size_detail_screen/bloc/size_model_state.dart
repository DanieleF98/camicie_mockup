part of 'size_model_bloc.dart';

abstract class SizeModelState {
  const SizeModelState();
}

class SizeModelStateInitialState extends SizeModelState {
  const SizeModelStateInitialState(this.modelOfShirtEnum);

  final ModelOfShirtEnum modelOfShirtEnum;
}

class SizeModelStateLoadedState extends SizeModelState {
  const SizeModelStateLoadedState(this.sizes);

  SizeModelStateLoadedState copyWith(List<SizeModel>? sizes) {
    return SizeModelStateLoadedState(sizes ?? this.sizes);
  }

  final List<SizeModel> sizes;
}

class SizeModelStateErrorState extends SizeModelState {
  const SizeModelStateErrorState();
}
