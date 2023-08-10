import 'package:exchange/app/exchange_bloc/symbols_bloc.dart';
import 'package:exchange/app/exchange_bloc/symbols_event.dart';
import 'package:exchange/app/screens/exchange.dart';
import 'package:exchange/data/data_module.dart';
import 'package:exchange/data/repository_impl/exchange_repository_impl.dart';
import 'package:exchange/domain/repository/exchange_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  final DataModule data = await DataModule.init();
  runApp(
    RepositoryProvider<ExchangeRepository>(
      lazy: false,
      create: (BuildContext context) => ExchangeRepositoryImpl(
        data.get(),
        data.get(),
      ),
      child: BlocProvider(
        lazy: false,
        create: (BuildContext context) =>
            SymbolsBloc(context.read())..add(SymbolsLoadEvent()),
        child: MaterialApp(
          home: Scaffold(
            body: ExchangeScreen(),
          ),
        ),
      ),
    ),
  );
}
