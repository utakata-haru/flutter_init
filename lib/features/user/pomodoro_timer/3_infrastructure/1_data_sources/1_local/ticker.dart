// シンプルなティッカー（1秒ごとにコールバック）
// 今はdart:async Timerを直接使用しているが、
// テスト容易性やプラットフォーム差異吸収のために抽象化しておく。

import 'dart:async';

typedef TickCallback = void Function();

class Ticker {
  Timer? _timer;

  void start(TickCallback onTick) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => onTick());
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }
}