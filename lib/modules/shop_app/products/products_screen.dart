import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/shop_cubit/cubit.dart';
import 'package:udemy_flutter/layout/shop_app/shop_cubit/states.dart';
import 'package:udemy_flutter/models/shop_app/home_model.dart';

class ProductsScreen extends StatelessWidget {
//  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null,
          builder: (context) => builderWidget(ShopCubit.get(context).homeModel),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget builderWidget(HomeModel model) => SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.58,
                children: List.generate(
                  model.data.products.length,
                  (index) => buildGridProduct(model.data.products[index]),
                ),
              ),
            ),
          ],
        ),
      );

  // ignore: missing_return
  Widget buildGridProduct(ProductModel model) {
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: NetworkImage(model.image),
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
        Text(
          model.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
