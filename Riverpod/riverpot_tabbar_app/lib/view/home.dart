import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpot_tabbar_app/view/first_page.dart';
import 'package:riverpot_tabbar_app/view/second_page.dart';
import 'package:riverpot_tabbar_app/view/third_page.dart';
import 'package:riverpot_tabbar_app/vm/tab_provider.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with TickerProviderStateMixin{
  late TabController _tabController;
  final List<Widget> _pages = [FirstPage(), SecondPage(), ThirdPage()];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);


    _tabController.addListener(() {
      if(!_tabController.indexIsChanging){
        ref.read(tabProvider.notifier).changeTab(_tabController.index);
        // ConsumerState라 바로 가져와진다.
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(tabProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Tabbar Example"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.home), text: "홈"),
            Tab(icon: Icon(Icons.business), text: "비즈니스"),
            Tab(icon: Icon(Icons.school), text: "학교"),
          ],
          onTap: (index) {
            ref.read(tabProvider.notifier).changeTab(index);
            _tabController.animateTo(index);
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
            ref.read(tabProvider.notifier).changeTab(index);
            _tabController.animateTo(index);
        },
        items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
            BottomNavigationBarItem(icon: Icon(Icons.business), label: "비즈니스"),
            BottomNavigationBarItem(icon: Icon(Icons.school), label: "학교"),
        ],
      ),
    );
  }
}