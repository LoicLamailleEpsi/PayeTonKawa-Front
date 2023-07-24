import 'package:flutter/material.dart';
import 'package:payetonkawa/entity/product.dart';
import 'package:payetonkawa/model/product_model.dart';
import 'package:payetonkawa/page/ar_page.dart';
import 'package:payetonkawa/page/detail_product_page.dart';

class ListProductPage extends StatefulWidget {
  const ListProductPage({super.key});

  @override
  State<ListProductPage> createState() => _ListProductPageState();
}

class _ListProductPageState extends State<ListProductPage> {
  final ProductModel _productModel = new ProductModel();
  List<Product> _product = [];

  bool _isBusy = false;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void busy(bool value){
    setState(() => _isBusy = value);
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

  void openAR(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ArPage(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des produits"),
        actions: [
          TextButton.icon(
            onPressed: () => openAR(), 
            icon: Icon(Icons.add_box_rounded), 
            label: Text("AR")
          )
        ],
      ),
      body: Column(
        children: [
          Visibility(
            visible: _isBusy,
            child: const CircularProgressIndicator()
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => getProducts(),
              child: ListView.builder(
                itemCount: _product.length,
                itemBuilder:(context, index) => ProductItem(
                  product: _product[index],
                  onClick: () => openProduct(_product[index].id!),
                ),
              ),
            ),
          )
        ],
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