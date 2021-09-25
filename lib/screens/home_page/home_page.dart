import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:repos_fetcher/models/repo_details.dart';
import 'package:repos_fetcher/screens/home_page/widgets/repo_item.dart';
import 'package:repos_fetcher/services/internet_connectivity.dart';
import 'package:repos_fetcher/services/repo/repo_api.dart';
import 'package:repos_fetcher/services/repo/repo_local.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _pageSize = 15;

  final PagingController<int, RepoDetails> _pagingController =
      PagingController(firstPageKey: 0);
  List<RepoDetails> localRepoList = [];

  ConnectivityResult? _source;
  final MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      _source = source.keys.toList()[0];
      if (_source == ConnectivityResult.none) {
        getReposFromLocal().then((value) {
          localRepoList = value;
          setState(() {});
        });
      } else {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await RepoApi.getRepoList(pageKey, _pageSize);

      await addReposToLocal(newItems);

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
        backgroundColor: const Color.fromRGBO(96, 125, 139, 1),
        title: const Text("Jake's Git"),
      ),
      body: _source == null
          ? const Center(child: CircularProgressIndicator())
          : _source == ConnectivityResult.none
              ? ListView.separated(
                  itemBuilder: (context, index) => RepoItem(
                        item: localRepoList[index],
                      ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: localRepoList.length)
              : PagedListView<int, RepoDetails>.separated(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<RepoDetails>(
                    animateTransitions: true,
                    itemBuilder: (context, item, index) => RepoItem(item: item),
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                ),
    );
  }
}
