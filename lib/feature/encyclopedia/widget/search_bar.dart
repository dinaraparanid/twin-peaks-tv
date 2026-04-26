import 'package:flutter/widgets.dart';
import 'package:twin_peaks_tv/core/presentation/foundation/foundation.dart';
import 'package:twin_peaks_tv/core/presentation/theme/theme.dart';
import 'package:twin_peaks_tv/feature/encyclopedia/bloc/bloc.dart';

final class SearchBar extends StatelessWidget {
  const SearchBar({super.key, required this.currentLocale});
  final Locale? currentLocale;

  @override
  Widget build(BuildContext context) {
    return AppSearchBar(
      searchController: context.encyclopediaBloc.searchController,
      currentLocale: currentLocale,
      placeholder: context.ln.encyclopedia_search_placeholder,
      focusScopeNode: context.encyclopediaBloc.searchFieldNode,
      onDown: (_, _, isOutOfScope) {
        if (!isOutOfScope) {
          return KeyEventResult.ignored;
        }

        context.encyclopediaBloc.add(const FocusDownFromSearchEvent());
        return KeyEventResult.handled;
      },
    );
  }
}
