import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waifu_baby/src/core/constants.dart';
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
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/zerotwo.png'),
              ),
            ),
            child: Text(
              'Waifus',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                shadows: [Shadow(color: Colors.black, offset: Offset(1, 0))],
              ),
            ),
          ),
          ListTile(
            key: const Key('nsfw'),
            onTap: () {
              cubit.fetchTags({
                'IsNsfw': true,
                'limit': 10,
                'byte_size': '<200000',
              });
              Navigator.pop(context);
            },
            title: const Text('NSFW'),
          ),
          ...nsfw.map((e) => ListTile(
                onTap: () {
                  cubit.fetchTags({
                    'IsNsfw': true,
                    'IncludedTags': e,
                    'PageSize': 10,
                    'byteSize': '<200000',
                  });

                  Navigator.pop(context);
                },
                title: Text('NSFW-$e'),
              )),
          ...versatile.map((e) => ListTile(
                onTap: () {
                  cubit.fetchTags({
                    'IsNsfw': true,
                    'IncludedTags': e,
                    'PageSize': 10,
                    'byteSize': '<200000',
                  });

                  Navigator.pop(context);
                },
                title: Text('versatile-$e'),
              )),
        ],
      ),
    );
  }
}
