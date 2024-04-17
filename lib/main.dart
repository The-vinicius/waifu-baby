import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waifu_baby/src/cubits/waifu_cubit.dart';
import 'package:waifu_baby/src/data/waifu_datasource.dart';
import 'package:waifu_baby/src/data/waifu_im_repostory.dart';
import 'package:waifu_baby/src/pages/waifu_page.dart';
import 'package:waifu_baby/src/repositoreis/waifu_repostory.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(create: (ctx) => WaifuDatasource()),
        RepositoryProvider<WaifuRepository>(
            create: (ctx) => WaifuImRepostory(ctx.read())),
        BlocProvider(create: (ctx) => WaifuCubit(ctx.read())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.pink,
        ),
        home: const WaifuPage(),
      ),
    );
  }
}
