import 'package:flutter_bloc/flutter_bloc.dart';

class SetBoolCubit extends Cubit<bool> {
  SetBoolCubit(bool initialState) : super(true);

  changeState(bool change) {
    emit(change);
  }
}
