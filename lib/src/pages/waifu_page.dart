import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waifu_baby/src/cubits/waifu_cubit.dart';
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
      body = ListView.builder(
          key: const Key('Done'),
          itemCount: state.waifus.length,
          itemBuilder: (context, index) {
            final waifu = state.waifus[index];
            return Card(
              child: Image.network(waifu.url.toString()),
            );
          });
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
            )
          ],
        ),
      ),
    );
  }
}
