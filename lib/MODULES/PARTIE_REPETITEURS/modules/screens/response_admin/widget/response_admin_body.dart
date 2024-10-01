import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:repetiteur_mobile_app_definitive/core/constants/REPETITEURS/constants.dart';

class TeacherAdminResponseBody extends StatefulWidget {
  const TeacherAdminResponseBody({super.key});

  @override
  State<TeacherAdminResponseBody> createState() => _TeacherAdminResponseBodyState();
}

class _TeacherAdminResponseBodyState extends State<TeacherAdminResponseBody> {
  List<dynamic> messages = [];

  @override
  void initState() {
    super.initState();
    fetchMessagesData();
  }

  Future<void> fetchMessagesData() async {
    final teacherUserId = GetStorage().read("teacherUserId");

    final messagesUrl =
        'http://api-mon-encadreur.com/api/messages?user_id=$teacherUserId';

    final response = await http.get(Uri.parse(messagesUrl));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> responseData = jsonDecode(response.body)['data'];

      setState(() {
        messages = responseData;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  String formatDate(String isoDate) {
    // Analysez la date ISO 8601
    DateTime parsedDate = DateTime.parse(isoDate);

    // Formatez la date selon le format souhaité (YYYY-MM-DD)
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        backgroundColor: kPrimaryColor,
        title: const Text("Réponse de l'administrateur", style: TextStyle(color: kWhite),),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  columns: const [
                    /* DataColumn(label: Text('No.')), */
                    DataColumn(
                        label: Text(
                      "Date",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                    )),
                    DataColumn(
                        label: Text(
                      "Message",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                    )),
                    DataColumn(
                        label: Text(
                      "Réponse",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                    )),
                  ],
                  rows: messages.asMap().entries.map((entry) {
                    final int index = entry.key + 1;
                    final Map<String, dynamic> messagesList = entry.value;

                    final String messageDate = messagesList['created_at'] ?? '';
                    final String userMessage = messagesList['message'] ?? '';
                    final String adminResponse = messagesList['reponse_admin'] ?? '';

                    return DataRow(cells: [
                      /* DataCell(Text('$index')), */
                      DataCell(Text(formatDate(messageDate))),
                      DataCell(Text(userMessage, maxLines: 10, )),
                      DataCell(Text(adminResponse, maxLines: 10,)),
                    ]);
                  }).toList()),
            )
          ],
        ),
      ),
    );
  }
}
