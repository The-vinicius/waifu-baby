import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:waifu_baby/src/cubits/waifu_cubit.dart';
import 'package:waifu_baby/src/repositoreis/waifu_repostory.dart';
import 'package:waifu_baby/src/state/waifu_state.dart';

class WaifuRepositoryMock extends Mock implements WaifuRepository {}

void main() {
  final repository = WaifuRepositoryMock();
  test('get imges', () async {
    final cubit = WaifuCubit(repository);
    when(() => repository.fetch()).thenAnswer((_) async => []);
    expect(cubit.stream,
        emitsInOrder([isA<LoadinWaifuState>(), isA<DoneWaifuState>()]));
    await cubit.fetch();
  });
}
