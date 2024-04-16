import 'package:bloc/bloc.dart';
import 'package:waifu_baby/src/repositoreis/waifu_repostory.dart';
import 'package:waifu_baby/src/state/waifu_state.dart';

class WaifuCubit extends Cubit<WaifuSate> {
  final WaifuRepository repository;
  WaifuCubit(this.repository) : super(EmptyWaifuState());

  Future<void> fetch() async {
    emit(LoadinWaifuState());
    try {
      final imagesUrl = await repository.fetch();
      emit(DoneWaifuState(imagesUrl: imagesUrl));
    } catch (e) {
      emit(FailureWaifuState('Error Get images'));
    }
  }

  Future<void> fetchTags(Map<String, dynamic> tags) async {
    emit(LoadinWaifuState());
    try {
      final imagesUrl = await repository.fetchTags(tags);
      emit(DoneWaifuState(imagesUrl: imagesUrl));
    } catch (e) {
      emit(FailureWaifuState('Error Get images'));
    }
  }
}
