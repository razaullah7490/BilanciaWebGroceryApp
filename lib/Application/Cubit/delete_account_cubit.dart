import 'package:bloc/bloc.dart';
import 'package:grocery/Data/repository/auth/delete_repo.dart';
import 'package:meta/meta.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitial());
  deleteAccount(id) async {
    try {
      emit(DeleteAccountLoading());
      var res = await DeleteRepo().deleteAccount(id);
      if (res == true) {
        emit(DeleteAccountSuccess());
      } else {
        emit(DeleteAccountError());
      }
    } catch (e) {
      emit(DeleteAccountUnknownError());
    }
  }
}
