
import 'package:brandz/main.dart';
import 'package:brandz/view/main_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Favourites extends StatelessWidget {
  const Favourites({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
         final Stream<QuerySnapshot> Favourites = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('Favourites')
        .snapshots();

    final _auth = FirebaseAuth.instance;
    return  Scaffold(
      appBar: AppBar(

         title: Text('Favourites' ,style: GoogleFonts.adamina(
        fontWeight: FontWeight.bold,
        fontSize : 25,
        color: Colors.black
        
      ),
       ),
               centerTitle: true,
               elevation: 0.0,
               backgroundColor: Colors.white,

       leading:  BackButton(
                  color: Colors.black,
                  onPressed: () {
                                   Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MainPage()));
                  }),

                  actions: [
                     Container(
                    height: 40,width: 60,
                  alignment: Alignment.center,

                    decoration: BoxDecoration(

                  

                      shape: BoxShape.circle,

                      color: Colors.white10

                    ), child : FlatButton(onPressed: (){
                        FirebaseFirestore.instance
                       .collection('users')
                       .doc(FirebaseAuth.instance.currentUser?.uid)
                       .collection('Favourites').get().then((snapshot) {
                       for (DocumentSnapshot ds in snapshot.docs){
                        ds.reference.delete();
                         };;;
                            });
        

                      




                    }
                    , child: Icon(Icons.delete_outline,size: 20,
                      color: Colors.black,)


                      

                      ),
                      

                  ),


                  ],



      ),
    
      body: StreamBuilder(
            stream: Favourites,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text("");
              }
              if (snapshot.hasError) {
                return Text("");
              }
              final data = snapshot.requireData;
              return Container(
                  child: ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return CartProductsCard(data: data, index: index);
                      }));
            })
    );
  }
}

class CartProductsCard extends StatelessWidget {
//  final CartController controller;
  final int index;
  final QuerySnapshot<Object?> data;
  static double total = 0;
  int number = 1;
  CartProductsCard({required this.data, required this.index});
  Widget build(BuildContext context) {
    if(FirebaseAuth.instance.currentUser?.uid != null){
    return Card(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[_productBox(index)]),
    );
    }
    else{
       return Card(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[]),
    );
    }
  }

  Widget _productBox(int index) {
    return Container(
        height: 95,
        padding: const EdgeInsets.all(8.0),
        // width: 100,
        margin: EdgeInsets.all(4.0),
        child: Row(children: [
          Container(
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      data.docs[index]['productImage'])),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.docs[index]['productBrandName'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data.docs[index]['productName'] + '\nSize: X',
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                        Text(
                          data.docs[index]['productPrice'].toString() + ' SAR',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]))),
          Column(children: [
            GestureDetector(
              onTap: () async {
                      var documentID;

                // this query is for getting the specific document id of the clicked product
                var collection = FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection('Favourites');
                var querySnapshots = await collection.get();
                // for assigning the id
                documentID = querySnapshots.docs[index].id;
                //deleting the product
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection('Favourites')
                    .doc(documentID)
                    .delete();
              
              },
              child: Container(
                padding: EdgeInsets.only(left: 50.0, bottom: 20.0),
                child: Icon(Icons.close, color: Colors.grey[400]),
              ),
            ),
            Row(children: [
            
             
      
            ])
          ])
        ]));
  }

}