sealed class WaifuSate {}

class LoadinWaifuState implements WaifuSate {}

class DoneWaifuState implements WaifuSate {
  final List<String> imagesUrl;
  DoneWaifuState({required this.imagesUrl});
}

class EmptyWaifuState extends DoneWaifuState {
  EmptyWaifuState() : super(imagesUrl: []);
}

class FailureWaifuState implements WaifuSate {
  final String message;

  FailureWaifuState(this.message);
}
