class OrderModel {
  final String? title;
  final DateTime? time;
  final String? desc;
  final String? image;
  final bool? done;

  OrderModel({this.title, this.time, this.desc, this.image, this.done});

  OrderModel copyWith(
          {String? title,
          DateTime? time,
          String? desc,
          String? image,
          bool? done}) =>
      OrderModel(
          title: title ?? this.title,
          time: time ?? this.time,
          desc: desc ?? this.desc,
          image: image ?? this.image,
          done: done ?? this.done);

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        title: json["title"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        desc: json["desc"],
        image: json["image"],
        done: json["done"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "time": time?.toIso8601String(),
        "desc": desc,
        "image": image,
        "done": done,
      };
}
