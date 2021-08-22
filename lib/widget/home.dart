
import 'package:final_dsc_4/provider/product_provider.dart';
import 'package:final_dsc_4/widget/favorite.dart';
import 'package:final_dsc_4/widget/shoppingCart.dart';
import 'package:final_dsc_4/widget/view_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //int _selectedIndex = 0;
    List<Widget> _func = [View_Product(),Favorite(),ShoppingCart()];

    return Scaffold(
      //appBar: AppBar(),
      body:Consumer<ProductProvider>
        (builder: (context, pp, child) =>_func[pp.selectedIndex]),

      bottomNavigationBar:Consumer<ProductProvider>
        (builder: (context, pp, child) => BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Shopping',
            ),
          ],
          currentIndex: Provider.of<ProductProvider>(context,listen: false).selectedIndex,
          selectedItemColor: Colors.purple[300],
          onTap:(value) {
            Provider.of<ProductProvider>(context, listen: false)
                .selectedItem(value);
            print(pp.selectedIndex);
          }
      ),
      ),
    );
  }
}
