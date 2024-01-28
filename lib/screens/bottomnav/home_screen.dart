// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_node_store/models/product_model.dart';
import 'package:flutter_node_store/services/api_service.dart';
import 'package:flutter_node_store/widgets/product_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isGridView = true;

  void _toggleView() {
    setState(() {
      _isGridView = !_isGridView;
    });
  }

  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: _toggleView,
            icon: Icon(_isGridView ? Icons.list_outlined : Icons.grid_view)),
        title: const Text('สินค้า'),
        actions: [
          IconButton(
              onPressed: () {
                //
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: _apiService.getProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("เกิดข้อผิดพลาด โปรดลองใหม่อีกครั้ง"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<ProductModel> products = snapshot.data;
          return _isGridView ? _gridView(products) : _listView(products);
        },
      ),
    );
  }

  Widget _gridView(List<ProductModel> products) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2 // จำนวนคอลัมน์
          ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ProductItem(
            isGrid: true,
            product: products[index],
            onTap: () {},
          ),
        );
      },
    );
  }

  Widget _listView(List<ProductModel> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
          child: SizedBox(
            height: 350,
            child: ProductItem(
              product: products[index],
              onTap: () {},
            ),
          ),
        );
      },
    );
  }
}
