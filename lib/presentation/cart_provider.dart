// 장바구니 상태 관리를 위한 Provider
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'cart_item.dart';
import 'cart_notifier.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});
