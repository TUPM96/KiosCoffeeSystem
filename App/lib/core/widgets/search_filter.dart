import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/core/widgets/custom_date_picker.dart';
import 'package:boilerplate/core/widgets/readonly_textfield.dart';
import 'package:boilerplate/core/widgets/rounded_button_widget.dart';
import 'package:boilerplate/utils/conversion/conversion.dart';
import 'package:boilerplate/utils/conversion/extensions.dart';
import 'package:boilerplate/utils/functions/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// ignore: must_be_immutable
class SearchFilter extends StatelessWidget {
  final TextEditingController _searchController = new TextEditingController();

  final void Function(dynamic) onSearchMode;
  VoidCallback onFilterMode;
  DateTime startDate;
  DateTime endDate;
  final dynamic store;

  SearchFilter(
      {super.key,
      required this.onSearchMode,
      required this.onFilterMode,
      required this.startDate,
      required this.endDate,
      required this.store});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: (String value) {
              if (value.length >= 2)
                debouncer(() {
                  onSearchMode.call(value);
                });
            },
            autofocus: false,
            textInputAction: TextInputAction.go,
            maxLength: 45,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              constraints: BoxConstraints(
                  maxHeight: context.mediaQuery.size.height * .1),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1.0, color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(18),
              ),
              hintText: 'Search',
              hintStyle: Theme.of(context).textTheme.labelLarge,
              counterText: '',
              suffixIcon: IconButton(
                icon: Icon(Icons.search, color: AppColors.subtitleColor),
                onPressed: () {
                  if (_searchController.text.length >= 2)
                    debouncer(() {
                      onSearchMode.call(_searchController.text);
                    });
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: RoundedButtonWidget(
                padding: 8,
                height: 30,
                buttonTextSize: 14,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                textColor: Colors.white,
                onPressed: () async {
                  await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return _buildBottomSheetFilter(context);
                    },
                  );
                },
                isFullWidth: false,
                buttonColor: context.primary,
                buttonText: 'Filter',
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildBottomSheetFilter(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Dimens.vSpaceSmall,
        Text(
          'Filter Berdasarkan Tanggal',
          style: context.textTheme.bodyLarge,
        ),
        Dimens.vSpaceSmall,
        Divider(
          color: Colors.black,
          thickness: 1.5,
        ),
        StatefulBuilder(
          builder: (context, setState) => Observer(
            builder: (context) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomDatePicker(
                              onConfirmed: (DateTime date) {
                                store.startDate = date;
                                if ((store.startDate as DateTime)
                                    .isAfter(store.endDate as DateTime)) {
                                  store.endDate = store.startDate;
                                }
                              },
                              startDate: startDate,
                              endDate: endDate,
                              store: store),
                        ],
                      );
                    },
                  ).then((_) {
                    setState.call(() {
                      startDate = store.startDate;
                      endDate = store.endDate;
                    });
                  });
                },
                child: ReadOnlyTextFieldWidget(
                  formatDateAltToString(store.startDate),
                  hintText: 'Start Date',
                  icon: Icons.calendar_today_outlined,
                ),
              ),
            ),
          ),
        ),
        StatefulBuilder(
          builder: (context, setState) => Observer(
            builder: (context) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomDatePicker(
                            onConfirmed: (DateTime date) {
                              store.endDate = date;
                              if ((store.startDate as DateTime)
                                  .isAfter(store.endDate as DateTime)) {
                                store.startDate = store.endDate;
                              }
                            },
                            startDate: startDate,
                            endDate: endDate,
                            store: store,
                          ),
                        ],
                      );
                    },
                  ).then((_) {
                    setState.call(() {
                      startDate = store.startDate;
                      endDate = store.endDate;
                    });
                  });
                },
                child: ReadOnlyTextFieldWidget(
                  formatDateAltToString(store.endDate),
                  hintText: 'End Date',
                  icon: Icons.calendar_today_outlined,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: MaterialButton(
              onPressed: () {
                context.navigator.pop();
                onFilterMode.call();
              },
              color: context.primary,
              child: RoundedButtonWidget(
                isFullWidth: true,
                height: 60,
                buttonColor: Colors.black,
                buttonText: 'Lanjutkan',
              )),
        ),
      ],
    );
  }
}
