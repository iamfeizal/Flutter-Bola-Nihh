import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'table_page.dart';

class StandingsPage extends StatefulWidget {
  const StandingsPage({super.key});

  @override
  State<StandingsPage> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Standings', style: GoogleFonts.montserrat()),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout_outlined),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
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
