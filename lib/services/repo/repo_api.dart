import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:repos_fetcher/models/repo_details.dart';

class RepoApi {
  static Future<List<RepoDetails>> getRepoList(pageKey, _pageSize) async {
    var resp = await http.get(
      Uri.parse(
          "https://api.github.com/users/JakeWharton/repos?page=${((pageKey / _pageSize) as double).toInt()}&per_page=$_pageSize"),
    );
    print("Fetched Data $pageKey");
    List result = json.decode(resp.body);
    List<RepoDetails> finalResult =
        result.map((e) => RepoDetails.fromJson(e)).toList();
    return finalResult;
  }
}
