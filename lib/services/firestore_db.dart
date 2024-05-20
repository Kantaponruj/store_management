import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_management/constants/firebase_auth_constants.dart';
import 'package:store_management/models/category.dart';
import 'package:store_management/models/product.dart';

class FirestoreDb {
  static addUser(ProductModel productModel) async {
    await firebaseFirestore
        .collection('user')
        .doc(auth.currentUser!.uid)
        .collection('products')
        .add({
      'id': productModel.id,
      'name': productModel.name,
      'price': productModel.price,
      'quantity': productModel.quantity,
      'category': productModel.category,
      'description': productModel.description,
      'image': productModel.image,
      'created_at': Timestamp.now(),
    });
  }

  static addProduct(ProductModel productModel) async {
    await firebaseFirestore
        .collection('user')
        .doc(auth.currentUser!.uid)
        .collection('products')
        .add({
      'id': productModel.id,
      'name': productModel.name,
      'price': productModel.price,
      'quantity': productModel.quantity,
      'category': productModel.category,
      'description': productModel.description,
      'image': productModel.image,
      'created_at': Timestamp.now(),
    });
  }

  static Stream<List<ProductModel>> productStream() {
    return firebaseFirestore
        .collection('user')
        .doc(auth.currentUser!.uid)
        .collection('products')
        .snapshots()
        .map((QuerySnapshot query) {
      List<ProductModel> products = [];
      for (var documentSnapshot in query.docs) {
        final productModel = ProductModel.fromDocumentSnapshot(
            documentSnapshot: documentSnapshot);
        products.add(productModel);
      }
      return products;
    });
  }

  static addCategory(ProductCategory category) async {
    await firebaseFirestore
        .collection('user')
        .doc(auth.currentUser!.uid)
        .collection('categories')
        .add({
      'id': category.id,
      'key': category.key,
      'name': category.name,
      'description': category.description,
      'icon': category.icon,
      'image': category.image,
      'color': category.color,
      'created_at': Timestamp.now(),
    });
  }

  static Stream<List<ProductCategory>> categoryStream() {
    return firebaseFirestore
        .collection('user')
        .doc(auth.currentUser!.uid)
        .collection('categories')
        .snapshots()
        .map((QuerySnapshot query) {
      List<ProductCategory> categories = [];
      for (var documentSnapshot in query.docs) {
        final categoryModel = ProductCategory.fromDocumentSnapshot(
            documentSnapshot: documentSnapshot);
        categories.add(categoryModel);
      }
      return categories;
    });
  }

  // static updateStatus(bool isDone, documentId) {
  //   firebaseFirestore
  //       .collection('users')
  //       .doc(auth.currentUser!.uid)
  //       .collection('todos')
  //       .doc(documentId)
  //       .update(
  //     {
  //       'isDone': isDone,
  //     },
  //   );
  // }

  // static deleteTodo(String documentId) {
  //   firebaseFirestore
  //       .collection('users')
  //       .doc(auth.currentUser!.uid)
  //       .collection('todos')
  //       .doc(documentId)
  //       .delete();
  // }
}
