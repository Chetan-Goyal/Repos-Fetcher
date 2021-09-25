import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:repos_fetcher/models/repo_details.dart';

class RepoApi {
  static Future<List<RepoDetails>> getRepoList(pageKey, _pageSize) async {
    List<RepoDetails> finalResult = [];
    try {
      var resp = await http.get(
        Uri.parse(
            "https://api.github.com/users/JakeWharton/repos?page=${((pageKey / _pageSize) as double).toInt()}&per_page=$_pageSize"),
      );
      List result = json.decode(resp.body);
      finalResult = result.map((e) => RepoDetails.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
    return finalResult;
  }
}
