import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'team_page.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks', style: GoogleFonts.montserrat()),
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
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users-bookmarks")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("bookmarks")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  DocumentSnapshot _documentSnapshot =
                      snapshot.data!.docs[index];
                  return Card(
                    elevation: 5,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeamScreen(
                                  teamName: _documentSnapshot['teamName'],
                                  teamId: _documentSnapshot['teamId']),
                            ));
                        //print(_table.team.id);
                      },
                      child: ListTile(
                        leading: _documentSnapshot['crestURL']
                                .toString()
                                .contains('.png')
                            ? SizedBox(
                                child: Image.network(
                                    _documentSnapshot['crestURL']),
                                width: 50,
                                height: 50)
                            : SizedBox(
                                child: SvgPicture.network(
                                    _documentSnapshot['crestURL']),
                                width: 50,
                                height: 50),
                        title: Container(
                          child: Text(
                            "${_documentSnapshot['teamName']}",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        subtitle: Text("${_documentSnapshot['stadium']}",
                            style: GoogleFonts.montserrat(fontSize: 12)),
                        trailing: GestureDetector(
                          child: Icon(
                            Icons.remove_circle_outline,
                            color: Color(0xffd73b53),
                          ),
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection("users-bookmarks")
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .collection("bookmarks")
                                .doc(_documentSnapshot.id)
                                .delete();
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFFe70066),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
