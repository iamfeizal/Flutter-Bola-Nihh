import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:matcher/matcher.dart';
import 'package:final_project_api/widgets/league_container.dart';
import 'package:final_project_api/page/table_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Standings', style: GoogleFonts.montserrat()),
          centerTitle: true,
          backgroundColor: Color(0xff633a88),
          bottom: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.white.withOpacity(0.3),
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child:
                      Text('Premiere League', style: GoogleFonts.montserrat()),
                ),
                Tab(
                  child:
                      Text('LaLiga Santander', style: GoogleFonts.montserrat()),
                ),
                Tab(
                  child: Text('Bundesliga', style: GoogleFonts.montserrat()),
                ),
                Tab(
                  child: Text('Serie A', style: GoogleFonts.montserrat()),
                ),
                Tab(
                  child: Text('Ligue 1', style: GoogleFonts.montserrat()),
                ),
                Tab(
                  child: Text('Liga Nos', style: GoogleFonts.montserrat()),
                )
              ]),
        ),
        body: Container(
          child: TabBarView(children: <Widget>[
            TableScreen(code: 'PL'),
            TableScreen(code: 'PD'),
            TableScreen(code: 'BL1'),
            TableScreen(code: 'SA'),
            TableScreen(code: 'FL1'),
            TableScreen(code: 'PPL'),
          ]),
        ),
      ),
    );
  }
}
