import 'package:flutter/material.dart';
import 'package:payetonkawa/entity/product.dart';
import 'package:payetonkawa/model/product_model.dart';

// ignore: must_be_immutable
class DetailProductPage extends StatefulWidget {
  String id;

  DetailProductPage({super.key, required this.id});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  final ProductModel _productModel = new ProductModel();
  bool _isBusy = false;

  Product? _product;

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  void getProduct() async {
    busy(true);
    var data = await _productModel.getProduct(widget.id);
    if(data != null){
      setState(() {
        _product = data;
      });
    }
    busy(false);
  }
  
  void busy(bool value){
    setState(() => _isBusy = value);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fiche produit n°${widget.id}"),
      ),
      body: Builder(
        builder: (context) {

          if(_isBusy){

            return const Center(
              child: CircularProgressIndicator(),
            );

          }else{

            return Column(
              children: [
                Text(_product!.details!.description!)
              ],
            );
            
          }
        }
      ),
    );
  }
}