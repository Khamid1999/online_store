import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_store/data/models/product_model.dart';

class ProductRepository{
  Future<List<Product>> getProductsList(String collectionName) async {
    List<Product> dataList = [];
    final Future<QuerySnapshot<Map<String, dynamic>>> productList =
    FirebaseFirestore.instance.collection(collectionName).get();
    try{
      await productList.then((querySnapshot){
        querySnapshot.docs.forEach((product) {
          dataList.add(Product.fromMap(product.data()));
        });
      });
    } catch (e){
      print(e.toString());
    }
    return dataList;
  }
}