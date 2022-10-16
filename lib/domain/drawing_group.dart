class DrawingGroup{
  String? name;
  List<String>? drawingIds;

  DrawingGroup({required this.name,this.drawingIds});

  DrawingGroup.fromMap(String name,List<String> drawingIds)
      :name=name,
        drawingIds=drawingIds;

  Map<String, dynamic> toMap() => {
    'name':name,
    'drawingIds':drawingIds
  };
}