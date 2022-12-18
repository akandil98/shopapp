import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          //condition: ShopCubit.get(context).homeModel != null,
          condition: state is! ShopLoadingHomeDataState,
          builder: (context) =>
              productsBuilder(ShopCubit.get(context).homeModel!),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              items: model.data?.banners
                  ?.map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.72,
                children: List.generate(
                  model.data!.products!.length,
                  (index) => buildGridProduct(model.data!.products![index]),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(ProductModel model) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 200.0,
                  // fit: BoxFit.cover,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()!}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()!}',
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_border,
                            size: 12.0,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
