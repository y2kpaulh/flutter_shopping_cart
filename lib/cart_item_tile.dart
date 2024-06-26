// 장바구니 아이템 위젯
import 'package:flutter/material.dart';
import 'package:flutter_list_example/presentation/cart_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';

class CartItemTile extends ConsumerWidget {
  final CartItem item;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemoved;
  final VoidCallback onToggled;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemoved,
    required this.onToggled,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ListTile(
            leading: Checkbox(
              value: item.isSelected,
              onChanged: (_) => onToggled(),
            ),
            title: Text(item.name),
            subtitle: Row(
              children: [
                NumberPicker(
                  value: item.quantity,
                  minValue: 1,
                  maxValue: 99,
                  onChanged: (value) => onQuantityChanged(value),
                ),
                Text('${(item.price * item.quantity).toStringAsFixed(2)}원'),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onRemoved,
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
