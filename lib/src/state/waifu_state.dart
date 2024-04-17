import 'package:waifu_baby/src/models/waifu.dart';

sealed class WaifuSate {}

class LoadinWaifuState implements WaifuSate {}

class DoneWaifuState implements WaifuSate {
  final List<Waifu> waifus;
  DoneWaifuState({required this.waifus});
}

class EmptyWaifuState extends DoneWaifuState {
  EmptyWaifuState() : super(waifus: []);
}

class FailureWaifuState implements WaifuSate {
  final String message;

  FailureWaifuState(this.message);
}
