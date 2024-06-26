
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'cart_item.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {

  CartNotifier() : super([]);

  int get selectedItemCount {
    return state.where((item) => item.isSelected).length;
  }

  double get selectedItemsTotalPrice {
    return state.where((item) => item.isSelected).fold(
      0.0,
          (total, item) => total + (item.price * item.quantity),
    );
  }

  bool get hasSelectedItems {
    return state.any((item) => item.isSelected);
  }

  bool get allItemsSelected {
    return state.every((item) => item.isSelected);
  }

  void addToCart(CartItem item) {
    state = [...state, item];
  }

  void addMockData() {
    state = [
      ...state,
      const CartItem(id: 1, name: 'Product 1', price: 9.99),
      const CartItem(id: 2, name: 'Product 2', price: 14.99),
      const CartItem(id: 3, name: 'Product 3', price: 19.99),
      const CartItem(id: 4, name: 'Product 4', price: 24.99),
      const CartItem(id: 5, name: 'Product 5', price: 29.99),
    ];
  }

  void toggleItemSelection(int id) {
    state = [
      for (final item in state)
        if (item.id == id)
          CartItem(
            id: item.id,
            name: item.name,
            price: item.price,
            quantity: item.quantity,
            isSelected: !item.isSelected,
          )
        else
          item,
    ];
  }

  void toggleAllSelection() {
    final allSelected = state.every((item) => item.isSelected);
    state = [
      for (final item in state)
        CartItem(
          id: item.id,
          name: item.name,
          price: item.price,
          quantity: item.quantity,
          isSelected: !allSelected,
        ),
    ];
  }

  void updateQuantity(int id, int newQuantity) {
    state = [
      for (final item in state)
        if (item.id == id)
          CartItem(
            id: item.id,
            name: item.name,
            price: item.price,
            quantity: newQuantity,
            isSelected: item.isSelected,
          )
        else
          item,
    ];
  }

  void removeItem(int id) {
    state = state.where((item) => item.id != id).toList();
  }

  void removeItems(List<int> itemIds) {
    state = state.where((item) => !itemIds.contains(item.id)).toList();
  }

  void removeSelectedItems() {
    final selectedItemIds = state.where((item) => item.isSelected).map((item) => item.id).toList();
    removeItems(selectedItemIds);
  }
}
