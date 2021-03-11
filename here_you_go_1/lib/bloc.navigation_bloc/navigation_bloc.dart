import 'package:bloc/bloc.dart';
import 'package:here_you_go_1/pages/mytripspage.dart';
import 'package:here_you_go_1/src/ProfilePage.dart';
import '../pages/MyBlogPage.dart';
import '../pages/myexpensepage.dart';

import '../pages/homepage.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyBlogPageClickedEvent,
  MyExpenseClickedEvent,
  MyTripClickedEvent,
  MyProfileClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.MyBlogPageClickedEvent:
        yield MyBlogPage();
        break;
      case NavigationEvents.MyTripClickedEvent:
        yield MyTripsPage();
        break;
      case NavigationEvents.MyExpenseClickedEvent:
        yield Expense();
        break;
      case NavigationEvents.MyProfileClickedEvent:
        yield ProfilePage();
        break;
    }
  }
}
