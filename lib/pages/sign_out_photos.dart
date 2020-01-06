import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignOutPhoto extends StatefulWidget {
  @override
  _SignOutPhotoState createState() => _SignOutPhotoState();
}

class _SignOutPhotoState extends State<SignOutPhoto> {


  final PageController ctrl = PageController(viewportFraction: 0.8);

  final Firestore db = Firestore.instance;
  Stream slides;


  String activeTag = 'favorites';

  // Keep track of current page to avoid unnecessary renders
  int currentPage = 0;



  @override
  void initState() {
    // TODO: implement initState
    _queryDb();
    ctrl.addListener((){
      int next= ctrl.page.round();
      if(currentPage!= next){
        setState(() {
          currentPage=next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("SignOut Pictures" ,style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,),
      body: StreamBuilder(
        stream: slides,
        initialData: [],
        builder: (context,AsyncSnapshot snap){
          List slideList= snap.data.toList();
          return PageView.builder(
            controller: ctrl,
            itemCount: slideList.length,
            itemBuilder: (context,int currentIdx){
              /* if(currentIdx == 0){
                return null;
              }*/
              //   if(slideList.length>=currentIdx){
              bool active = currentIdx == currentPage;
              return _buildStoryPage(slideList[currentIdx],active);
              //  }
              return null;
            },
          );


        },
      ),
    );
  }


  //Query Firestore
  Stream _queryDb({String tag='favorites'}){
    //Make a query
    Query query = db.collection('signout_images');
    //Map the documents to the data payload
    slides= query.snapshots().map((list) => list.documents.map((doc) => doc.data));
    setState(() {
      activeTag=tag;
    });
  }

  //Builder functions
  _buildStoryPage(Map data, bool active){
    final double blur = active ? 30 :0;
    final double offset = active? 20:0;
    final double top = active ? 100 : 200;

    var imgAsset=data['img'];
    var image= DecorationImage(image: NetworkImage(imgAsset),fit: BoxFit.cover);
    return GestureDetector(
      child: Hero(
          tag: imgAsset,
          child:  AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutQuint,
            margin: EdgeInsets.only(top: top, bottom: 50,right: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imgAsset)
                ),
                boxShadow: [BoxShadow(color: Colors.black87,blurRadius: blur,offset: Offset(offset,offset)),]

            ),
            //child: Image.network(data['img'])
            //Image(NetworkImage(data['img'])),
          )
      ),
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Hero(
            tag: imgAsset,
            child: Image.network(imgAsset, fit: BoxFit.cover),
          );
        }));
      },
    );
  }

  _buildTagPage(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Your Stories', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
          Text('FILTER', style: TextStyle( color: Colors.black26 )),
          _buildButton('favorites'),
          _buildButton('cool'),
          _buildButton('sad')
        ],
      ),

    );
  }

  _buildButton(tag) {
    Color color = tag == activeTag ? Colors.purple : Colors.white;
    return FlatButton(color: color, child: Text('#$tag'), onPressed: () => _queryDb(tag: tag));
  }

}
