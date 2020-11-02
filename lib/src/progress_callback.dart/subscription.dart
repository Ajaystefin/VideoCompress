import 'dart:async';

import 'dart:ui';

import '../../video_compress.dart';
import 'compress_mixin.dart';

class ObservableBuilder<T> {
  StreamController<T> _observable = StreamController();
  bool notSubscribed = true;

  void next(T value) {
    _observable.add(value);
  }

  Subscription subscribe(void onData(T event),
      {Function onError, void onDone(), bool cancelOnError}) {
    notSubscribed = false;
    _observable.stream.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
    return Subscription(() {
      _observable.close();

      // Create a new instance to avoid errors
      _observable = StreamController();
    });
  }
}
