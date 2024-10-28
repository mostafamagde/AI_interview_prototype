class GemiModel {
  final String res;

  GemiModel({
    required this.res,
  });

  factory GemiModel.fromJson(Map<String, dynamic> json) {
    return GemiModel(
      res: json['candidates'][0]['content']['parts'][0]['text'],
    );
  }
}
