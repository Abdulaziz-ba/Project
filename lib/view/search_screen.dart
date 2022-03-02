import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/list_of_products.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // Test Data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: BackButton(color: Colors.black),
        title: Text('List of Products', style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _searchBox(), // the search box

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      {}
                    },
                    icon: Icon(Icons.sort)),
                IconButton(
                    onPressed: () {
                      {}
                    },
                    icon: Icon(Icons.filter_alt_outlined)),
              ],
            ), // the sort and filter buttons
            ListOfProducts(),
          ],
        ),
      ),
    );
  }
}

final _formKey = GlobalKey<FormState>();
Widget _searchBox() {
  return Form(
    key: _formKey,
    child: Column(children: [
      Padding(
        padding: EdgeInsets.all(8),
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Enter search',
            border: OutlineInputBorder(),
            filled: false,
          ),
        ),
      ),
    ]),
  );
}
