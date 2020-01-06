import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/models/student.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'details_page.dart';

class AllStudents extends StatefulWidget {
  @override
  _AllStudentsState createState() => _AllStudentsState();
}

class _AllStudentsState extends State<AllStudents> {
  @override
  Widget build(BuildContext context) {
    var _students = Provider.of<List<Student>>(context);
    var width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        (_students.isEmpty)
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset("assets/images/abu_logo.png"),
                    Container(
                        width: MediaQuery.of(context).size.width - 200,
                        child: Text(
                          "Physics Class of 2018/2019",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Campton-Light",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                          maxLines: 3,
                        )),
                  ],
                ),
              ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _students.length,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    print("profile_pic$index");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(
                                  student: _students[index],
                                  index: index,
                                )));
                  },
                  child: cardItem(
                      student: _students[index], width: width, index: index));
            },

            /*   CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: MySliverAppBar(expandedHeight: 200),
                    pinned: true,
                  ),
                  /*   SliverToBoxAdapter(
                    child: ListView.builder(
                      itemCount: _students.length,
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      itemBuilder: (context, index) {
                        return cardItem(student: _students[index], width: width);
                      },
                    ), */
                  //   )
                  /*      Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: */
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (_, index) =>
                            cardItem(student: _students[index], width: width),
                        childCount: _students.length),
                  )
                  //),
                ],
              ), */
            /*    ListView.builder(
                  itemCount: _students.length,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  itemBuilder: (context, index) {
                    return cardItem(student: _students[index], width: width);
                  },
                  /*  children: [
                      cardItem(width: width),
                      cardItem(width: width),
                      cardItem(width: width),
                      cardItem(width: width),
                      cardItem(width: width),
                    ]), */
                ) */
          ),
        ),
      ],
    );
  }

  Widget cardItem({Student student, width, int index}) {
    print("coke ${student.imgUrl}");
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
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(left: 43, right: 10),
                          width: 300,
                          child: Text(
                            student.name.toUpperCase(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              //fontFamily: "Campton"
                            ),
                          ),
                        ),
                      ),
                      /* SizedBox(
                        height: 10,
                      ),
                      Text(
                        student.matricNumber ?? "",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: "Camptonlight"),
                      )*/
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
                color: Colors.greenAccent.shade100,
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
              color: Colors.transparent,
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
                  backgroundColor: Colors.transparent,
                //  radius: 85,
                  //  radius: 100,
                  //    backgroundImage: AssetImage("assets/images/bil.jpg"),
                  child:
                  ClipOval(
                      child:
                     student.imgUrl == null
                      ? Image.asset('assets/images/user_placeholder.jpg')
                         : CachedNetworkImage(imageUrl:student.imgUrl),
                    /* FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: "https://picsum.photos/id/1005/200/200",
                    width: 85,
                    height: 85,
                  )*/
                      /*Image.network(
                      student.imgUrl,
                      //"https://picsum.photos/id/1005/200/200",
                      width: 85,
                      height: 85,
                      fit: BoxFit.cover,
                    ),*/
                      ),
                )
                ),
              ),
          ),
        ]),
      ),
    );
  }
}
