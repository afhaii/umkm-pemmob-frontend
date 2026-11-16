import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/umkm_controller.dart';
import '../models/umkm_model.dart';

class UmkmFormPage extends StatefulWidget {
  final Umkm? umkm;

  const UmkmFormPage({super.key, this.umkm});

  @override
  State<UmkmFormPage> createState() => _UmkmFormPageState();
}

class _UmkmFormPageState extends State<UmkmFormPage> {
  static const Color primary = Color(0xFF176B55);

  final _formKey = GlobalKey<FormState>();
  final UmkmController controller = Get.find<UmkmController>();

  late TextEditingController namaC;
  late TextEditingController pemilikC;
  late TextEditingController alamatC;
  late TextEditingController kategoriC;
  late TextEditingController kontakC;

  bool isSubmitting = false;

  bool get isEdit => widget.umkm != null;

  @override
  void initState() {
    super.initState();

    namaC = TextEditingController(text: widget.umkm?.namaUmkm ?? '');

    pemilikC = TextEditingController(text: widget.umkm?.pemilik ?? '');

    alamatC = TextEditingController(text: widget.umkm?.alamat ?? '');

    kategoriC = TextEditingController(text: widget.umkm?.kategori ?? '');

    kontakC = TextEditingController(text: widget.umkm?.kontak ?? '');
  }

  @override
  void dispose() {
    namaC.dispose();
    pemilikC.dispose();
    alamatC.dispose();
    kategoriC.dispose();
    kontakC.dispose();

    super.dispose();
  }

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    final umkm = Umkm(
      id: widget.umkm?.id,
      namaUmkm: namaC.text.trim(),
      pemilik: pemilikC.text.trim(),
      alamat: alamatC.text.trim(),
      kategori: kategoriC.text.trim(),
      kontak: kontakC.text.trim(),
    );

    bool success;

    if (isEdit) {
      success = await controller.updateUmkm(widget.umkm!.id!, umkm);
    } else {
      success = await controller.createUmkm(umkm);
    }

    if (!mounted) return;

    setState(() {
      isSubmitting = false;
    });

    if (success) {
      Get.back();
    }
  }

  Widget buildInput({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController textController,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        const SizedBox(height: 9),
        TextFormField(
          controller: textController,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: primary, size: 20),
            filled: true,
            fillColor: const Color(0xFFF6F8F6),
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE9EEEA)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6),
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit UMKM' : 'Tambah UMKM',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF6F8F6),
        foregroundColor: const Color(0xFF183A30),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.storefront_rounded,
                      color: Colors.white,
                      size: 35,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      isEdit
                          ? 'Perbarui Informasi Usaha'
                          : 'Daftarkan UMKM Baru',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Lengkapi informasi usaha agar mudah dikenal.',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              buildInput(
                label: 'Nama UMKM *',
                hint: 'Contoh: Banua Coffee',
                icon: Icons.store,
                textController: namaC,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama UMKM wajib diisi';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 18),

              buildInput(
                label: 'Nama Pemilik',
                hint: 'Masukkan nama pemilik',
                icon: Icons.person_outline,
                textController: pemilikC,
              ),

              const SizedBox(height: 18),

              buildInput(
                label: 'Alamat',
                hint: 'Masukkan alamat usaha',
                icon: Icons.location_on_outlined,
                textController: alamatC,
                maxLines: 2,
              ),

              const SizedBox(height: 18),

              buildInput(
                label: 'Kategori',
                hint: 'Contoh: Kuliner, Kerajinan',
                icon: Icons.category_outlined,
                textController: kategoriC,
              ),

              const SizedBox(height: 18),

              buildInput(
                label: 'Nomor Kontak',
                hint: 'Masukkan nomor telepon',
                icon: Icons.phone_outlined,
                textController: kontakC,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isSubmitting ? null : submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: isSubmitting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          isEdit ? 'Simpan Perubahan' : 'Simpan UMKM',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
