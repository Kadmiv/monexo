import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monexo/generated/l10n.dart';
import 'package:monexo/screens/statistics/statistics_bloc.dart';
import 'package:monexo/screens/statistics/statistics_event.dart';
import 'package:monexo/screens/statistics/widgets/general_statistics_page.dart';
import 'package:monexo/screens/statistics/widgets/transaction_statistics_page.dart';

/// Сторінка для статистики рахунку
/// Відображає основну статистику рахунку, витрати та доходи
/// Додатково відображає статистику за різні періоди часу -  день, тиждень та місяць
class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with TickerProviderStateMixin {
  final bloc = StatisticsBloc();
  late TabController _tabController = TabController(length: 3, vsync: this);
  late TabController _timePeriodController =
      TabController(length: 3, vsync: this);
  late PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    bloc.add(const LoadStatistics());

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _pageController.animateToPage(
          _tabController.index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    _timePeriodController.addListener(() {
      if (!_timePeriodController.indexIsChanging) {
        final timePeriod = TimePeriod.values[_timePeriodController.index];
        bloc.add(UpdateTimePeriod(timePeriod: timePeriod));
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _timePeriodController.dispose();
    _pageController.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => bloc,
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  tabs: [
                    Tab(text: S.of(context).basic),
                    Tab(text: S.of(context).revenue),
                    Tab(text: S.of(context).costs),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TabBar(
                  controller: _timePeriodController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  tabs: [
                    Tab(text: S.of(context).day),
                    Tab(text: S.of(context).week),
                    Tab(text: S.of(context).month),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const GeneralStatisticsPage(),
                    const TransactionStatisticsPage(isIncome: true),
                    const TransactionStatisticsPage(isIncome: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
