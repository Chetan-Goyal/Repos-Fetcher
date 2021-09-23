import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:repos_fetcher/models/repo_details.dart';
import 'package:repos_fetcher/services/repo/repo_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _pageSize = 15;

  final PagingController<int, RepoDetails> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await RepoApi.getRepoList(pageKey, _pageSize);

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final int? nextPageKey = pageKey + _pageSize;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(96, 125, 139, 1),
        title: Text("Jake's Git"),
      ),
      body: PagedListView<int, RepoDetails>.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<RepoDetails>(
          animateTransitions: true,
          itemBuilder: (context, item, index) => SizedBox(
            height: 90,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                Icon(Icons.book, size: 70),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(item.name ?? "",
                        style: TextStyle(
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
                    Spacer(),
                    Row(
                      children: [
                        Visibility(
                          child: Icon(Icons.code),
                          visible: item.language != null && item.language != "",
                        ),
                        Visibility(
                          visible: item.language != null && item.language != "",
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 10.0),
                            child: Text(
                              item.language ?? "",
                            ),
                          ),
                        ),
                        Icon(Icons.bug_report),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, right: 10.0),
                          child: Text("${item.openIssuesCount ?? 0}"),
                        ),
                        Icon(Icons.face_sharp),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, right: 10.0),
                          child: Text("${item.watchersCount ?? 0}"),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          // CharacterListItem(
          //   character: item,
          // ),
        ),
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
