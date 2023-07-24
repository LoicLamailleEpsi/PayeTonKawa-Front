import 'package:flutter/material.dart';

class DetailProductPage extends StatefulWidget {
  String id;

  DetailProductPage({super.key, required this.id});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fiche produit n°${widget.id}"),
      ),
    );
  }
}