import 'package:flutter/material.dart';
import 'package:union_shop/views/app_styles.dart';

class Footer extends StatelessWidget {
  final VoidCallback? onSearch;
  final VoidCallback? onTerms;
  final VoidCallback? onSubscribe;
  final VoidCallback? placeholderCallbackForButtons;

  const Footer({
    super.key,
    this.onSearch,
    this.onTerms,
    this.onSubscribe,
    this.placeholderCallbackForButtons,
  });

  void _defaultSearch(BuildContext context) => Navigator.pushNamed(context, '/search');
  void _defaultTerms(BuildContext context) => Navigator.pushNamed(context, '/terms');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      child: Column(
        children: [
          // Top section with responsive padding
          LayoutBuilder(builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 600;
            final topPadding = EdgeInsets.symmetric(
              vertical: isNarrow ? 24.0 : 40.0,
              horizontal: isNarrow ? 45.0 : 250.0,
            );

            return Padding(
              padding: topPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // stack into one column on narrow screens (breakpoint = 600)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 600;

                      const leftColumn = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Opening Hours',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '\n❄️ Winter Break Closure Dates ❄️\n \nClosing 4pm 19/12/2025\n \nReopening 10am 05/01/2026\n \nLast post date: 12pm 18/12/2025\n',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '- - - - - - - - - - - - - - - - - -',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '\n(Term Time)\n \nMonday - Friday 10am - 4pm\n \n(Outside of Term Time / Consolidation Weeks)\n \nMonday - Friday 10am - 3pm\n \nPurchase online 24/7\n',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      );

                      final middleColumn = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Help and Information',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 15),
                          InkWell(
                            onTap: () => (onSearch != null) ? onSearch!() : _defaultSearch(context),
                            child: const Text('Search'),
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () => (onTerms != null) ? onTerms!() : _defaultTerms(context),
                            child: const Text('Terms & Conditions of Sale Policy'),
                          ),
                        ],
                      );

                      final rightColumn = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Latest Offers',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 15),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final shouldStack = isNarrow;

                              if (shouldStack) {
                                return const Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Email address',
                                        hintStyle: TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 48,
                                      child: PurpleButton(
                                        text: 'SUBSCRIBE',
                                        onPressed: Placeholder.new, // placeholder - use onSubscribe if provided
                                      ),
                                    ),
                                  ],
                                );
                              }

                              return const Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Email address',
                                        hintStyle: TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    height: 48,
                                    child: PurpleButton(
                                      text: 'SUBSCRIBE',
                                      onPressed: Placeholder.new, // placeholder
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      );

                      if (isNarrow) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            leftColumn,
                            const SizedBox(height: 24),
                            middleColumn,
                            const SizedBox(height: 24),
                            rightColumn,
                          ],
                        );
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(child: leftColumn),
                          Expanded(child: middleColumn),
                          Expanded(child: rightColumn),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          }),

          // Full-width divider
          const Divider(thickness: 0.75, height: 1),

          // Bottom section with responsive padding
          LayoutBuilder(builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 600;
            final bottomPadding = EdgeInsets.symmetric(
              vertical: isNarrow ? 24.0 : 40.0,
              horizontal: isNarrow ? 16.0 : 40.0,
            );

            return Padding(
              padding: bottomPadding,
              child: Column(
                children: [
                  // Responsive footer bottom: 2 columns on wide screens, 1 column on narrow screens
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 600;

                      const leftColumn = Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.facebook, size: 28),
                              SizedBox(width: 20),
                              Icon(Icons.camera, size: 28),
                            ],
                          ),
                        ],
                      );

                      final rightColumn = Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 12,
                            children: [
                              Container(width: 50, height: 30, color: Colors.black12),
                              Container(width: 50, height: 30, color: Colors.black12),
                              Container(width: 50, height: 30, color: Colors.black12),
                              Container(width: 50, height: 30, color: Colors.black12),
                            ],
                          ),
                        ],
                      );

                      if (isNarrow) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            leftColumn,
                            const SizedBox(height: 32),
                            rightColumn,
                            const SizedBox(height: 32),
                            const Text(
                              '© 2025 UPSU Store — Powered by Shopify',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Expanded(child: leftColumn),
                              Expanded(child: rightColumn),
                            ],
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            '© 2025 UPSU Store — Powered by Shopify',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}