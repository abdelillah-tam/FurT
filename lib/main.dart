import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furt/services/auth/auth_cubit.dart';
import 'package:furt/services/auth/auth_state.dart';
import 'package:furt/services/auth/firebase_auth_provider.dart';
import 'package:furt/services/product/firestore_product_provider.dart';
import 'package:furt/services/product/product_cubit.dart';
import 'package:furt/views/details_view.dart';
import 'package:furt/views/home/home_view.dart';
import 'package:furt/views/login_view.dart';
import 'package:furt/views/register_view.dart';

void main() {
  final AuthCubit _authCubit = AuthCubit(provider: FirebaseAuthProvider());
  final ProductCubit _productCubit = ProductCubit(
      provider: FirestoreProductProvider());
  WidgetsFlutterBinding.ensureInitialized();
  //debugPaintLayerBordersEnabled = true;
  runApp(MaterialApp(
    title: 'FurT',
    scrollBehavior: const ConstantScrollBehavior(),
    home: MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => _authCubit,
        ),
        BlocProvider<ProductCubit>(
          create: (context) => _productCubit,
        )
      ],
      child: const MainPage(),
    ),
    routes: {
      "/details": (context) =>
          BlocProvider.value(
            value: _productCubit,
            child: DetailsView(),
          ),
    },
  ));
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    context.read<AuthCubit>().initialize();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateRegisterState) {
          return const RegisterView();
        } else if (state is AuthStateLoggedIn) {
          return const MainView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class ConstantScrollBehavior extends ScrollBehavior {
  const ConstantScrollBehavior();

  @override
  Widget buildScrollbar(BuildContext context, Widget child,
      ScrollableDetails details) =>
      child;

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child,
      ScrollableDetails details) =>
      child;

  @override
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.macOS;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
