import 'package:flutter/material.dart';
import 'package:union_shop/views/app_styles.dart';

class Header extends StatefulWidget {
  // optional overrides — if null header will navigate using named routes
  final VoidCallback? onNavigateHome;
  final VoidCallback? onNavigateProduct;
  final VoidCallback? onNavigateSignIn;
  final VoidCallback? onNavigateAbout;
  final VoidCallback? onNavigateCart;
  final VoidCallback? onNavigateSearch;

  final VoidCallback? onToggleMenu;
  final VoidCallback placeholderCallbackForButtons;

  const Header({
    super.key,
    this.onNavigateHome,
    this.onNavigateProduct,
    this.onNavigateAbout,
    this.onNavigateSignIn,
    this.onNavigateCart,
    this.onNavigateSearch,
    this.onToggleMenu,
    required this.placeholderCallbackForButtons,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  bool _isMenuOpen = false;
  OverlayEntry? _menuOverlayEntry;

  // overlay menu state: 'root' | 'shop' | 'print'
  String _overlayMenu = 'root';

  void _showSubmenu(String menu) {
    _overlayMenu = menu;
    _menuOverlayEntry?.markNeedsBuild();
  }

  void _backToRootMenu() {
    _overlayMenu = 'root';
    _menuOverlayEntry?.markNeedsBuild();
  }

  void _closeOverlayAndNavigate(VoidCallback nav) {
    _removeMenuOverlay();
    nav();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) _searchController.clear();
    });
  }

  void _toggleMenu() {
    if (_isMenuOpen) {
      _removeMenuOverlay();
    } else {
      _showMenuOverlay();
    }
  }

  void _showMenuOverlay() {
    final overlay = Overlay.of(context);

    // start at root menu
    _overlayMenu = 'root';

    _menuOverlayEntry = OverlayEntry(builder: (ctx) {
      return Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeMenuOverlay,
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            top: 135,
            left: 0,
            right: 0,
            child: Material(
              elevation: 8,
              child: Builder(builder: (_) {
                // Build content dynamically based on _overlayMenu
                return _buildOverlayContent();
              }),
            ),
          ),
        ],
      );
    });

    overlay.insert(_menuOverlayEntry!);
    setState(() => _isMenuOpen = true);
  }

  Widget _buildOverlayContent() {
    // Root menu: show main entries; Shop and Print go to submenus
    if (_overlayMenu == 'root') {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMenuItem('Home'),
          InkWell(
            onTap: () => _showSubmenu('shop'),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
              child: Row(
                children: [
                  Expanded(child: Text('Shop', style: TextStyle(fontSize: 16))),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black54),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => _showSubmenu('print'),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
              child: Row(
                children: [
                  Expanded(child: Text('The Print Shack', style: TextStyle(fontSize: 16))),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black54),
                ],
              ),
            ),
          ),
          _buildMenuItem('SALE!'),
          _buildMenuItem('About'),
          _buildMenuItem('UPSU.net'),
        ],
      );
    }

    // Shop submenu
    if (_overlayMenu == 'shop') {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // back row
          InkWell(
            onTap: _backToRootMenu,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios, size: 14),
                  SizedBox(width: 8),
                  Text('Shop', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          InkWell(
            onTap: () => _closeOverlayAndNavigate(() => Navigator.pushNamed(context, '/')),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
              child: Row(children: [Text('Clothing', style: TextStyle(fontSize: 16))]),
            ),
          ),
          InkWell(
            onTap: () => _closeOverlayAndNavigate(() => Navigator.pushNamed(context, '/')),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
              child: Row(children: [Text('Merchandise', style: TextStyle(fontSize: 16))]),
            ),
          ),
          InkWell(
            onTap: () => _closeOverlayAndNavigate(() => Navigator.pushNamed(context, '/')),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
              child: Row(children: [Text('Halloween', style: TextStyle(fontSize: 16))]),
            ),
          ),
          InkWell(
            onTap: () => _closeOverlayAndNavigate(() => Navigator.pushNamed(context, '/')),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
              child: Row(children: [Text('Signature & Essential Range', style: TextStyle(fontSize: 16))]),
            ),
          ),
          InkWell(
            onTap: () => _closeOverlayAndNavigate(() => Navigator.pushNamed(context, '/')),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
              child: Row(children: [Text('Portsmouth City Collection', style: TextStyle(fontSize: 16))]),
            ),
          ),
          InkWell(
            onTap: () => _closeOverlayAndNavigate(() => Navigator.pushNamed(context, '/')),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
              child: Row(children: [Text('Pride Collection', style: TextStyle(fontSize: 16))]),
            ),
          ),
          InkWell(
            onTap: () => _closeOverlayAndNavigate(() => Navigator.pushNamed(context, '/')),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
              child: Row(children: [Text('Graduation', style: TextStyle(fontSize: 16))]),
            ),
          ),
        ],
      );
    }

    // Print Shack submenu
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: _backToRootMenu,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios, size: 14),
                SizedBox(width: 8),
                Text('The Print Shack', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
        const Divider(height: 1),
        InkWell(
          onTap: () => _closeOverlayAndNavigate(() => Navigator.pushNamed(context, '/about')),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
            child: Row(children: [Text('About', style: TextStyle(fontSize: 16))]),
          ),
        ),
        InkWell(
          onTap: () => _closeOverlayAndNavigate(() => Navigator.pushNamed(context, '/personalisation')),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
            child: Row(children: [Text('Personalisation', style: TextStyle(fontSize: 16))]),
          ),
        ),
      ],
    );
  }

  void _removeMenuOverlay() {
    _menuOverlayEntry?.remove();
    _menuOverlayEntry = null;
    if (mounted) setState(() => _isMenuOpen = false);
  }

  void _defaultNavigateHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void _defaultNavigateAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void _defaultNavigateSignIn(BuildContext context) {
    Navigator.pushNamed(context, '/sign_in');
  }

  void _defaultNavigateCart(BuildContext context) {
    Navigator.pushNamed(context, '/cart');
  }

  void _defaultNavigateSearch(BuildContext context) {
    Navigator.pushNamed(context, '/search');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildMenuItem(String title) {
    return InkWell(
      onTap: () {
        _removeMenuOverlay();
        if (title == 'About') {
          Navigator.pushNamed(context, '/about');
          return;
        }

        if (title == 'Home') {
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          return;
        }

        if (title == 'Shop') {
          Navigator.pushNamed(context, '/product');
          return;
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      color: Colors.white,
      child: Column(
        children: [
          // Top banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            color: const Color(0xFF4d2963),
            child: const Text(
              'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),

          // Main header
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Builder(builder: (context) {
                final isMobile = MediaQuery.of(context).size.width < 800;

                // On mobile + searching: make a single full-width search bar (with clickable search icon inside)
                if (isMobile && _isSearching) {
                  return Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.search, size: 24),
                                onPressed: () {
                                  final q = _searchController.text.trim();
                                  if (q.isEmpty) {
                                    _defaultNavigateSearch(context);
                                    return;
                                  }
                                  (widget.onNavigateSearch != null) ? widget.onNavigateSearch!() : _defaultNavigateSearch(context);
                                },
                              ),
                              prefixIcon: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: _toggleSearch,
                              ),
                            ),
                            autofocus: true,
                            onSubmitted: (_) {
                              final q = _searchController.text.trim();
                              if (q.isEmpty) {
                                _toggleSearch();
                                return;
                              }
                              (widget.onNavigateSearch != null) ? widget.onNavigateSearch!() : _defaultNavigateSearch(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }

                // default (window view or not searching) layout — keep existing row
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        (widget.onNavigateHome != null) ? widget.onNavigateHome!() : _defaultNavigateHome(context);
                      },
                      child: Builder(
                        builder: (context) {
                          final isWide = MediaQuery.of(context).size.width > 800;
                          final logoHeight = isWide ? 38.0 : 28.0;

                          return Image.network(
                            'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                            height: logoHeight,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                width: 18,
                                height: 18,
                                child: const Center(
                                  child: Icon(Icons.image_not_supported, color: Colors.grey),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                    Expanded(
                      child: Builder(builder: (context) {
                        final isWide = MediaQuery.of(context).size.width > 835;

                        if (isWide) {
                          return Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Home with hover label
                                _HoverableMenuLabel(
                                  text: 'Home',
                                  onTap: () => (widget.onNavigateHome != null) ? widget.onNavigateHome!() : _defaultNavigateHome(context),
                                ),

                                // Shop with dropdown (menu shown below the button)
                                PopupMenuButton<String>(
                                  // remove default tooltip ("Show menu")
                                  tooltip: '',
                                  // move the menu down so it appears under the label
                                  offset: const Offset(0, 36),
                                  onSelected: (value) {
                                    switch (value) {
                                      case 'clothing':
                                        (widget.onNavigateProduct != null) ? widget.onNavigateProduct!() : Navigator.pushNamed(context, '/product');
                                        break;
                                      case 'merchandise':
                                        Navigator.pushNamed(context, '/');
                                        break;
                                      case 'halloween':
                                        Navigator.pushNamed(context, '/');
                                        break;
                                      case 'signature':
                                        Navigator.pushNamed(context, '/');
                                        break;
                                      case 'portsmouth':
                                        Navigator.pushNamed(context, '/');
                                        break;
                                      case 'pride':
                                        Navigator.pushNamed(context, '/');
                                        break;
                                      case 'graduation':
                                        Navigator.pushNamed(context, '/');
                                        break;
                                    }
                                  },
                                  itemBuilder: (ctx) => const [
                                    PopupMenuItem(value: 'clothing', child: Text('Clothing')),
                                    PopupMenuItem(value: 'merchandise', child: Text('Merchandise')),
                                    PopupMenuItem(value: 'halloween', child: Text('Halloween')),
                                    PopupMenuItem(value: 'signature', child: Text('Signature & Essential Range')),
                                    PopupMenuItem(value: 'portsmouth', child: Text('Portsmouth City Collection')),
                                    PopupMenuItem(value: 'pride', child: Text('Pride Collection')),
                                    PopupMenuItem(value: 'graduation', child: Text('Graduation')),
                                  ],

                                  // label with hover effect (PopupMenuButton still handles taps)
                                  child: const _HoverableMenuLabel(text: 'Shop ▾'),
                                ),

                                // The Print Shack with dropdown
                                PopupMenuButton<String>(
                                  tooltip: '',
                                  offset: const Offset(0, 36), // same downward offset
                                  onSelected: (value) {
                                    switch (value) {
                                      case 'about':
                                        Navigator.pushNamed(context, '/');
                                        break;
                                      case 'personalisation':
                                        Navigator.pushNamed(context, '/personalisation');
                                        break;
                                    }
                                  },
                                  itemBuilder: (ctx) => const [
                                    PopupMenuItem(value: 'about', child: Text('About')),
                                    PopupMenuItem(value: 'personalisation', child: Text('Personalisation')),
                                  ],
                                  child: const _HoverableMenuLabel(text: 'The Print Shack ▾'),
                                ),
                                _HoverableMenuLabel(text: 'SALE!', onTap: widget.placeholderCallbackForButtons),
                                _HoverableMenuLabel(
                                  text: 'About',
                                  onTap: () => (widget.onNavigateAbout != null) ? widget.onNavigateAbout!() : _defaultNavigateAbout(context),
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                ),
                              ],
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      }),
                    ),

                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1000),
                      child: Builder(
                        builder: (context) {
                          final isWide = MediaQuery.of(context).size.width > 800;

                          // ensure mobile menu toggles are preserved
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Keep the compact right-side search for non-mobile or when not replacing the header
                              if (!_isSearching || !isMobile)
                                (_isSearching
                                    ? ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context).size.width > 900 ? 420 : 220,
                                        ),
                                        child: SizedBox(
                                          height: 40,
                                          child: TextField(
                                            controller: _searchController,
                                            decoration: InputDecoration(
                                              hintText: 'Search',
                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                              suffixIcon: IconButton(
                                                icon: const Icon(Icons.search, size: 24),
                                                onPressed: () {
                                                  final q = _searchController.text.trim();
                                                  if (q.isEmpty) {
                                                    _toggleSearch();
                                                    return;
                                                  }
                                                  (widget.onNavigateSearch != null) ? widget.onNavigateSearch!() : _defaultNavigateSearch(context);
                                                },
                                              ),
                                            ),
                                            autofocus: true,
                                            onSubmitted: (_) {
                                              final q = _searchController.text.trim();
                                              if (q.isEmpty) {
                                                _toggleSearch();
                                                return;
                                              }
                                              (widget.onNavigateSearch != null) ? widget.onNavigateSearch!() : _defaultNavigateSearch(context);
                                            },
                                          ),
                                        ),
                                      )
                                    : IconButton(
                                        icon: const Icon(Icons.search, size: 30, color: Colors.black),
                                        padding: const EdgeInsets.all(6),
                                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                        onPressed: _toggleSearch,
                                      )),
                              IconButton(
                                icon: const Icon(Icons.person_outline, size: 30, color: Colors.black),
                                padding: const EdgeInsets.all(6),
                                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                onPressed: () => (widget.onNavigateSignIn != null) ? widget.onNavigateSignIn!() : _defaultNavigateSignIn(context),
                              ),
                              IconButton(
                                icon: const Icon(Icons.shopping_bag_outlined, size: 30, color: Colors.black),
                                padding: const EdgeInsets.all(6),
                                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                onPressed: () => (widget.onNavigateCart != null) ? widget.onNavigateCart!() : _defaultNavigateCart(context),
                              ),
                              if (!isWide)
                                IconButton(
                                  icon: const Icon(Icons.menu, size: 27, color: Colors.black),
                                  padding: const EdgeInsets.all(6),
                                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                  onPressed: () {
                                    if (widget.onToggleMenu != null) {
                                      widget.onToggleMenu!();
                                    } else {
                                      _toggleMenu();
                                    }
                                  },
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),

          // thin full-width divider at the end of the header
          const Divider(
            height: 1,
            thickness: 1.2,
            color: Color.fromARGB(255, 222, 222, 222),
          ),
        ],
      ),
    );
  }
}

class _HoverableMenuLabel extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  const _HoverableMenuLabel({
    Key? key,
    required this.text,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
  }) : super(key: key);

  @override
  State<_HoverableMenuLabel> createState() => _HoverableMenuLabelState();
}

class _HoverableMenuLabelState extends State<_HoverableMenuLabel> {
  bool _hovering = false;

  void _setHover(bool v) {
    if (mounted) setState(() => _hovering = v);
  }

  @override
  Widget build(BuildContext context) {
    // base style from app_styles.normalText
    final base = normalText.copyWith(fontSize: normalText.fontSize ?? 16);
    const hoveredColor = Colors.black;

    return MouseRegion(
      onEnter: (_) => _setHover(true),
      onExit: (_) => _setHover(false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: widget.padding,
          child: Text(
            widget.text,
            style: base.copyWith(
              color: _hovering ? hoveredColor : base.color,
              decoration: _hovering ? TextDecoration.underline : TextDecoration.none,
              decorationColor: _hovering ? hoveredColor : null,
            ),
          ),
        ),
      ),
    );
  }
}