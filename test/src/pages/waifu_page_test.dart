import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:waifu_baby/src/cubits/waifu_cubit.dart';
import 'package:waifu_baby/src/pages/waifu_page.dart';
import 'package:waifu_baby/src/repositoreis/waifu_repostory.dart';

class WaifuRepositoryMock extends Mock implements WaifuRepository {}

void main() {
  final repository = WaifuRepositoryMock();
  late WaifuCubit cubit;

  setUp(() {
    cubit = WaifuCubit(repository);
  });

  testWidgets('complete done waifu', (widgetTester) async {
    when(() => repository.fetch()).thenAnswer((_) async => []);
    await widgetTester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: const MaterialApp(home: WaifuPage()),
      ),
    );
    expect(find.byKey(const Key('Empty')), findsOneWidget);
    await widgetTester.pump();

    expect(find.byKey(const Key('Done')), findsOneWidget);
  });

  testWidgets('find widget card', (widgetTester) async {
    when(() => repository.fetchTags(any())).thenAnswer((_) async => []);
    await widgetTester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: const MaterialApp(home: WaifuPage()),
      ),
    );
    expect(find.byKey(const Key('Empty')), findsOneWidget);

    final ScaffoldState state = widgetTester.firstState(find.byType(Scaffold));

    state.openDrawer();
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.byKey(const Key('nsfw')));
    await widgetTester.pumpAndSettle();

    expect(find.byKey(const Key('Done')), findsOneWidget);
  });
}
