class Blog {
  final String id;
  final String image;
  final String title;

  Blog({required this.id, required this.image, required this.title});

  Map<String, dynamic> toMap() {
    return {'it': id, 'image_url': image, 'title': title};
  }

  factory Blog.fromJson(Map<String, dynamic> map) {
    return Blog(id: map['id'], image: map['image_url'], title: map['title']);
  }
  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(id: map['id'], image: map['image_url'], title: map['title']);
  }
}
