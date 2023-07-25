import 'package:flutter/material.dart';
import 'package:payetonkawa/entity/product.dart';
import 'package:payetonkawa/model/product_model.dart';
import 'package:payetonkawa/page/detail_product_page.dart';

class ListProductView extends StatefulWidget {
  const ListProductView({super.key});

  @override
  State<ListProductView> createState() => _ListProductViewState();
}

class _ListProductViewState extends State<ListProductView> {

  final ProductModel _productModel = new ProductModel();
  late List<Product> _product;
  
  _ListProductViewState(){
    _product = [];
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<void> getProducts() async {
    var data = await _productModel.getAllProducts();
    if(data != null){
      setState(() {
        _product = data;
      });
    }
  }

  void openProduct(String id){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailProductPage(id: id),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => getProducts(),
      child: ListView.builder(
        itemCount: _product.length,
        itemBuilder:(context, index) => ProductItem(
          product: _product[index],
          onClick: () => openProduct(_product[index].id!),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ProductItem extends StatelessWidget {
  Product product;
  Function() onClick;

  ProductItem({super.key, required this.product, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name!),
      leading: Text(product.id!),
      onTap: onClick,
    );
  }
}