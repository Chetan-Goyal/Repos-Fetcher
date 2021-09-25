import 'package:hive/hive.dart';
import 'package:repos_fetcher/models/repo_details.dart';

Future addReposToLocal(List<RepoDetails> items) async {
  List<RepoDetails> finalData = await getReposFromLocal();
  finalData.addAll(items);
  Box box = await Hive.openBox("repoList");

  await box.put("data", items);
}

Future<List<RepoDetails>> getReposFromLocal() async {
  Box box = await Hive.openBox("repoList");
  List<RepoDetails> repoList =
      List<RepoDetails>.from(box.get("data", defaultValue: []) as List);
  return repoList;
}
