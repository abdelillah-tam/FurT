import 'package:bloc/bloc.dart';
import 'package:furt/services/product/product.dart';
import 'package:furt/services/product/product_provider.dart';
import 'package:furt/services/product/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductProvider provider;

  ProductCubit({required this.provider})
      : super(ProductStateFetching(List.empty(), isFetching: false));

  void fetchProducts(Category category) async {
    emit(ProductStateFetching(List.empty(),
        isFetching: true, fetchingText: 'Wait for getting ${category.name}'));
    final products = await provider.getProducts(category);
    emit(ProductStateFetching(products, isFetching: false));
  }

  void addToFavourite(String productId) async {
    final exist = await provider.addToFavourite(productId);
    emit(ProductStateExistInShopCart(
        productId: productId, exist: exist, isFetching: false));
  }

  void fetchProductsFromFavourite() async {
    emit(ProductStateFetching(List.empty(), isFetching: true));
    final products = await provider.getProductsInFavourite();
    emit(ProductStateFetching(products, isFetching: false));
  }

  void checkIfExistInFavourite(String productId) async {
    final exist = await provider.checkIfExistInFavourite(productId);
    emit(ProductStateExistInShopCart(
        productId: productId, exist: exist, isFetching: false));
  }

  void deleteFromFavourite(String productId) async{
    final exist = await provider.deleteFromFavourite(productId);
    emit(ProductStateExistInShopCart(exist: exist, productId: productId, isFetching: false));
  }
}
