import 'package:flutter/material.dart';
import 'package:restofatlem_14624/product.dart';
import 'package:restofatlem_14624/product_description.dart';
import 'package:restofatlem_14624/cart.dart'; // Pastikan mengimpor CartPage

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<Map<String, dynamic>> cartItems = [];
  final List<Product> products = [
    Product(
      name: 'Lumpia',
      description:
          'Lumpia adalah camilan yang terdiri dari lembaran tipis tepung gandum yang '
              'dijadikan sebagai pembungkus isian12. Isian lumpia umumnya berupa rebung, '
              'telur, sayuran segar, daging, atau makanan laut1.',
      price: 10000,
      imageUrl: 'assets/images/LUMPIA.jpg',
    ),
    Product(
      name: 'Esteh AJibb',
      description:
          '"Esteh Ajib" adalah es teh populer dengan istilah gaul di Indonesia dan punya dosen kami.',
      price: 20000,
      imageUrl: 'assets/images/esteh.jpg',
    ),
    Product(
      name: 'Dhokla',
      description:
          'A popular snack in Gujarat, dhokla is a delicious steamed cake prepared '
              'from fermented rice and chickpea flour. It is frequently served with '
              'chutneys and seasoned with mustard seeds, curry leaves, and green chilies.',
      price: 20000,
      imageUrl: 'assets/images/Dhokla.jpg',
    ),
    Product(
      name: 'Fafda',
      description:
          'A popular breakfast or snack option, fafda is a crunchy and savory '
              'snack made from gram flour (besan) and is typically served with green '
              'chutney and fried green chilies, especially during festivals like Dussehra.',
      price: 20000,
      imageUrl: 'assets/images/Fafda.jpg',
    ),
    Product(
      name: 'Misal Pav',
      description:
          'A spicy and flavorful Maharashtrian dish, misal pav consists of a '
              'sprouted bean curry (misal) topped with crunchy sev, onions, and coriander'
              'and served with pav (bread rolls).',
      price: 20000,
      imageUrl: 'assets/images/Misal Pav.jpg',
    ),
    Product(
      name: 'Puran Poli',
      description:
          'A traditional sweet flatbread from Maharashtra, puran poli is made with a sweet '
              'filling of cooked lentils (usually chana dal), jaggery, and spices, and is encased '
              'in a thin wheat flour dough. It is frequently consumed during festivals like Holi and Diwali',
      price: 20000,
      imageUrl: 'assets/images/Puran Poli.jpg',
    ),
    Product(
      name: 'Khandivi',
      description:
          'Made from gram flour and yogurt batter, khandvi is a well-liked snack in Gujarat. It is '
              'spread thinly, rolled, and seasoned with grated coconut, curry leaves, and mustard seeds. '
              'It’s a tasty and delicate nibble that frequently offered at celebrations.',
      price: 20000,
      imageUrl: 'assets/images/Khandivi.jpg',
    ),
    Product(
      name: 'Vada Pav',
      description:
          '" this street dish is quite popular in Maharashtra. It is made up of '
              'a soft bun (pav) layered with a spicy potato fritter (vada) and '
              'served with chutneys like green and tamarind chutney.',
      price: 20000,
      imageUrl: 'assets/images/VadaPav.jpg',
    ),
  ];

  List<int> quantities = List.filled(8, 0); // Initialize the quantities list with the same length as products



  void addToCart(Product product, int quantity) {
    for (var item in cartItems) {
      if (item['product'] == product) {
        item['quantity'] += quantity;
        return;
      }
    }
    cartItems.add({'product': product, 'quantity': quantity});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List',style: TextStyle(fontFamily: 'JetBrainsMono',),),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(
                product.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'JetBrainsMono',),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.description,
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[700],fontFamily: 'JetBrainsMono',),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Rp ${product.price}',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'JetBrainsMono',
                      fontWeight: FontWeight.w600,
                      color: Colors.green[700],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (quantities[index] > 0) quantities[index]--;
                          });
                        },
                      ),
                      Text(quantities[index].toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantities[index]++;
                          });
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (quantities[index] > 0) {
                        addToCart(product, quantities[index]);
                        setState(() {
                          quantities[index] = 0;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Added to cart')),
                        );
                      }
                    },
                    child: Text('Add to Cart',),
                  ),
                ],
              ),
              leading: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDescription(product: product),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Cart(cartItems: cartItems),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart, color: Colors.white),
              SizedBox(width: 8.0),
              Text(
                'Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'JetBrainsMono',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
