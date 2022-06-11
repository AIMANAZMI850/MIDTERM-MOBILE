import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/subjects.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Subjects extends StatefulWidget {
  const Subjects({
    Key? key,
  }) : super(key: key);
  @override
  State<Subjects> createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  List<Subject> subjectlist = <Subject>[];
  String titlecenter = " ";
  var numofpage, curpage = 1;
  late double screenHeight, screenWidth, resWidth;

  @override
  void initState() {
    super.initState();
    _loadSubjects(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subjects List'),
      ),
      body: subjectlist.isEmpty
          ? Center(
              child: Text(titlecenter,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)))
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Subjects Available",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                    child: GestureDetector(
                        child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (1 / 1),
                  children: List.generate(
                    subjectlist.length,
                    (index) {
                      return InkWell(
                          splashColor: Colors.amber,
                          onTap: () => {},
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                children: [
                                  Flexible(
                                    flex: 5,
                                    child: CachedNetworkImage(
                                      imageUrl: Config.server +
                                          "/mytutor/assets/courses" +
                                          subjectlist[index]
                                              .subjectId
                                              .toString() +
                                          '.png',
                                      fit: BoxFit.cover,
                                      width: resWidth,
                                      placeholder: (context, url) =>
                                          const LinearProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 4,
                                    child: Column(
                                      children: [
                                        Text(
                                          subjectlist[index]
                                              .subjectName
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          subjectlist[index]
                                              .subjectRating
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          subjectlist[index]
                                              .subjectSessions
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text("RM " +
                                            double.parse(subjectlist[index]
                                                    .subjectPrice
                                                    .toString())
                                                .toStringAsFixed(2)),
                                      ],
                                    ),
                                  )
                                ],
                              )));
                    },
                  ),
                )))
              ],
            ),
    );
  }

  void _loadSubjects(int pageno) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(Uri.parse(Config.server + "/mytutor/Users/php/load_subjects.php"),
        body: {
          'pageno': pageno.toString(),
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      var jsondata = jsonDecode(response.body);

      print(jsondata);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numofpage = int.parse(jsondata['numofpage']);

        if (extractdata['subjects'] != null) {
          subjectlist = <Subject>[];
          extractdata['subjects'].forEach((v) {
            subjectlist.add(Subject.fromJson(v));
          });
          titlecenter = subjectlist.length.toString() + " Subjects Available";
        } else {
          titlecenter = "No Subjects Available";
          subjectlist.clear();
        }
        setState(() {});
      } else {
        //do something
        titlecenter = "No Subjects Available";
        subjectlist.clear();
        setState(() {});
      }
    });
  }
}
