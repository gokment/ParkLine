import 'dart:convert';
import 'package:parkline/Model/User.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

class DBServices {
  final CollectionReference usercol =
      FirebaseFirestore.instance.collection("users");

  Future saveUser(UserModel user) async {
    try {
      await usercol.doc(user.id).set(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

    Future  saveUserPref(UserModel user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var data = json.encode(user.toMap());
    pref.setString("user", data);
    pref.commit();
  }

  Future getUser(String id) async {
    try {
      final data = await usercol.doc(id).get();
      final user = UserModel.fromJson(data.data());
      return user;
    } catch (e) {
      return false;
    }
  }

  Future updateUser(UserModel user, String id) async {
    try {
      await usercol.doc(id).update(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
Future<void> share(String text, int phone) async {
    await WhatsappShare.share(
      text: '$text',
      // linkUrl: 'https://flutter.dev/',
      phone: phone.toString(),
    );
  }
  // Stream<UserM> get getCurrentUser {
  //   final user = FirebaseAuth.instance.currentUser;
  //   return user != null
  //       ? usercol.doc(user.uid).snapshots().map((user) {
  //           UserM.currentUser = UserM.fromJson(user.data());
  //           return UserM.fromJson(user.data());
  //         })
  //       : null;
  // }

  // Future<String> uploadImage(File file, {String path}) async {
  //   var time = DateTime.now().toString();
  //   var ext = Path.basename(file.path).split(".")[1].toString();
  //   String image = path + "_" + time + "." + ext;
  //   try {
  //     StorageReference ref =
  //         FirebaseStorage.instance.ref().child(path + "/" + image);
  //     StorageUploadTask upload = ref.putFile(file);
  //     await upload.onComplete;
  //     return await ref.getDownloadURL();
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // Future<List> get getCarouselImage async {
  //   try {
  //     final data = await carouselcol.doc("ZlhrUQtxlBN7KsbgfFpM").get();
  //     return data.data()["imgs"];
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // Future savevehicule(Vehicule vehicule) async {
  //   try {
  //     await vehiculecol.doc().set(vehicule.toMap());
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Future updatevehicule(Vehicule vehicule) async {
  //   try {
  //     await vehiculecol.doc(vehicule.id).update(vehicule.toMap());
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Future deletevehicule(String id) async {
  //   try {
  //     await vehiculecol.doc(id).delete();
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Stream<List<Vehicule>> getvehicule({CarType type, String uid}) {
  //   return vehiculecol
  //       .where("type",
  //           isEqualTo: type == null
  //               ? null
  //               : type == CarType.car
  //                   ? "car"
  //                   : "moto")
  //       .where("uid", isEqualTo: uid)
  //       .snapshots()
  //       .map((vehicule) {
  //     return vehicule.docs
  //         .map((e) => Vehicule.fromJson(e.data(), id: e.id))
  //         .toList();
  //   });
  // }

  // Stream<List<Vehicule>> getvehiculefav(CarType type) {
  //   final user = FirebaseAuth.instance.currentUser;
  //   return vehiculecol
  //       .where("type", isEqualTo: type == CarType.car ? "car" : "moto")
  //       .where("favories", arrayContains: user.uid)
  //       .snapshots()
  //       .map((vehicule) {
  //     return vehicule.docs
  //         .map((e) => Vehicule.fromJson(e.data(), id: e.id))
  //         .toList();
  //   });
  // }

  // Stream<List<UserM>> get getAllUsers {
  //   return usercol.snapshots().map((users) {
  //     return users.docs.map((e) => UserM.fromJson(e.data())).toList();
  //   });
  // }

  // Future<bool> add_comment(Comment comment) async {
  //   try {
  //     await commentcol.doc().set(
  //         comment.toMap()..update("date_comment", (value) => Timestamp.now()));
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Stream<int> getCountComment(String id) {
  //   return commentcol
  //       .where("id_comment_pub", isEqualTo: id)
  //       .snapshots()
  //       .map((comments) {
  //     return comments.docs
  //         .map((e) => Comment.fromJson(e.data(), e.id))
  //         .toList()
  //         .length;
  //   });
  // }

  // Stream<List<Comment>> gecomment(String id) {
  //   return commentcol
  //       .where("id_comment_pub", isEqualTo: id)
  //       .snapshots()
  //       .map((comments) {
  //     return comments.docs
  //         .map((e) => Comment.fromJson(e.data(), e.id))
  //         .toList();
  //   });
  // }

  // Stream<List<Comment>> gecommentComment(String id) {
  //   return commentcol
  //       .where("id_comment", isEqualTo: id)
  //       .snapshots()
  //       .map((comments) {
  //     return comments.docs
  //         .map((e) => Comment.fromJson(e.data(), e.id))
  //         .toList();
  //   });
  // }

  // Stream<int> getCountCommentComment(String id) {
  //   return commentcol
  //       .where("id_comment", isEqualTo: id)
  //       .snapshots()
  //       .map((comments) {
  //     return comments.docs
  //         .map((e) => Comment.fromJson(e.data(), e.id))
  //         .toList()
  //         .length;
  //   });
  // }
}