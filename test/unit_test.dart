void main() {
  int getLevel(score) {
    int level = 3;
    level = (score ~/ (30)).round();
    return level;
  }

  List<int> scores = [10, 30, 60, 90, 120, 300, 400, 600, 1200, 3600];
  for (var element in scores) {
    // print(element);
    print(getLevel(element));
  }
}
