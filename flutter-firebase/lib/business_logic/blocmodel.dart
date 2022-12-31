import 'package:flutter_bloc/flutter_bloc.dart';

abstract class TypeEvent {}

class FalseEvent extends TypeEvent {}
class TrueEvent extends TypeEvent {}

class BlocModel extends Bloc<TypeEvent, bool> {
  BlocModel(bool initialState) : super(initialState) {
    on<FalseEvent>(_onFalse);
    on<TrueEvent>(_onTrue);
  }

  _onFalse(FalseEvent event, Emitter<bool> emit) { emit(false); }
  _onTrue(TrueEvent event, Emitter<bool> emit) { emit(true); }
}
