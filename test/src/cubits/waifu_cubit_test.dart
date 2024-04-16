import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:waifu_baby/src/cubits/waifu_cubit.dart';
import 'package:waifu_baby/src/repositoreis/waifu_repostory.dart';
import 'package:waifu_baby/src/state/waifu_state.dart';

class WaifuRepositoryMock extends Mock implements WaifuRepository {}

void main() {
  final repository = WaifuRepositoryMock();
  late WaifuCubit cubit;

  setUp(() {
    cubit = WaifuCubit(repository);
  });

  test('get imges', () async {
    when(() => repository.fetch()).thenAnswer((_) async => []);
    expect(cubit.stream,
        emitsInOrder([isA<LoadinWaifuState>(), isA<DoneWaifuState>()]));
    await cubit.fetch();
  });
  test('failure get imges', () async {
    when(() => repository.fetch()).thenThrow(Exception());
    expect(cubit.stream,
        emitsInOrder([isA<LoadinWaifuState>(), isA<FailureWaifuState>()]));
    await cubit.fetch();
  });

  test('get tags images', () async {
    when(() => repository.fetchTags(any())).thenAnswer((_) async => []);
    expect(cubit.stream,
        emitsInOrder([isA<LoadinWaifuState>(), isA<DoneWaifuState>()]));
    await cubit.fetchTags({'is_nsfw': true});
  });

  test('failure get tags images', () async {
    when(() => repository.fetchTags(any())).thenThrow(Exception());
    expect(cubit.stream,
        emitsInOrder([isA<LoadinWaifuState>(), isA<FailureWaifuState>()]));
    await cubit.fetchTags({'is_nsfw': true});
  });
}
