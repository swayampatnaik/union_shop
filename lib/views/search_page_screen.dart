import 'package:flutter/material.dart';
import 'package:union_shop/views/app_styles.dart';
import 'package:union_shop/views/header.dart';
import 'package:union_shop/views/footer.dart';
import 'package:union_shop/widgets/buttons.dart';

class SearchPageScreen extends StatelessWidget {
  const SearchPageScreen({super.key});
  
  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(
              placeholderCallbackForButtons: () {},
            ),

            // centered search input with a purple button next to it
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 20.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Builder(builder: (context) {
                    final TextEditingController searchController = TextEditingController();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('SEARCH OUR SITE', style: heading2),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 48,
                                child: TextField(
                                  controller: searchController,
                                  textInputAction: TextInputAction.search,
                                  decoration: const InputDecoration(
                                    hintText: 'Search',
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                  ),
                                  onSubmitted: (q) {
                                    // handle search submit (navigate to results)
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Search: ${q.trim()}')),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              height: 48,
                              child: PurpleButton(
                                text: 'SUBMIT',
                                onPressed: () {
                                  final q = searchController.text.trim();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Search: ${q.isEmpty ? '(empty)' : q}')),
                                  );
                                  // handle search button press (navigate to results)
                                },
                              ),  
                            )
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            
            Footer(
            placeholderCallbackForButtons: placeholderCallbackForButtons,
            ),
          ],
        ),
      ),
    );
  }
}