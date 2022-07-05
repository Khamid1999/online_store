import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_store/data/models/category_model.dart';

class CategoryRepository {
  final Future<QuerySnapshot<Map<String, dynamic>>> categoryList =
      FirebaseFirestore.instance.collection('men_categories').get();

  Future<List<Category>> getCategoriesList() async {
    List<Category> dataList = [];
    try {
      await categoryList.then((querySnapshot) {
        querySnapshot.docs.forEach((category) {
          dataList.add(Category.fromMap(category.data()));
        });
      });
    } catch (e) {
      print(e.toString());
    }
    return dataList;
  }
}
