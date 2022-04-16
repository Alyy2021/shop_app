import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/shop_cubit/states.dart';
import 'package:udemy_flutter/models/shop_app/home_model.dart';
import 'package:udemy_flutter/modules/shop_app/cateogrise/Categories_Screen.dart';
import 'package:udemy_flutter/modules/shop_app/favorits/favourit_screen.dart';
import 'package:udemy_flutter/modules/shop_app/products/products_screen.dart';
import 'package:udemy_flutter/modules/shop_app/settings/Settings_Screen.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter/shared/network/remote/end_points.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit () :  super (ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0 ;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom (int index ){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;
  Map<int, bool> favorites = {};
  void getHomeDate () {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
        url: Home,
        token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);

      // printFullText(homeModel.data.banners[0].image);
      // print(homeModel.status);

      emit(ShopSuccessHomeDataState());
    }).catchError((error){

      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
}