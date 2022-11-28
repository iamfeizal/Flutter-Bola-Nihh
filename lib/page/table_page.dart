import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class TableScreen extends StatefulWidget {
  final String code;
  const TableScreen({Key? key, required this.code}) : super(key: key);

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  List? _table;

  getTable() async {
    try {
      http.Response response = await http.get(
          Uri.parse(
              "http://api.football-data.org/v4/competitions/${widget.code}/standings"),
          headers: {'X-Auth-Token': '5daf7e84fdd14e41a19763fc0f36f31f'});
      //86014f6025ae430dba078acc94bb2647
      String body = response.body;
      Map data = jsonDecode(body);
      List table = data['standings'][0]['table'];
      setState(() {
        _table = table;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget buildTable() {
    List<Widget> teams = [];
    for (var team in _table!) {
      teams.add(
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    team['position'].toString().length > 1
                        ? Text(team['position'].toString() + ' - ',
                            style: TextStyle(color: Colors.white))
                        : Text(" " + team['position'].toString() + ' - ',
                            style: TextStyle(color: Colors.white)),
                    Row(
                      children: [
                        SvgPicture.network(
                          team['team']['crest'],
                          height: 30,
                          width: 30,
                        ),
                        team['team']['shortName'].toString().length > 11
                            ? Text(
                                team['team']['shortName']
                                        .toString()
                                        .substring(0, 11) +
                                    '...',
                                style: TextStyle(color: Colors.white))
                            : Text(team['team']['shortName'].toString(),
                                style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(team['playedGames'].toString(),
                        style: TextStyle(color: Colors.white)),
                    Text(team['won'].toString(),
                        style: TextStyle(color: Colors.white)),
                    Text(team['draw'].toString(),
                        style: TextStyle(color: Colors.white)),
                    Text(team['lost'].toString(),
                        style: TextStyle(color: Colors.white)),
                    Text(team['goalDifference'].toString(),
                        style: TextStyle(color: Colors.white)),
                    Text(team['points'].toString(),
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      children: teams,
    );
  }

  @override
  void initState() {
    super.initState();
    getTable();
  }

  @override
  Widget build(BuildContext context) {
    return _table == null
        ? Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFFe70066),
                ),
              ),
            ),
          )
        : Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  const Color(0xff633a88),
                  const Color(0xffd73b53),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )),
              child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                'Pos',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Club',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'PL',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                'W',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                'D',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                'L',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                'GD',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                'Pts',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildTable(),
                ],
              ),
            ),
          );
  }
}
