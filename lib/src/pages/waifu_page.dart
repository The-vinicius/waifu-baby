import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waifu_baby/src/cubits/waifu_cubit.dart';
import 'package:waifu_baby/src/services/download.dart';
import 'package:waifu_baby/src/state/waifu_state.dart';

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
      body = ListView(
        key: const Key('Done'),
        children: waifus.map((e) {
          return Stack(
            children: [
              Card(
                child: CachedNetworkImage(imageUrl: e.url.toString()),
              ),
              IconButton(
                  onPressed: () async {
                    final scaffold = ScaffoldMessenger.of(context);
                    await Download().save(e.url.toString());
                    scaffold.showSnackBar(const SnackBar(
                      content: Text('Download finalizado'),
                    ));
                  },
                  icon: const Icon(Icons.download))
            ],
          );
        }).toList(),
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
      drawer: Drawer(
        width: MediaQuery.of(context).size.width / 2,
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Text('Waifus'),
            ),
            ListTile(
              key: const Key('nsfw'),
              onTap: () {
                cubit.fetchTags({'is_nsfw': true, 'limit': 10});
                Navigator.pop(context);
              },
              title: const Text('NSFW'),
            ),
            ListTile(
              key: const Key('versatile'),
              onTap: () {
                cubit.fetchTags({'versatile': 'waifu', 'limit': 10});
                Navigator.pop(context);
              },
              title: const Text('versatile'),
            ),
          ],
        ),
      ),
    );
  }
}
