class WorkModel {
  String? id;
  String? title;
  String? description;
  String? category;
  double? price;
  String? workerId;
  String? workerName;
  String? status; // 'available', 'booked', 'completed'

  WorkModel({this.id, this.title, this.description, this.category, this.price, this.workerId, this.workerName, this.status});

  factory WorkModel.fromMap(Map<String, dynamic> map, String id) {
    return WorkModel(
      id: id,
      title: map['title'],
      description: map['description'],
      category: map['category'],
      price: map['price']?.toDouble(),
      workerId: map['workerId'],
      workerName: map['workerName'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'workerId': workerId,
      'workerName': workerName,
      'status': status,
    };
  }
}
