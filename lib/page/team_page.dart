import 'dart:ffi';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class TeamScreen extends StatefulWidget {
  final String teamName;
  final int teamId;
  TeamScreen({Key? key, required this.teamName, required this.teamId})
      : super(key: key);

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  String? _teamName;
  String? _website;
  String? _address;
  String? _crestURL;
  String? _stadium;
  bool _hasBeenPressed = false;
  bool containPNG = false;

  getTeamDetails() async {
    try {
      http.Response response = await http.get(
          Uri.parse("https://api.football-data.org/v4/teams/${widget.teamId}"),
          headers: {'X-Auth-Token': '5daf7e84fdd14e41a19763fc0f36f31f'});
      String body = response.body;
      Map data = jsonDecode(body);
      _teamName = data['name'];
      _crestURL = data['crest'];
      _address = data['address'];
      _website = data['website'];
      _stadium = data['venue'];
      containPNG = _crestURL!.contains('.png');
      setState(() {});
    } catch (e) {
      return print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getTeamDetails();
  }

  @override
  Widget build(BuildContext context) {
    if (_teamName == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Team Details'),
          centerTitle: true,
          backgroundColor: Color(0xff633a88),
          elevation: 50.0,
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFFe70066),
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Team Details', style: GoogleFonts.montserrat()),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _hasBeenPressed = !_hasBeenPressed;
                });
              },
              icon: _hasBeenPressed
                  ? Icon(
                      Icons.bookmark_added,
                      color: Colors.green,
                    )
                  : Icon(Icons.bookmark_add_outlined),
            )
          ],
          centerTitle: true,
          backgroundColor: Color(0xff633a88),
          elevation: 50.0,
        ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('$_teamName',
                    style: GoogleFonts.montserrat(
                        fontSize: 30, color: Colors.white),
                    textAlign: TextAlign.center),
                containPNG
                    ? SizedBox(child: Image.network('$_crestURL'), height: 150)
                    : SizedBox(
                        child: SvgPicture.network('$_crestURL'), height: 150),
                Text('$_stadium',
                    style: GoogleFonts.montserrat(
                        fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center),
                Text('$_address',
                    style: GoogleFonts.montserrat(
                        fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center),
                Text('$_website',
                    style: GoogleFonts.montserrat(
                        fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center),
                SizedBox(height: 10.0),
              ],
            )),
      );
    }
  }
}
