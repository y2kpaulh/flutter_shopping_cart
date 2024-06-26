import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required int id,
    required String name,
    required double price,
    @Default(1) int quantity,
    @Default(false) bool isSelected,
  }) = _CartItem;
}
