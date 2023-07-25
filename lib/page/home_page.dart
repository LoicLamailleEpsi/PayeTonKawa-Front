import 'package:flutter/material.dart';
import 'package:payetonkawa/page/home_view/ar_view.dart';
import 'package:payetonkawa/page/home_view/list_product_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _openPage = 0;
  String _titlePage = "Paye Ton Kawa";

  final List<Widget> _homeView = [const ListProductView(), const ArView()];


  void redirectLogin() {
    Navigator.of(context).popUntil(
      (route) => route.isFirst,
    );
  }

  void _changePage(int page){
    setState(() {
      _openPage = page;
      _titlePage = page == 0 ? "Paye Ton Kawa" : "Visualiseur RA";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titlePage),
        actions: [
          IconButton(
            onPressed: () => redirectLogin(),
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _openPage,
        onTap: (value) => _changePage(value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: "Produits",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_in_ar_outlined),
            label: "AR",
          )
        ]
      ),
      body: _homeView[_openPage],
    );
  }
}
