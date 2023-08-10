import 'package:exchange/app/exchange_bloc/symbols_bloc.dart';
import 'package:exchange/app/exchange_bloc/symbols_event.dart';
import 'package:exchange/app/exchange_bloc/symbols_state.dart';
import 'package:exchange/data/models/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExchangeScreen extends StatefulWidget {
  ExchangeScreen({super.key});

  final TextEditingController firstController =
      TextEditingController(text: '0');
  final TextEditingController secondController =
      TextEditingController(text: '0');

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SymbolsBloc, SymbolsState>(
      builder: (BuildContext context, state) {
        if (!state.isLoading) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: widget.firstController,
                      onChanged: (String? value) {
                        context.read<SymbolsBloc>().add(
                              GetExchangeEvent(value ?? '0'),
                            );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, right: 30),
                    child: Text('EUR'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        state.secondCurrency,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: DropdownButton<String>(
                      value: state.firstSelectedSymbol,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      onChanged: (String? value) {
                        context.read<SymbolsBloc>().add(
                              ChangeSymbolsEvent(
                                ChangedSymbol.first,
                                value ?? state.firstSelectedSymbol,
                              ),
                            );
                        context.read<SymbolsBloc>().add(
                              GetExchangeEvent(state.firstCurrency),
                            );
                      },
                      items: state.symbols
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              )
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
