class ListModel {
  int id;
  String title;
  String desc;

  ListModel(this.title, this.desc);
  ListModel.withId(
    this.id,
    this.title,
    this.desc,
  );

  // Converting a data list object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['title'] = title;
    map['desc'] = desc;
    return map;
  }

  // Extract a Data List object from a Map object
  ListModel.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.desc = map['desc'];
  }
}
