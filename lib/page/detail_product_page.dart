import 'package:flutter/material.dart';
import 'package:http/testing.dart';
import 'package:payetonkawa/entity/product.dart';
import 'package:payetonkawa/model/product_model.dart';

// ignore: must_be_immutable
class DetailProductPage extends StatefulWidget {
  String id;
  MockClient? mockClient;

  DetailProductPage({super.key, required this.id, this.mockClient});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  late ProductModel _productModel;
  bool _isBusy = false;

  Product? _product;

  _DetailProductPageState() {
    _productModel = ProductModel(mockClient: widget.mockClient);
  }

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  void getProduct() async {
    busy(true);
    var data = await _productModel.getProduct(widget.id);
    if (data != null) {
      setState(() {
        _product = data;
      });
    }
    busy(false);
  }

  void busy(bool value) {
    setState(() => _isBusy = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_product?.name ?? ""),
      ),
      body: Builder(builder: (context) {
        if (_isBusy) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Description",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(_product?.details?.description ?? "N/A"),
                      ],
                    ),
                  ),
                ),
                DetailInfo(
                    iconData: Icons.euro_outlined,
                    text: "PRIX : ${_product?.details?.price ?? "N/A"}"),
                DetailInfo(
                    iconData: Icons.color_lens_outlined,
                    text: "Couleur : ${_product?.details?.color ?? "N/A"}"),
                DetailInfo(
                    iconData: Icons.inventory_2_outlined,
                    text: "${_product?.stock ?? "N/A"} pièces"),
                const SizedBox(height: 15),
                Text(
                  "ID du produit : ${_product?.id}",
                  style: const TextStyle(
                      color: Colors.grey, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

// ignore: must_be_immutable
class DetailInfo extends StatelessWidget {
  String text;
  IconData iconData;

  DetailInfo({super.key, required this.text, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(40),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(iconData, color: Colors.white),
            ),
          ),
          const SizedBox(width: 15),
          Text(text),
        ],
      ),
    );
  }
}
