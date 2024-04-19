import 'dart:io';

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
  List a = [
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/02/01/22/02/mountain-landscape-2031539_960_720.jpg",
    "https://cdn.pixabay.com/photo/2014/09/14/18/04/dandelion-445228_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/08/09/21/54/yellowstone-national-park-1581879_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/07/11/15/43/pretty-woman-1509956_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/02/13/12/26/aurora-1197753_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
    "https://cdn.pixabay.com/photo/2013/11/28/10/03/autumn-219972_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/17/19/08/away-3024773_960_720.jpg",
  ];
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
                  Card(
                    child: Image.network(
                      waifu.url.toString(),
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
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
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.7,
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
                cubit.fetchTags({
                  'is_nsfw': true,
                  'limit': 10,
                  'byte_size': '<200000',
                });
                Navigator.pop(context);
              },
              title: const Text('NSFW'),
            ),
            ListTile(
              key: const Key('versatile'),
              onTap: () {
                cubit.fetchTags({
                  'versatile': 'waifu',
                  'limit': 10,
                  'byte_size': '<200000'
                });
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
