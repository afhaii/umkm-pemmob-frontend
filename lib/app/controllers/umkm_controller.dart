import 'package:get/get.dart';

import '../models/umkm_model.dart';
import '../services/umkm_service.dart';

class UmkmController extends GetxController {
  final UmkmService _service = UmkmService();

  final RxList<Umkm> umkmList = <Umkm>[].obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedCategory = 'Semua'.obs;

  final List<String> categories = [
    'Semua',
    'Kuliner',
    'Makanan',
    'Kerajinan',
    'Fashion',
    'Jasa',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchUmkm();
  }

  // GET
  Future<void> fetchUmkm() async {
    if (umkmList.isEmpty) {
      isLoading.value = true;
    }

    errorMessage.value = '';

    try {
      final result = await _service.getUmkmList();
      umkmList.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  // POST
  Future<bool> createUmkm(Umkm umkm) async {
    try {
      final result = await _service.createUmkm(umkm);

      Get.snackbar(
        'Berhasil',
        result['message'] ?? 'UMKM berhasil ditambahkan',
      );

      await fetchUmkm();
      return true;
    } catch (e) {
      Get.snackbar(
        'Gagal Menambahkan',
        e.toString().replaceFirst('Exception: ', ''),
      );

      return false;
    }
  }

  // PUT
  Future<bool> updateUmkm(int id, Umkm umkm) async {
    try {
      final result = await _service.updateUmkm(id, umkm);

      Get.snackbar('Berhasil', result['message'] ?? 'UMKM berhasil diperbarui');

      await fetchUmkm();
      return true;
    } catch (e) {
      Get.snackbar(
        'Gagal Memperbarui',
        e.toString().replaceFirst('Exception: ', ''),
      );

      return false;
    }
  }

  // DELETE
  Future<bool> deleteUmkm(int id) async {
    try {
      final result = await _service.deleteUmkm(id);

      Get.snackbar('Berhasil', result['message'] ?? 'UMKM berhasil dihapus');

      await fetchUmkm();
      return true;
    } catch (e) {
      Get.snackbar(
        'Gagal Menghapus',
        e.toString().replaceFirst('Exception: ', ''),
      );

      return false;
    }
  }

  // SEARCH
  void searchUmkm(String value) {
    searchQuery.value = value;
  }

  // FILTER KATEGORI
  void filterCategory(String category) {
    selectedCategory.value = category;
  }

  // DATA HASIL PENCARIAN DAN FILTER
  List<Umkm> get filteredUmkm {
    final query = searchQuery.value.toLowerCase().trim();
    final category = selectedCategory.value.toLowerCase();

    return umkmList.where((item) {
      final nama = item.namaUmkm.toLowerCase();
      final alamat = (item.alamat ?? '').toLowerCase();
      final kategori = (item.kategori ?? '').toLowerCase();

      final cocokPencarian =
          nama.contains(query) ||
          alamat.contains(query) ||
          kategori.contains(query);

      final cocokKategori = category == 'semua' || kategori.contains(category);

      return cocokPencarian && cocokKategori;
    }).toList();
  }
}
