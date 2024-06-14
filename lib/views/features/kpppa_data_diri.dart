import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class KPPPADataDiri extends StatefulWidget {
  const KPPPADataDiri({Key? key}) : super(key: key);

  @override
  State<KPPPADataDiri> createState() => _KPPPADataDiriState();
}

class _KPPPADataDiriState extends State<KPPPADataDiri> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _nikController = TextEditingController();
  String? jenisKelaminValue;
  final TextEditingController _tempatLahirController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _alamatLengkapController = TextEditingController();
  final TextEditingController _alamatDomisiliController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection('kpppaDataDiri').doc(user!.uid).get();
      if (userData.exists) {
        setState(() {
          _nikController.text = userData['nik'] ?? '';
          jenisKelaminValue = userData['jenis_kelamin'] ?? null;
          _tempatLahirController.text = userData['tempat_lahir'] ?? '';
          _tanggalLahirController.text = userData['tanggal_lahir'] ?? '';
          _alamatLengkapController.text = userData['alamat_ktp'] ?? '';
          _alamatDomisiliController.text = userData['alamat_domisili'] ?? '';
        });
      } else {
        setState(() {
          _nikController.text = 'Masukkan NIK';
          _tempatLahirController.text = 'Masukkan Tempat Lahir';
          _tanggalLahirController.text = 'Masukkan Tanggal Lahir';
          _alamatLengkapController.text = 'Masukkan Alamat Lengkap (Sesuai KTP)';
          _alamatDomisiliController.text = 'Masukkan Alamat Domisili';
        });
      }
    }
  }

  Future<void> _saveChanges() async {
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('kpppaDataDiri').doc(user!.uid).set({
          'nik': _nikController.text,
          'jenis_kelamin': jenisKelaminValue,
          'tempat_lahir': _tempatLahirController.text,
          'tanggal_lahir': _tanggalLahirController.text,
          'alamat_ktp': _alamatLengkapController.text,
          'alamat_domisili': _alamatDomisiliController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data berhasil disimpan')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan data: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User tidak ditemukan. Silakan login kembali.')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _tanggalLahirController.text = DateFormat('dd MMMM yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Data Diri',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF4682A9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTextFormField('NIK', _nikController, 'Masukkan NIK'),
              SizedBox(height: 16.0),
              _buildDropdownFormField('Jenis Kelamin', jenisKelaminValue, ['Laki-laki', 'Perempuan']),
              SizedBox(height: 16.0),
              _buildTextFormField('Tempat Lahir', _tempatLahirController, 'Masukkan Tempat Lahir'),
              SizedBox(height: 16.0),
              _buildDateFormField('Tanggal Lahir', _tanggalLahirController, 'Masukkan Tanggal Lahir'),
              SizedBox(height: 16.0),
              _buildTextFormField('Alamat Lengkap (Sesuai KTP)', _alamatLengkapController, 'Masukkan Alamat Lengkap (Sesuai KTP)'),
              SizedBox(height: 16.0),
              _buildTextFormField('Alamat Domisili', _alamatDomisiliController, 'Masukkan Alamat Domisili'),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _saveChanges();
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF4682A9)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String labelText, TextEditingController controller, String placeholder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.0),
        Container(
          color: Color(0xFFC1D9F1),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: placeholder,
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color(0xFFC1D9F1),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $labelText';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownFormField(String labelText, String? value, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.0),
        Container(
          color: Color(0xFFC1D9F1),
          child: DropdownButtonFormField<String>(
            value: value,
            onChanged: (selectedValue) {
              setState(() {
                jenisKelaminValue = selectedValue;
              });
            },
            items: items.map<DropdownMenuItem<String>>((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            decoration: InputDecoration(
              hintText: 'Pilih...',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color(0xFFC1D9F1),
            ),
            validator: (selectedValue) {
              if (selectedValue == null || selectedValue.isEmpty) {
                return 'Please select $labelText';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDateFormField(String labelText, TextEditingController controller, String placeholder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.0),
        Container(
          color: Color(0xFFC1D9F1),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: placeholder,
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color(0xFFC1D9F1),
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $labelText';
              }
              return null;
            },
            readOnly: true,
          ),
        ),
      ],
    );
  }
}

void main() => runApp(MaterialApp(
      home: KPPPADataDiri(),
    ));
ad