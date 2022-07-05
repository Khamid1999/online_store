import 'package:flutter/material.dart';
import 'package:online_store/data/models/product_model.dart';
import 'package:online_store/data/repositories/product_repository.dart';
import 'package:online_store/presentation/product_detail_page/product_detail_page.dart';
import 'package:online_store/presentation/theme/app_styles/app_colors.dart';
import 'package:online_store/presentation/theme/app_styles/app_styles.dart';
import 'package:online_store/presentation/widgets/custom_progress_indicator.dart';
import 'package:online_store/presentation/widgets/product_card.dart';

class CategoryProductsPage extends StatefulWidget {
  final String collectionName;
  final String categoryType;

  CategoryProductsPage(
      {required this.collectionName, required this.categoryType});

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.darkBlue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.white,
        title: Text(
          widget.categoryType,
          style: AppStyles.header,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Product>>(
        future: ProductRepository().getProductsList(widget.collectionName),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return CustomProgressIndicator();
          else
            return GridView.builder(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2),
              itemBuilder: (context, index) {
                return ProductCard(
                    imageUrl: snapshot.data!.elementAt(index).imageLink,
                    description: snapshot.data!.elementAt(index).description,
                    price: snapshot.data!.elementAt(index).price.toDouble(),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                              product: snapshot.data!.elementAt(index)),
                        ),
                      );
                    });
              },
            );
        },
      ),
    );
  }
}
