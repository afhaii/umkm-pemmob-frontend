import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/controllers/umkm_controller.dart';
import 'app/views/umkm_view.dart';

void main() {
  runApp(const BanuaUmkmApp());
}

class BanuaUmkmApp extends StatelessWidget {
  const BanuaUmkmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Banua UMKM',

      initialBinding: BindingsBuilder(() {
        Get.put(UmkmController());
      }),

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF176B55)),
        scaffoldBackgroundColor: const Color(0xFFF6F8F6),
      ),

      home: const UmkmView(),
    );
  }
}
