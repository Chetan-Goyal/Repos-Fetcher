import 'package:flutter/material.dart';
import 'package:repos_fetcher/models/repo_details.dart';

class RepoItem extends StatelessWidget {
  const RepoItem({
    Key? key,
    required this.item,
  }) : super(key: key);
  final RepoDetails item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          const Icon(Icons.book, size: 70),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(item.name ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 70,
                  child: Text(
                    item.description ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Visibility(
                    child: const Icon(Icons.code),
                    visible: item.language != null && item.language != "",
                  ),
                  Visibility(
                    visible: item.language != null && item.language != "",
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 10.0),
                      child: Text(
                        item.language ?? "",
                      ),
                    ),
                  ),
                  const Icon(Icons.bug_report),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 10.0),
                    child: Text("${item.openIssuesCount ?? 0}"),
                  ),
                  const Icon(Icons.face_sharp),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 10.0),
                    child: Text("${item.watchersCount ?? 0}"),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
