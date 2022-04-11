import 'package:brandz/model/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brandz/product_brand.dart';


class BrandzCategory extends StatelessWidget {
  String id;
  late String displayBrand;
  BrandzCategory({required this.id});

  @override
  Widget build(BuildContext context) {
      
     final Stream<QuerySnapshot> brands = FirebaseFirestore.instance.collection('Brands')
            .where('parentId', isEqualTo : id).snapshots();
      
   return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
       elevation: 0.0,
               backgroundColor: Colors.white,

       leading: BackButton(color: Colors.black),
    
       
      ),
     body: SafeArea(
       child: StreamBuilder(
         stream: brands ,
         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
              return Text("first if");
            }
            if (snapshot.hasError) {
              return Text("There is an error");
            }
            final data = snapshot.requireData;
            
            
            return Expanded(
              child: Container(
               padding: EdgeInsets.all(10.0),
              child: GridView.builder(
              itemCount: data.size,
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0), 
              scrollDirection: Axis.vertical,
              
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color: Colors.white,
                            ),
                            height: 150,
                            width: 150,
                            child: 
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80),
	                               border: Border.all(
	                                width: 3,
                              	),
                             ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(22.0),
                                  child: Image.network(
                                      data.docs[index]['image'],
                                    ),
                                    
                                  ),
                                ),
                              
                            
                          ),
                           onPressed: () {
                                                displayBrand = data.docs[index]['name'].toString();
                       FirebaseFirestore.instance.collection("Brands").get().then((querySnapshot) {
                       querySnapshot.docs.forEach((doc){
                      if(doc.data()['name'] == displayBrand){
                      id = doc.id; // randomly generated document ID
                      var data = doc.data(); 
                      Navigator.push(
                                 context,
                      MaterialPageRoute(builder: (context) =>  product_brand(id: id,)),
                      );


                     
                      }
    });
});


                          
                         
}
                          
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    

                  
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomText(
                              text: data.docs[index]['name'],
                              fontSize: 20,
                             
                              
                            ),
                          ],
                        ),
                     
                  ],
                );
              },
              
               )) );
         }
         
       
       
          ),



   ));
  }
}

