import 'dart:async';

/// Classe responsável por centralizar o métodos de controle do stream controller
class SimpleBloc<T> {

  final _controller = StreamController<T>();

  Stream<T> get stream => _controller.stream;

  void add(T object) {
    _controller.add(object);
  }

  void addError(T object) {
    if (!_controller.isClosed) {
      _controller.addError(object);
    }
  }

  void dispose() {
    _controller.close();
  }
}