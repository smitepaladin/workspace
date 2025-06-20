import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider_mongodb_crud_app/view/query_addresses.dart';
import 'package:provider_mongodb_crud_app/vm/address_provider.dart';
import 'package:provider_mongodb_crud_app/vm/image_provider.dart';

void main() {
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AddressModel()..fetchAddresses(),),
      ChangeNotifierProvider(create: (_) => ImageModel()),
    ],
    child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const QueryAddresses(),
    );
  }
}
