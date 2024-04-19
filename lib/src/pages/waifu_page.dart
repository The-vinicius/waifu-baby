import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waifu_baby/src/cubits/waifu_cubit.dart';
import 'package:waifu_baby/src/services/download.dart';
import 'package:waifu_baby/src/state/waifu_state.dart';
import 'package:waifu_baby/src/widgets/card_image.dart';
import 'package:waifu_baby/src/widgets/drawer_waifu.dart';

class WaifuPage extends StatefulWidget {
  const WaifuPage({super.key});

  @override
  State<WaifuPage> createState() => _WaifuPageState();
}

class _WaifuPageState extends State<WaifuPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<WaifuCubit>().fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<WaifuCubit>();
    final state = cubit.state;
    Widget body = Container();

    if (state is EmptyWaifuState) {
      body = const Center(
        key: Key('Empty'),
        child: Text('Nenhuma image'),
      );
    } else if (state is LoadinWaifuState) {
      body = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is DoneWaifuState) {
      final waifus = state.waifus;
      body = RefreshIndicator(
        onRefresh: () => cubit.fetchTags({
          'is_nsfw': true,
          'limit': 10,
          'byte_size': '<200000',
        }),
        child: ListView.builder(
            key: const Key('Done'),
            itemCount: waifus.length,
            cacheExtent: 10,
            itemBuilder: (context, index) {
              final waifu = waifus[index];
              return Stack(
                children: [
                  CardImage(url: waifu.url.toString()),
                  if (Platform.isAndroid)
                    IconButton(
                        onPressed: () async {
                          final scaffold = ScaffoldMessenger.of(context);
                          await Download().save(waifu.url.toString());
                          scaffold.showSnackBar(const SnackBar(
                            content: Text('Download finalizado'),
                          ));
                        },
                        icon: const Icon(
                          Icons.download,
                          color: Colors.black,
                        )),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: Text(
                        waifu.name,
                        style: const TextStyle(fontSize: 25),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                ],
              );
            }),
      );
    } else if (state is FailureWaifuState) {
      body = const Center(
        child: Text('Sem images'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Waifus',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: body,
      drawer: DrawerWaifu(),
    );
  }
}
