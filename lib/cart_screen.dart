import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_list_example/presentation/cart_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'cart_item_tile.dart';

class CartScreen extends HookConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartItemNotifier = ref.watch(cartProvider.notifier);

    useMemoized(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        cartItemNotifier.addMockData();
      });
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('장바구니'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Checkbox(
                  value: cartItemNotifier.allItemsSelected,
                  onChanged: (value) {

                    if (value == true) {
                      cartItemNotifier.toggleAllSelection();
                    } else {
                      // 선택된 항목이 없을 때 전체 선택 버튼 체크 해제
                      cartItemNotifier.toggleAllSelection();
                    }

                  }
                ),
                const Text('전체 선택'),
                const Spacer(),

                if (cartItemNotifier.hasSelectedItems)
                TextButton(
                  onPressed: () =>
                      cartItemNotifier.removeSelectedItems(),
                  child: const Text('선택 삭제'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CartItemTile(
                  item: item,
                  onQuantityChanged: (newQuantity) =>
                      cartItemNotifier.updateQuantity(item.id, newQuantity),
                  onRemoved: () =>
                      cartItemNotifier.removeItem(item.id),
                  onToggled: () =>
                      cartItemNotifier.toggleItemSelection(item.id),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    return Text('선택 항목: ${cartItemNotifier.selectedItemCount}개');
                  },
                ),
                const Spacer(),
                Consumer(
                  builder: (context, ref, child) {
                    return Text('총 금액: ${cartItemNotifier.selectedItemsTotalPrice.toStringAsFixed(2)}원');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
