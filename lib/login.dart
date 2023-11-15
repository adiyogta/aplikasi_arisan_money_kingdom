import 'package:aplikasi_arisan/page/admin/login.dart';
import 'package:aplikasi_arisan/page/owner/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      top: true,
      right: true,
      bottom: true,
      minimum: EdgeInsets.all(10.0),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color.fromRGBO(255, 243, 250, 1),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          floatingActionButton: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: Colors.white),
            child: TabBar(
                unselectedLabelColor: Colors.redAccent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.redAccent, Colors.pinkAccent]),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.redAccent),
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Owner",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                          )),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Admin",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                          )),
                    ),
                  ),
                ]),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: TabBarView(
              children: [LoginOwner(), LoginAdmin()],
            ),
          ),
        ),
      ),
    );
  }
}
