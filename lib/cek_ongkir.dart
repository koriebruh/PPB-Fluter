import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'detail_page.dart';
import 'models/model_kota.dart';

class CekOngkir extends StatefulWidget {
  const CekOngkir({Key? key}) : super(key: key);

  @override
  State<CekOngkir> createState() => _CekOngkirState();
}

class _CekOngkirState extends State<CekOngkir> {
  var strKey = "k6CFo88V3c9941ba881268dbWmB9FO6c"; // APIKEY RAJA ONKIR
  var strKotaAsal;
  var strKotaTujuan;
  var strBerat;
  var strEkspedisi;

  final List<ModelKota> staticCities = [
    ModelKota(cityId: "1", type: "Kota", cityName: "Jakarta"),
    ModelKota(cityId: "2", type: "Kota", cityName: "Surabaya"),
    ModelKota(cityId: "3", type: "Kota", cityName: "Bandung"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cek Ongkos Kirim"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownSearch<ModelKota>(
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Kota Asal",
                  hintText: "Pilih Kota Asal",
                ),
              ),
              popupProps: const PopupProps.menu(
                showSearchBox: true,
              ),
              onChanged: (value) {
                strKotaAsal = value?.cityId;
              },
              itemAsString: (item) => "${item.type} ${item.cityName}",
              asyncItems: (text) async {
                try {
                  var response = await http.get(Uri.parse("https://api.rajaongkir.com/starter/city?key=${strKey}"));
                  if (response.statusCode == 200) {
                    List allKota = (jsonDecode(response.body) as Map<String, dynamic>)['rajaongkir']['results'];
                    return ModelKota.fromJsonList(allKota);
                  } else {
                    throw Exception("Failed to load cities");
                  }
                } catch (e) {
                  return staticCities;
                }
              },
            ),
            const SizedBox(height: 20),
            DropdownSearch<ModelKota>(
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Kota Tujuan",
                  hintText: "Pilih Kota Tujuan",
                ),
              ),
              popupProps: const PopupProps.menu(
                showSearchBox: true,
              ),
              onChanged: (value) {
                strKotaTujuan = value?.cityId;
              },
              itemAsString: (item) => "${item.type} ${item.cityName}",
              asyncItems: (text) async {
                try {
                  var response = await http.get(Uri.parse("https://api.rajaongkir.com/starter/city?key=${strKey}"));
                  if (response.statusCode == 200) {
                    List allKota = (jsonDecode(response.body) as Map<String, dynamic>)['rajaongkir']['results'];
                    return ModelKota.fromJsonList(allKota);
                  } else {
                    throw Exception("Failed to load cities");
                  }
                } catch (e) {
                  return staticCities;
                }
              },
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Berat Paket (gram)",
                hintText: "Input Berat Paket",
              ),
              onChanged: (text) {
                strBerat = text;
              },
            ),
            const SizedBox(height: 20),
            DropdownSearch<String>(
              items: const ["JNE", "TIKI", "POS"],
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Kurir",
                  hintText: "Kurir",
                ),
              ),
              popupProps: PopupPropsMultiSelection.menu(
                showSelectedItems: true,
                disabledItemFn: (String s) => s.startsWith('I'),
              ),
              onChanged: (text) {
                strEkspedisi = text?.toLowerCase();
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        if (strKotaAsal == null ||
                            strKotaTujuan == null ||
                            strBerat == null ||
                            strEkspedisi == null) {
                          const snackBar =
                          SnackBar(content: Text("Ups, form tidak boleh kosong!"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                kota_asal: strKotaAsal,
                                kota_tujuan: strKotaTujuan,
                                berat: strBerat,
                                kurir: strEkspedisi,
                              ),
                            ),
                          );
                        }
                      },
                      child: const Center(
                        child: Text(
                          "Cek Ongkir",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
