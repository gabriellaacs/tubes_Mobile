import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_example/auth/auth_gate.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
   String nama = '';
  // String alamat = '';
  String nomor = '';
  String aidi = '';
  @override
  void initState() {
    super.initState();
    getUserUID();
    getUserName();
  }

  void getUserUID() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    setState(() {
      aidi = uid;
    });
    print(aidi);
  }

  void getUserName() {
    final docRef = FirebaseFirestore.instance.collection('users').doc(aidi);

    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          nama = data['name'];
          // alamat = data['address'];
          nomor = data['phoneNumber'];
        });
        // print(data['name']);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 50.0, left: 8, right: 8, bottom: 25),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.start, // Menggunakan mainAxisAlignment start
          crossAxisAlignment: CrossAxisAlignment
              .start, // Untuk memulai tata letak dari kiri ke kanan
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                    width:
                        10), // Memberikan sedikit ruang antara IconButton dan teks berikutnya
                Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Untuk sejajar dengan teks "Halo Zumar"
                  children: [
                    Text(
                      "Hello $nama",
                      style: GoogleFonts.poppins(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Welcome back to your profile',
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: Colors.grey), // Teks kecil
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Address', // Teks kecil pertama
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left:
                                    BorderSide(width: 2.0, color: Colors.black),
                                right:
                                    BorderSide(width: 2.0, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Phone Number', // Teks kecil kedua
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                right:
                                    BorderSide(width: 2.0, color: Colors.black),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                nomor,
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 60),
            Text(
              'Recommended Places', // Teks yang Anda ingin bold
              style: TextStyle(
                fontSize:
                    20, // Anda bisa sesuaikan ukuran font sesuai keinginan
                fontWeight:
                    FontWeight.bold, // Ini akan membuat teks menjadi bold
              ),
            ),
            const SizedBox(height: 20),
            // Memastikan ada sedikit ruang sebelum tombol

// Spacer untuk menempatkan tombol di tengah vertikal
            // Spacer(),
            SizedBox(
              height: 40,
            ),
            Center(
              // Menempatkan tombol di tengah vertikal
              child: ElevatedButton(
                onPressed: () async {
                  // Aksi untuk tombol sign up
                  if (!mounted) return;
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthGate(),));
                },
                child: Text(
                  'Log Out',
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  backgroundColor: Color.fromRGBO(240, 240, 240, 1),
                  foregroundColor: const Color.fromRGBO(255, 159, 90, 1),
                  minimumSize: Size(320, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
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