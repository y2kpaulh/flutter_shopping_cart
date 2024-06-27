import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_list_example/presentation/cart_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'cart_item_widget.dart';

class CartScreen extends HookConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartItemNotifier = ref.watch(cartProvider.notifier);
    final allItemsSelected = cartItemNotifier.allItemsSelected;
    final selectAll = useState(false);

    useMemoized(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        cartItemNotifier.addMockData();
      });
    }, []);

    useEffect(() {
      if (cartItems.isEmpty) {
        selectAll.value = false;
      } else {
        selectAll.value = allItemsSelected;
      }
      return null;
    }, [cartItems, allItemsSelected]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('장바구니'),
      ),
      body: Column(
        children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: selectAll.value,
                        onChanged: (value) {
                          if (value != null) {
                            selectAll.value = value;
                            cartItemNotifier.toggleAllSelection();
                          }
                        },
                      ),
                      const Text(
                        '전체 선택',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const Spacer(),
                      if (cartItemNotifier.hasSelectedItems)
                        TextButton(
                          onPressed: () =>
                              cartItemNotifier.removeSelectedItems(),
                          child: const Text('선택 삭제'),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.black,
                      height: 1,
                    ),
                  )
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CartItemWidget(
                  item: item,
                  onQuantityChanged: (newQuantity) =>
                      cartItemNotifier.updateQuantity(item.id, newQuantity),
                  onRemoved: () => cartItemNotifier.removeItem(item.id),
                  onToggled: () =>
                      cartItemNotifier.toggleItemSelection(item.id),
                );
              },
            ),
          ),
          Container(
            color: Colors.grey.shade200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.black,
                  height: 1,
                ),
                SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text('선택 항목: ${cartItemNotifier.selectedItemCount}개',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Text('총 금액: ${cartItemNotifier.selectedItemsTotalPrice.toStringAsFixed(2)}원',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
