part of 'fabric_bloc.dart';

abstract class FabricState {
  const FabricState();
}

class FabricStateInitialState extends FabricState {
  const FabricStateInitialState(this.size);

  final int size;
}

class FabricStateLoadedState extends FabricState {
  const FabricStateLoadedState(
    this.fabrics, {
    this.isLoading,
  });

  FabricStateLoadedState copyWith({List<Fabric>? fabrics, bool? isLoading}) {
    return FabricStateLoadedState(
      fabrics ?? this.fabrics,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final List<Fabric> fabrics;
  final bool? isLoading;
}

class FabricStateErrorState extends FabricState {
  const FabricStateErrorState();
}
