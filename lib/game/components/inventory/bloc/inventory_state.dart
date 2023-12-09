part of 'inventory_bloc.dart';

class InventoryState extends Equatable {
  const InventoryState._({
    required this.logs,
  });

  /// The initial state of the inventory.
  const InventoryState.initial() : this._(logs: 0);

  /// The maximum number of items (such as logs) that can be stored in the
  /// inventory simultaneously.
  static const _inventorySize = 4;

  /// The number of logs in the inventory.
  final int logs;

  /// Whether the inventory is full.
  bool get isFull => logs >= _inventorySize;

  /// Whether the inventory is empty.
  bool get isEmpty => logs == 0;

  InventoryState copyWith({
    int? logs,
  }) {
    return InventoryState._(
      logs: logs ?? this.logs,
    );
  }

  @override
  List<Object> get props => [logs];
}
