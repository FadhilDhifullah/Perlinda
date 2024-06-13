import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: DataDiri(),
  ));
}

class DataDiri extends StatefulWidget {
  const DataDiri({Key? key}) : super(key: key);

  @override
  State<DataDiri> createState() => _DataDiriState();
}

class _DataDiriState extends State<DataDiri> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _tempatLahirController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _alamatLengkapController = TextEditingController();
  String? _jenisKelaminValue;
  String? _statusPernikahanValue;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('dataDiri').doc(user.uid).get();
      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          _nikController.text = data['nik'] ?? '';
          _jenisKelaminValue = data['jenis_kelamin'];
          _tempatLahirController.text = data['tempat_lahir'] ?? '';
          _tanggalLahirController.text = data['tanggal_lahir'] ?? '';
          _alamatLengkapController.text = data['alamat_lengkap'] ?? '';
          _statusPernikahanValue = data['status_pernikahan'];
        });
      }
    }
  }

  @override
  void dispose() {
    _nikController.dispose();
    _tempatLahirController.dispose();
    _tanggalLahirController.dispose();
    _alamatLengkapController.dispose();
    super.dispose();
  }

  Future<void> _saveData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('dataDiri').doc(user.uid).set({
          'nik': _nikController.text,
          'jenis_kelamin': _jenisKelaminValue,
          'tempat_lahir': _tempatLahirController.text,
          'tanggal_lahir': _tanggalLahirController.text,
          'alamat_lengkap': _alamatLengkapController.text,
          'status_pernikahan': _statusPernikahanValue,
          'user_id': user.uid,
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
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _tanggalLahirController.text = "${picked.toLocal()}".split(' ')[0];
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
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTextFormField('NIK', _nikController, 'Masukkan NIK'),
              SizedBox(height: 16.0),

              _buildDropdownFormField('Jenis Kelamin', _jenisKelaminValue, ['Laki-laki', 'Perempuan'], 'Pilih Jenis Kelamin'),
              SizedBox(height: 16.0),

              _buildTextFormField('Tempat Lahir', _tempatLahirController, 'Masukkan Tempat Lahir'),
              SizedBox(height: 16.0),

              _buildDateFormField('Tanggal Lahir', _tanggalLahirController, 'Pilih Tanggal Lahir'),
              SizedBox(height: 16.0),

              _buildTextFormField('Alamat Lengkap', _alamatLengkapController, 'Masukkan Alamat Lengkap'),
              SizedBox(height: 16.0),

              _buildDropdownFormField('Status Pernikahan', _statusPernikahanValue, ['Belum Menikah', 'Menikah'], 'Pilih Status Pernikahan'),
              SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    await _saveData();
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

  Widget _buildTextFormField(String labelText, TextEditingController controller, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 4.0),
        Container(
          color: Color(0xFFC1D9F1),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color(0xFFC1D9F1),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan $labelText';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownFormField(String labelText, String? value, List<String> items, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 4.0),
        Container(
          color: Color(0xFFC1D9F1),
          child: DropdownButtonFormField<String>(
            value: value,
            hint: Text(hintText),
            onChanged: (selectedValue) {
              setState(() {
                if (labelText == 'Jenis Kelamin') {
                  _jenisKelaminValue = selectedValue;
                } else if (labelText == 'Status Pernikahan') {
                  _statusPernikahanValue = selectedValue;
                }
              });
            },
            items: items.map<DropdownMenuItem<String>>((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color(0xFFC1D9F1),
            ),
            validator: (selectedValue) {
              if (selectedValue == null || selectedValue.isEmpty) {
                return 'Pilih $labelText';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDateFormField(String labelText, TextEditingController controller, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 4.0),
        Container(
          color: Color(0xFFC1D9F1),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color(0xFFC1D9F1),
            ),
            readOnly: true,
            onTap: () => _selectDate(context),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Pilih $labelText';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
