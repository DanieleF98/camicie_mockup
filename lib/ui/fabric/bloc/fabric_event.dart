part of 'fabric_bloc.dart';

abstract class FabricEvent {
  const FabricEvent();
}

class FabricEventInitialEvent extends FabricEvent {
  const FabricEventInitialEvent();
}

class FabricEventUpdateFabric extends FabricEvent {
  const FabricEventUpdateFabric(this.fabric);
  final Fabric fabric;
}

class FabricEventUpdateFabrics extends FabricEvent {
  const FabricEventUpdateFabrics();
}

class FabricEventAddFabric extends FabricEvent {
  const FabricEventAddFabric(this.fabric);

  final Fabric fabric;
}

class FabricEventRemoveFabric extends FabricEvent {
  const FabricEventRemoveFabric(this.fabric);

  final Fabric fabric;
}
