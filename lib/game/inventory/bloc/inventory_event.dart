part of 'inventory_bloc.dart';

sealed class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object> get props => [];
}

/// {@template InventoryAddedLogEvent}
/// A wooden log was added to the inventory.
/// {@endtemplate}
class LogAddedInventoryEvent extends InventoryEvent {
  /// {@macro InventoryAddedLogEvent}
  const LogAddedInventoryEvent();
}

/// {@template InventoryRemovedLogEvent}
/// A wooden log was removed from the inventory.
/// {@endtemplate}
class LogRemovedInventoryEvent extends InventoryEvent {
  const LogRemovedInventoryEvent();
}
