import 'package:bloc/bloc.dart';
import 'package:here_you_go_1/Screens/TripDetails.dart';
<<<<<<< HEAD
import 'package:here_you_go_1/pages/mainTrip.dart';
=======
import 'package:here_you_go_1/pages/currencyConverter.dart';
>>>>>>> 1f79553e5372dd9ef5e506f395adb6bbf2823a13
import 'package:here_you_go_1/pages/mytripspage.dart';
import 'file:///E:/SDP/here_you_go_1/lib/pages/ProfilePage.dart';
import '../pages/MyBlogPage.dart';
import '../pages/myexpensepage.dart';

import '../pages/homepage.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyBlogPageClickedEvent,
  MyExpenseClickedEvent,
  MyTripClickedEvent,
  MyProfileClickedEvent,
  MyCurrencyConverterEvent,
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
      case NavigationEvents.MyCurrencyConverterEvent:
        yield CurrencyPage();
        break;
    }
  }
}
