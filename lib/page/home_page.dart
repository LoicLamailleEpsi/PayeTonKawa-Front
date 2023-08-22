import 'package:flutter/material.dart';
import 'package:payetonkawa/entity/user.dart';
import 'package:payetonkawa/model/user_model.dart';
import 'package:payetonkawa/page/home_view/ar_view.dart';
import 'package:payetonkawa/page/home_view/list_product_view.dart';
import 'package:payetonkawa/page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserModel _userModel = UserModel();
  final List<Widget> _homeView = [const ListProductView(), const ArView()];

  int _openPage = 0;
  String _titlePage = "Paye Ton Kawa";
  User? _user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void disconnect() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      )
    );
    await getIt<SharedPreferences>().clear();
  }

  Future<void> getUser() async {
    var token = getIt<SharedPreferences>().getString(idUserPreferenceKey);
    if(token != null){
      var user = await _userModel.getUser(token);
      _user = user.data;
    }
    
    _user ??= User(username: "unknown user");
  }

  void _changePage(int page){
    setState(() {
      _openPage = page;
      _titlePage = page == 0 ? "Paye Ton Kawa" : "Visualiseur RA";
    });
  }

  Future<void> _showDialogProfil() async {
    await showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Profil revendeur"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Username : ${_user?.username}"),
            Text("Email : ${_user?.email}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text("Fermer"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: Text(_titlePage),
        actions: [
          IconButton(
            onPressed: () => _showDialogProfil(), 
            icon: const Icon(Icons.person)
          ),
          IconButton(
            onPressed: () => disconnect(),
            icon: const Icon(Icons.logout_rounded),
          ),
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
