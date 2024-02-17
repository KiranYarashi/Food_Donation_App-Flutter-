import "package:flutter/material.dart";
import 'package:shopping_app/global_variables.dart';
import 'package:shopping_app/product_card.dart';
import 'package:shopping_app/product_detailes_page.dart';

class product_list extends StatefulWidget {
  const product_list({super.key});

  @override
  State<product_list> createState() => _product_listState();
}

class _product_listState extends State<product_list> {
  @override
  Widget build(BuildContext context) {
    final List<String> defaultSearchValues = [
      'Joe Food',
      'Udupi Hotel',
      'Hotel Kamath',
      'Chi Foods'
    ];

    return SafeArea(
      //helps to make items below the notch and above the bottom-safe area
      child: Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text('Food Donation',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
              ),
              Expanded(
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    return defaultSearchValues.where((String option) {
                      return option
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  onSelected: (String selection) {
                    print('You just selected $selection');
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search), // Add this line
                        hintText: 'Search',
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          //
          Expanded(
            child: ListView.builder(
                itemCount: product.length,
                itemBuilder: (context, index) {
                  final products = product[index];
                  return GestureDetector(
                    onTap: () {
                      if (!(products['isAvaliable'] as bool)) {
                        return;
                      }

                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Product_detailes_page(product: products);
                      }));
                    },
                    child: Product_cart(
                      text: products['title'] as String,
                      price: products['price'] as String,
                      image: products['imageurl'] as String,
                      mapUrl: products['mapUrl'] as String,
                      count: products['count'] as int,
                      backgroundcolor: index.isEven
                          ? const Color.fromRGBO(216, 240, 253, 1)
                          : const Color.fromARGB(255, 243, 244, 244),
                      isAvaliable: products['isAvaliable'] as bool,
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
