import 'package:dictionary/feature/home/screen/home_page.dart';
import 'package:dictionary/feature/search/screen/search_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
    ),
    GoRoute(
        path: '/search/:query',
        name: 'search',
        builder: (BuildContext context, GoRouterState state) {
          return SearchPage(
            query: state.pathParameters['query']!,
          );
        }),
  ],
);
