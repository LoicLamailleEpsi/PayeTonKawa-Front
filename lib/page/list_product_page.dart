import 'package:flutter/material.dart';
import 'package:payetonkawa/entity/product.dart';
import 'package:payetonkawa/model/product_model.dart';
import 'package:payetonkawa/page/detail_product_page.dart';

class ListProductPage extends StatefulWidget {
  const ListProductPage({super.key});

  @override
  State<ListProductPage> createState() => _ListProductPageState();
}

class _ListProductPageState extends State<ListProductPage> {
  ProductModel _productModel = new ProductModel();
  List<Product> _product = [];

  bool _isBusy = false;

  @override
  void initState() {
    getProduct();
  }

  void busy(bool value){
    setState(() => _isBusy = value);
  }


  void getProduct() async {
    busy(true);
    var data = await _productModel.getAllProduct();
    if(data != null){
    setState(() {
      _product = data;
    });
    }
    
    busy(false);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des produits"),
      ),
      body: Column(
        children: [
          Visibility(
            visible: _isBusy,
            child: const CircularProgressIndicator()
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _product.length,
              itemBuilder:(context, index) => ProductItem(
                product: _product[index],
                onClick: () => openProduct(_product[index].id!),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  Product product;
  Function() onClick;

  ProductItem({super.key, required this.product, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name!),
      onTap: onClick,
    );
  }
}