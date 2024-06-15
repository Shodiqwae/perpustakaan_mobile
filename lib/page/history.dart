import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Hisbae extends StatefulWidget {
  final int userId;

  Hisbae({required this.userId});

  @override
  _HisbaeState createState() => _HisbaeState();
}

class _HisbaeState extends State<Hisbae> {
  List<dynamic> userLoans = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserLoans();
  }

  Future<void> _fetchUserLoans() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8000/api/user-loans/${widget.userId}'));

    if (response.statusCode == 200) {
      setState(() {
        userLoans = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load user loans');
    }
  }

  Future<void> _cancelLoan(int loanId) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/cancel-loan'),
      body: jsonEncode({'loan_id': loanId}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berhasil membatalkan peminjaman'),
          duration: Duration(seconds: 2),
        ),
      );

      // Refresh the loans list after cancellation
      _fetchUserLoans();
    } else {
      throw Exception('Failed to cancel loan');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'History',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(93, 23, 235, 1),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : userLoans.isEmpty
                ? Center(
                    child: Text(
                      'Ayo Lakukan Peminjaman',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: userLoans.length,
                    itemBuilder: (context, index) {
                      final loan = userLoans[index];

                      return Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment(0.9, -0.9),
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    margin: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color: loan['status'] == 'pending'
                                          ? Colors.red
                                          : loan['status'] == 'dipinjam'
                                              ? Colors.orange
                                              : Colors.green,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Text(
                                      loan['status'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          'http://10.0.2.2:8000/storage/${loan['book']['image_book']}',
                                          width: 100,
                                          height: 150,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Image.asset(
                                              'images/bukua.png',
                                              width: 100,
                                              height: 150,
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                        height: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            loan['book']['title'],
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Borrow Date: ${loan['borrow_date']}',
                                          ),
                                          loan['status'] == 'dipinjam'
                                              ? Text(
                                                  'Return Date: ${loan['return_date']}',
                                                )
                                              : Text(
                                                  'Return Date: Menunggu approve',
                                                ),
                                          SizedBox(height: 16.0),
                                          if (loan['status'] == 'pending')
                                            SizedBox(
                                              width: 225,
                                              height: 30,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  _cancelLoan(loan['id']);
                                                },
                                                child: Text('Cancel'),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
