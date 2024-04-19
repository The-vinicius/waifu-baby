import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waifu_baby/src/cubits/waifu_cubit.dart';

class DrawerWaifu extends StatelessWidget {
  const DrawerWaifu({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WaifuCubit>();
    return Drawer(
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
              cubit.fetchTags(
                  {'versatile': 'waifu', 'limit': 10, 'byte_size': '<200000'});
              Navigator.pop(context);
            },
            title: const Text('versatile'),
          ),
        ],
      ),
    );
  }
}
