import 'package:cloud_firestore/cloud_firestore.dart';

class Comments {
  final String? name;
  final String? comment;

  Comments(
      { this.name,
       this.comment
      });

  Map<String,dynamic> toMap() {
    return {
      'name': name,
      'comment': comment,
      
    };
  }

  Comments.fromMap(Map<String, dynamic> CommentsMap)
      : name = CommentsMap["name"],
        comment = CommentsMap["comment"];
        
          
        
}

class Feed {
  final String? id;
  final String? description;
  final String time;
  final String? userid;
  final String? imagepath;
  final Comments? comment;
  final List<String>? likes;
  Feed(
      {this.id,
      required this.description,
      required this.time,
      required this.userid,
      required this.imagepath,
      this.comment,
      this.likes});

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'time': time,
      'userid': userid,
      'imagepath':imagepath,
      'comment': comment?.toMap(),
      'likes': likes
    };
  }

  Feed.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        description = doc.data()!["description"],
        time = doc.data()!["time"],
        userid = doc.data()!["userid"],
        imagepath = doc.data()!["imagepath"],
        comment = Comments.fromMap(doc.data()!["comment"]),
        likes = doc.data()?["likes"] == null
            ? null
            : doc.data()?["likes"].cast<String>();
}