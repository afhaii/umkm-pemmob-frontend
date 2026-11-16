import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/umkm_controller.dart';
import '../models/umkm_model.dart';
import 'umkm_form_page.dart';

class UmkmView extends GetView<UmkmController> {
  const UmkmView({super.key});

  static const Color primary = Color(0xFF176B55);
  static const Color background = Color(0xFFF6F8F6);
  static const Color darkGreen = Color(0xFF183A30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      body: SafeArea(
        child: Obx(() {
          final items = controller.filteredUmkm;

          return RefreshIndicator(
            color: primary,
            onRefresh: controller.fetchUmkm,

            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),

              children: [
                // =====================================
                // HEADER
                // =====================================

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.storefront_rounded,
                        color: Colors.white,
                        size: 27,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Banua UMKM',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: darkGreen,
                            ),
                          ),

                          Text(
                            'Temukan usaha lokal terbaik',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.location_on, color: primary, size: 15),

                          SizedBox(width: 4),

                          Text(
                            'Banua',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // =====================================
                // HERO SECTION
                // =====================================
                Container(
                  padding: const EdgeInsets.all(23),

                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF145C45), Color(0xFF268365)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),

                    borderRadius: BorderRadius.circular(24),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'DUKUNG USAHA LOKAL',
                        style: TextStyle(
                          color: Color(0xFFCCE7D9),
                          fontSize: 11,
                          letterSpacing: 1.3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        'Jelajahi Potensi\nUMKM Banua!',
                        style: TextStyle(
                          fontSize: 27,
                          height: 1.25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        'Kenali berbagai usaha lokal dan temukan '
                        'produk menarik dari masyarakat Banua.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 22),

                      Row(
                        children: [
                          const Icon(
                            Icons.store_rounded,
                            color: Colors.white,
                            size: 19,
                          ),

                          const SizedBox(width: 8),

                          Text(
                            '${controller.umkmList.length} UMKM terdaftar',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 27),

                // =====================================
                // SECTION TITLE
                // =====================================
                const Text(
                  'Temukan UMKM',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Cari usaha lokal berdasarkan nama atau lokasi.',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),

                const SizedBox(height: 17),

                // =====================================
                // SEARCH BAR
                // =====================================
                TextField(
                  onChanged: controller.searchUmkm,

                  decoration: InputDecoration(
                    hintText: 'Cari nama UMKM...',
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: primary,
                    ),

                    filled: true,
                    fillColor: Colors.white,

                    contentPadding: const EdgeInsets.symmetric(vertical: 15),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade100),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: primary, width: 1.3),
                    ),
                  ),
                ),

                const SizedBox(height: 23),

                // =====================================
                // CATEGORY FILTER
                // =====================================
                const Text(
                  'Kategori',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: darkGreen,
                  ),
                ),

                const SizedBox(height: 12),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,

                  children: controller.categories.map((category) {
                    final selected =
                        controller.selectedCategory.value == category;

                    return ChoiceChip(
                      label: Text(category),

                      selected: selected,
                      showCheckmark: false,

                      selectedColor: primary,
                      backgroundColor: Colors.white,

                      labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),

                        side: BorderSide(
                          color: selected ? primary : Colors.grey.shade200,
                        ),
                      ),

                      onSelected: (_) {
                        controller.filterCategory(category);
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 25),

                // =====================================
                // UMKM LIST HEADER
                // =====================================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Daftar UMKM',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                    ),

                    Text(
                      '${items.length} ditemukan',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // =====================================
                // LOADING STATE
                // =====================================
                if (controller.isLoading.value && items.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(35),

                    child: Center(
                      child: CircularProgressIndicator(color: primary),
                    ),
                  )
                // =====================================
                // ERROR STATE
                // =====================================
                else if (controller.errorMessage.value.isNotEmpty &&
                    items.isEmpty)
                  _buildError()
                // =====================================
                // EMPTY STATE
                // =====================================
                else if (items.isEmpty)
                  _buildEmpty()
                // =====================================
                // UMKM DATA
                // =====================================
                else
                  ...items.map((item) => _UmkmCard(item: item)),
              ],
            ),
          );
        }),
      ),

      // =====================================
      // FLOATING ACTION BUTTON
      // =====================================
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => const UmkmFormPage());
        },

        backgroundColor: primary,
        foregroundColor: Colors.white,

        elevation: 4,

        icon: const Icon(Icons.add),
        label: const Text(
          'Tambah UMKM',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // =====================================
  // ERROR WIDGET
  // =====================================

  Widget _buildError() {
    return Container(
      padding: const EdgeInsets.all(25),

      child: Column(
        children: [
          const Icon(Icons.wifi_off_rounded, size: 45, color: Colors.redAccent),

          const SizedBox(height: 12),

          const Text(
            'Gagal mengambil data',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Text(
            controller.errorMessage.value,
            textAlign: TextAlign.center,

            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),

          const SizedBox(height: 15),

          ElevatedButton(
            onPressed: controller.fetchUmkm,

            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }

  // =====================================
  // EMPTY WIDGET
  // =====================================

  Widget _buildEmpty() {
    return Container(
      padding: const EdgeInsets.all(30),

      child: const Column(
        children: [
          Icon(
            Icons.store_mall_directory_outlined,
            size: 50,
            color: Colors.grey,
          ),

          SizedBox(height: 12),

          Text(
            'Belum ada UMKM ditemukan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 5),

          Text(
            'Coba gunakan kata kunci atau kategori lain.',
            textAlign: TextAlign.center,

            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// ==================================================
// UMKM CARD
// ==================================================

class _UmkmCard extends StatelessWidget {
  final Umkm item;

  const _UmkmCard({required this.item});

  static const Color primary = Color(0xFF176B55);

  // Icon berdasarkan kategori
  IconData get categoryIcon {
    final category = (item.kategori ?? '').toLowerCase();

    if (category.contains('kuliner') || category.contains('makanan')) {
      return Icons.restaurant_rounded;
    }

    if (category.contains('kerajinan')) {
      return Icons.brush_rounded;
    }

    if (category.contains('fashion')) {
      return Icons.checkroom_rounded;
    }

    if (category.contains('jasa')) {
      return Icons.handyman_rounded;
    }

    return Icons.storefront_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: Colors.grey.shade100),
      ),

      child: Column(
        children: [
          // =====================================
          // CARD HEADER
          // =====================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,

                decoration: BoxDecoration(
                  color: const Color(0xFFE7F3ED),
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Icon(categoryIcon, color: primary, size: 26),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.namaUmkm,

                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF183A30),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      item.kategori ?? 'Umum',

                      style: const TextStyle(
                        fontSize: 11,
                        color: primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                '#${item.id ?? '-'}',

                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Divider(color: Colors.grey.shade100, height: 1),

          const SizedBox(height: 13),

          // =====================================
          // OWNER INFORMATION
          // =====================================
          _buildInfoRow(
            icon: Icons.person_outline,
            value: item.pemilik ?? 'Pemilik belum tersedia',
          ),

          const SizedBox(height: 9),

          // =====================================
          // ADDRESS INFORMATION
          // =====================================
          _buildInfoRow(
            icon: Icons.location_on_outlined,
            value: item.alamat ?? 'Alamat belum tersedia',
          ),

          // =====================================
          // CONTACT INFORMATION
          // =====================================
          if (item.kontak != null && item.kontak!.isNotEmpty) ...[
            const SizedBox(height: 9),

            _buildInfoRow(icon: Icons.phone_outlined, value: item.kontak!),
          ],

          const SizedBox(height: 15),

          Divider(color: Colors.grey.shade100, height: 1),

          const SizedBox(height: 8),

          // =====================================
          // EDIT AND DELETE BUTTONS
          // =====================================
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  Get.to(() => UmkmFormPage(umkm: item));
                },

                icon: const Icon(Icons.edit_outlined, size: 17),

                label: const Text('Edit'),

                style: TextButton.styleFrom(foregroundColor: primary),
              ),

              const SizedBox(width: 5),

              TextButton.icon(
                onPressed: item.id == null ? null : _confirmDelete,

                icon: const Icon(Icons.delete_outline, size: 17),

                label: const Text('Hapus'),

                style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =====================================
  // INFORMATION ROW
  // =====================================

  Widget _buildInfoRow({required IconData icon, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.grey),

        const SizedBox(width: 7),

        Expanded(
          child: Text(
            value,

            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ),
      ],
    );
  }

  // =====================================
  // DELETE CONFIRMATION
  // =====================================

  void _confirmDelete() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

        title: const Text(
          'Hapus UMKM?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        content: Text('Apakah kamu yakin ingin menghapus ${item.namaUmkm}?'),

        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },

            child: const Text('Batal'),
          ),

          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),

            onPressed: () async {
              Get.back();

              await Get.find<UmkmController>().deleteUmkm(item.id!);
            },

            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}
