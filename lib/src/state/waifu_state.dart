import 'package:waifu_baby/src/models/waifu.dart';

sealed class WaifuSate {}

class LoadinWaifuState implements WaifuSate {}

class DoneWaifuState implements WaifuSate {
  final List<Waifu> imagesUrl;
  DoneWaifuState({required this.imagesUrl});
}

class EmptyWaifuState extends DoneWaifuState {
  EmptyWaifuState() : super(imagesUrl: []);
}

class FailureWaifuState implements WaifuSate {
  final String message;

  FailureWaifuState(this.message);
}
