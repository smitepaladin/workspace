import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider_mongodb_crud_app/model/address.dart';
import 'package:http/http.dart' as http;

class AddressModel with ChangeNotifier{
  final String baseUrl = "http://127.0.0.1:8000";
  List<Address> addresses = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchAddresses() async{
    isLoading = true;
    try{
      final res = await http.get(Uri.parse("$baseUrl/select"));
      final data = json.decode(utf8.decode(res.bodyBytes));
      addresses = (data['results'] as List)
                  .map((d) => Address.fromJson(d),)
                  .toList();
    }catch(e){
      error = e.toString();
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  Future<String> insertAddress(Address address) async{
    final res = await http.post(
      Uri.parse("$baseUrl/insert"),
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode(
        {
          "code" : address.code,
          "name" : address.name,
          "dept" : address.dept,
          "phone" : address.phone,
          "image" : address.image
        }
      )
    );
    final result = json.decode(utf8.decode(res.bodyBytes))['result'];
    await fetchAddresses();
    return result;
  }

  Future<String> updateAddress(Address address) async{
    final res = await http.put(
      Uri.parse("$baseUrl/update/${address.code}"),
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode(
        {
          "code" : address.code,
          "name" : address.name,
          "dept" : address.dept,
          "phone" : address.phone,
        }
      )
    );
    final result = json.decode(utf8.decode(res.bodyBytes))['result'];
    await fetchAddresses();
    return result;
  }

  Future<String> updateAddressAll(Address address) async{
    final res = await http.put(
      Uri.parse("$baseUrl/updateAll/${address.code}"),
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode(
        {
          "code" : address.code,
          "name" : address.name,
          "dept" : address.dept,
          "phone" : address.phone,
          "image" : address.image,
        }
      )
    );
    final result = json.decode(utf8.decode(res.bodyBytes))['result'];
    await fetchAddresses();
    return result;
  }

  Future<void> deleteAddress(String code) async{
    await http.delete(Uri.parse("$baseUrl/delete/$code"));
    await fetchAddresses();
  }


} // class