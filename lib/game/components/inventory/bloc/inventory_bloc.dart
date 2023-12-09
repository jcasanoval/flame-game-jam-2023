import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc() : super(const InventoryState.initial()) {
    on<LogAddedInventoryEvent>(_onLogAdded);
    on<LogRemovedInventoryEvent>(_onLogRemoved);
  }

  void _onLogAdded(LogAddedInventoryEvent event, Emitter<InventoryState> emit) {
    if (state.isFull) {
      return;
    }

    emit(state.copyWith(logs: state.logs + 1));
  }

  void _onLogRemoved(
    LogRemovedInventoryEvent event,
    Emitter<InventoryState> emit,
  ) {
    if (state.isEmpty) {
      return;
    }

    emit(state.copyWith(logs: state.logs - 1));
  }
}
