import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  final String? kota_asal;
  final String? kota_tujuan;
  final String? berat;
  final String? kurir;

  const DetailPage({super.key, this.kota_asal, this.kota_tujuan, this.berat, this.kurir});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List listData = [];
  var strKey = "k6CFo88V3c9941ba881268dbWmB9FO6c";

  final List<Map<String, dynamic>> staticCostData = [
    {
      'service': 'REG',
      'description': 'Regular Service',
      'cost': [
        {'value': 9000, 'etd': '2-3'}
      ],
    },
    {
      'service': 'YES',
      'description': 'Yakin Esok Sampai',
      'cost': [
        {'value': 15000, 'etd': '1'}
      ],
    },
    {
      'service': 'OKE',
      'description': 'Ongkos Kirim Ekonomis',
      'cost': [
        {'value': 7000, 'etd': '3-5'}
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      final response = await http.post(
        Uri.parse("https://api.rajaongkir.com/starter/cost"),
        body: {
          "key": strKey,
          "origin": widget.kota_asal,
          "destination": widget.kota_tujuan,
          "weight": widget.berat,
          "courier": widget.kurir
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          listData = data['rajaongkir']['results'][0]['costs'];
        });
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        listData = staticCostData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Ongkos Kirim ${widget.kurir?.toUpperCase()}"),
      ),
      body: listData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: listData.length,
        itemBuilder: (_, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            clipBehavior: Clip.antiAlias,
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            child: ListTile(
              title: Text("${listData[index]['service']}"),
              subtitle: Text("${listData[index]['description']}"),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Rp ${listData[index]['cost'][0]['value']}",
                    style: const TextStyle(fontSize: 20, color: Colors.red),
                  ),
                  const SizedBox(height: 3),
                  Text("${listData[index]['cost'][0]['etd']} Days"),
                ],
              ),
              onTap: () {
                // Kirim data ongkir dan produk ke halaman Checkout
                final List<Map<String, dynamic>> cartItems = [
                  {
                    'product': {
                      'name': "${listData[index]['service']}",
                      'price': listData[index]['cost'][0]['value'],
                    },
                    'quantity': 1,
                  },
                ];

                Navigator.pushNamed(
                  context,
                  '/checkout',
                  arguments: cartItems, // Kirim data ongkir ke Checkout
                );
              },
            ),
          );
        },
      ),
    );
  }
}
