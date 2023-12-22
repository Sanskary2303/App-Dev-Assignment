import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

void main() async {
  stdout.write("Enter userId : ");
  var $userId = int.parse(stdin.readLineSync() ?? "1");
  print('\n');
  try {
    var API_endpoint = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(API_endpoint);

    if (response.statusCode == 200) {
      List<Post> posts = (json.decode(response.body) as List)
          .map((data) => Post.fromJson(data))
          .toList();

      List<Post> filteredPosts =
          filterPosts(posts, (post) => post.userId == $userId);

      print_filtered_posts(filteredPosts);
    } else {
      print('Failed to fetch posts. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

List<Post> filterPosts(List<Post> posts, bool Function(Post) condition) {
  return posts.where(condition).toList();
}

void print_filtered_posts(List<Post> filteredPosts) {
  print('Filtered Posts:');
  for (var post in filteredPosts) {
    print('Post ID: ${post.id}');
    print('Title: ${post.title}');
    print('Body: ${post.body}');
    print('----------------');
  }
}
