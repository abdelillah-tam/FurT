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

  void deleteFromFavourite(String productId) async {
    final exist = await provider.deleteFromFavourite(productId);
    emit(ProductStateExistInShopCart(
        exist: exist, productId: productId, isFetching: false));
  }

  void addToShopCart({required Product product, int quantity = 1}) async {
    final updatedProduct = await provider.addToShopCart(product, quantity);
    emit(
      ProductStateAddedToShopcart(
          added: updatedProduct != null ? true : false,
          isFetching: false,
          addedTextForAlert: updatedProduct != null
              ? 'Product has been added to your shop cart'
              : 'Something wrong!',
          updatedProduct: updatedProduct),
    );
  }

  void getProductsExistInShopCart() async {
    final listOfProducts = await provider.getProductsExistInShopCart();
    emit(ProductStateFetching(listOfProducts, isFetching: false));
  }

  void deleteFromShopCart(Product product) async {
    final exist = await provider.deleteFromShopCart(product);
    emit(
      ProductStateAddedToShopcart(
          added: exist,
          isFetching: false,
          productId: product.productId,
          addedTextForAlert: exist
              ? 'Product has been deleted from your shop cart'
              : 'Something wrong !'),
    );
  }

  void increaseQuantity(Product product) async {
    final updatedProduct = await provider.increaseQuantity(product);
    emit(
      ProductStateAddedToShopcart(
        added: updatedProduct != null ? true : false,
        isFetching: false,
        addedTextForAlert: '',
        updatedProduct: updatedProduct
      ),
    );
  }

  void decreaseQuantity(Product product) async {
    final updatedProduct = await provider.decreaseQuantity(product);
    emit(
      ProductStateAddedToShopcart(
        added: updatedProduct != null ? true : false,
        isFetching: false,
        addedTextForAlert: '',
        updatedProduct: updatedProduct,
      ),
    );
  }
}
