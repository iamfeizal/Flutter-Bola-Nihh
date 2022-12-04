import 'dart:convert';
import 'package:final_project_api/page/team_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  void initState() {
    super.initState();
    getTable();
  }

  Widget buildTable() {
    List<Widget> teams = [];
    for (var team in _table!) {
      bool containPNG = false;
      String crestURL = team['team']['crest'];
      containPNG = crestURL.contains('.png');
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
                            style: GoogleFonts.montserrat(color: Colors.white))
                        : Text(" " + team['position'].toString() + ' - ',
                            style: GoogleFonts.montserrat(color: Colors.white)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeamScreen(
                                  teamName: team['team']['name'],
                                  teamId: team['team']['id']),
                            ));
                        //print(_table.team.id);
                      },
                      child: Row(
                        children: [
                          containPNG
                              ? SizedBox(
                                  child: Image.network(team['team']['crest']),
                                  height: 30,
                                  width: 30,
                                )
                              : SizedBox(
                                  child:
                                      SvgPicture.network(team['team']['crest']),
                                  height: 30,
                                  width: 30,
                                ),
                          team['team']['shortName'].toString().length > 11
                              ? Text(
                                  team['team']['shortName']
                                          .toString()
                                          .substring(0, 11) +
                                      '...',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white))
                              : Text(team['team']['shortName'].toString(),
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(team['playedGames'].toString(),
                        style: GoogleFonts.montserrat(color: Colors.white)),
                    Text(team['won'].toString(),
                        style: GoogleFonts.montserrat(color: Colors.white)),
                    Text(team['draw'].toString(),
                        style: GoogleFonts.montserrat(color: Colors.white)),
                    Text(team['lost'].toString(),
                        style: GoogleFonts.montserrat(color: Colors.white)),
                    Text(team['goalDifference'].toString(),
                        style: GoogleFonts.montserrat(color: Colors.white)),
                    Text(team['points'].toString(),
                        style: GoogleFonts.montserrat(color: Colors.white)),
                    SizedBox(
                      width: 40,
                      child: Text(
                        team['form'].toString(),
                        style: GoogleFonts.montserrat(
                            fontSize: 10, color: Colors.white),
                      ),
                    ),
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
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Club',
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
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
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'W',
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'D',
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'L',
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'GD',
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Pts',
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 40,
                                child: Text(
                                  'Last',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
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
