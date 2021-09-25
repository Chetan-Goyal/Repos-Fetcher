import 'package:hive/hive.dart';
part 'repo_details.g.dart';

@HiveType(typeId: 0)
class RepoDetails extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? nodeId;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? description;

  @HiveField(4)
  int? watchersCount;

  @HiveField(5)
  String? language;

  @HiveField(6)
  int? openIssuesCount;

  RepoDetails(
      {this.id,
      this.nodeId,
      this.name,
      this.description,
      this.watchersCount,
      this.language,
      this.openIssuesCount});

  RepoDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nodeId = json['node_id'];
    name = json['name'];
    description = json['description'];
    watchersCount = json['watchers_count'];
    language = json['language'];
    openIssuesCount = json['open_issues_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['node_id'] = nodeId;
    data['name'] = name;
    data['description'] = description;
    data['watchers_count'] = watchersCount;
    data['language'] = language;
    data['open_issues_count'] = openIssuesCount;
    return data;
  }
}
