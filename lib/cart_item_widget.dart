// 장바구니 아이템 위젯
import 'package:flutter/material.dart';
import 'package:flutter_list_example/order_number_picker.dart';
import 'package:flutter_list_example/presentation/cart_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';

class CartItemWidget extends ConsumerWidget {
  final CartItem item;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemoved;
  final VoidCallback onToggled;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemoved,
    required this.onToggled,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Checkbox(
                value: item.isSelected,
                onChanged: (_) => onToggled(),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(
                          height: 40,
                          child: OrderNumberPicker(
                            maxValue: item.quantity,
                            onChanged: (value) {
                              onQuantityChanged(value);
                            },
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Text('${(item.price * item.quantity).toStringAsFixed(2)}원',
                          textAlign: TextAlign.start,
                          style: const TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),),
                      ],
                    )
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onRemoved,
              )
            ],
          )
      ),
    );
  }
}
