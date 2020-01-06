import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_album/models/student.dart';
import 'package:photo_album/pages/group_photos.dart';
import 'package:photo_album/pages/user_profile.dart';
import 'package:photo_album/repository/user_repository.dart';
import 'package:provider/provider.dart';
import 'all_students.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  var pages = <Widget>[AllStudents(), UserProfile()];

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserRepository>(context);
    /*var _students = Provider.of<List<Student>>(context);
    var width = MediaQuery.of(context).size.width;*/
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.greenAccent.shade100,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GroupPhoto()));
              },
              child: Icon(
                FontAwesomeIcons.users,
                color: Colors.white,
              ),
              backgroundColor: Colors.greenAccent,
            ),
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              child: Container(
                height: 55,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      iconSize: 30.0,
                      padding: EdgeInsets.only(left: 58.0, right: 58.0),
                      icon: Icon(FontAwesomeIcons.home),
                      onPressed: () {
                        setState(() {
                          _onItemTapped(0);
                          // _myPage.jumpToPage(0);
                        });
                      },
                    ),
                    IconButton(
                      iconSize: 30.0,
                      padding: EdgeInsets.only(right: 58.0, left: 58.0),
                      icon: Icon(FontAwesomeIcons.userAlt),
                      onPressed: () {
                        setState(() {
                          _onItemTapped(1);
                          //  _myPage.jumpToPage(1);
                        });
                      },
                    ),
                    /* IconButton(
                    iconSize: 30.0,
                    padding: EdgeInsets.only(left: 28.0),
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      setState(() {
                     //   _myPage.jumpToPage(2);
                      });
                    },
                  ),
                  IconButton(
                    iconSize: 30.0,
                    padding: EdgeInsets.only(right: 28.0),
                    icon: Icon(Icons.list),
                    onPressed: () {
                      setState(() {
                        //_myPage.jumpToPage(3);
                      });
                    },
                  )*/
                  ],
                ),
              ),
            ),
            /* BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("",style: TextStyle(fontSize: 0),)),
            BottomNavigationBarItem(icon: Icon(Icons.person),title: Text("",style: TextStyle(fontSize: 0)))
          ]),*/
            /* appBar: AppBar(
                leading: Container(),
                title: Text("Photo Album",
                    style: TextStyle(fontFamily: "Campton")),
                backgroundColor: Colors.white,
                elevation: 0.0),*/
            body: FutureProvider(
              builder: (context) => user.getProfile(),
              updateShouldNotify: (pstudent, cstudent){
                return cstudent!=pstudent;
              },
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: _pageChange,
                controller: _pageController,
                itemCount: pages.length,
                itemBuilder: (BuildContext context, int index) {
                  return pages.elementAt(_selectedIndex);
                },
              ),
            )));
  }

  void _onItemTapped(int index) {
    //bottomNavigationBar and PageView association
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 100), curve: Curves.ease);
  }

  void _pageChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget cardItem({Student student, width, int index}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Container(
        height: 120,
        width: double.infinity,
        child: Stack(children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
                width: width - 80,
                child: Card(
                  color: Colors.white,
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        student.name,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: "Campton"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        student.matricNumber,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: "Camptonlight"),
                      )
                    ],
                  ),
                )

                // decoration: BoxDecoration(
                //     color: Colors.blue.withOpacity(0.5),
                //     boxShadow: [
                //       BoxShadow(
                //           color: Colors.red,
                //           blurRadius: 5.0,
                //           offset: Offset(10.0, -10.0),
                //           spreadRadius: 2.0),
                //       BoxShadow(
                //           color: Colors.blue,
                //           blurRadius: 5.0,
                //           offset: Offset(10.0, -10.0),
                //           spreadRadius: 2.0)
                //     ],
                //     borderRadius: BorderRadius.circular(20.0)),
                ),
          ),
          Positioned(
            top: 10,
            left: -5,
            bottom: 10,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.shade100,
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 0,
            bottom: 10,
            child: Container(
              height: 85,
              width: 85,
              // decoration: BoxDecoration(shape: BoxShape.circle),
              /*  decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent,
                image: DecorationImage(
                    image: AssetImage("assets/images/bil.jpg"),
                    fit: BoxFit.cover),
              ), */
              child: Hero(
                tag: "profile_pic$index",
                child: CircleAvatar(
                  //  radius: 100,
                  //    backgroundImage: AssetImage("assets/images/bil.jpg"),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/bil.jpg",
                      width: 85,
                      height: 85,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Image.asset(
          "assets/images/bg.png",
          // "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          fit: BoxFit.cover,
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Text(
              "MySliverAppBar",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 4,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              elevation: 10,
              child: SizedBox(
                height: 75,
                width: MediaQuery.of(context).size.width / 2,
                child: FlutterLogo(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
