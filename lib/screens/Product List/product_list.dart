import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:structure_code/const/mycolor.dart';
import 'package:structure_code/services/api.dart';
import 'package:structure_code/widgets/flushbar.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  //
  var product_list;
  //
  Stream productsStream() async* {
    try {
      var res = await Api.getproducts('9');
      if (res['code_status'] == true) {
        product_list = res['products'];
        print(product_list[0]['product_name']);
        FlushBar.flushbarmessagegreen(
            message: 'Show Products', context: context);
      }
    } catch (e) {
      print('Not Show Products');
      FlushBar.flushbarmessagered(
          message: 'Not Show Products', context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Product List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: mycolor.themecolor,
      ),
      body: StreamBuilder(
        stream: productsStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: product_list.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(product_list[index]['product_name'])],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
