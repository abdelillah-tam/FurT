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
}
