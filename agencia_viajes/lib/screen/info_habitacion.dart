import 'package:agencia_viajes/models/place.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
// import 'dart:collection';

class PlaceScreen extends StatefulWidget {
  const PlaceScreen({required this.place, super.key});
  final Place place;

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  Place get place => widget.place;

  late bool isFavorited;
  @override
  void initState() {
    super.initState();
    isFavorited = true;
  }

  @override
  Widget build(BuildContext context) {
    const double kHorizontalPadding = 24;
    const String loremIpsumText =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nulla dolor, fermentum nec rhoncus vitae, vehicula quis ipsum. Mauris dapibus velit in quam scelerisque gravida. Etiam luctus augue ut lacus iaculis vehicula. In vel pretium arcu. Fusce fringilla volutpat hendrerit. Morbi nec accumsan nunc. Integer at iaculis justo. Ut dignissim scelerisque mi vitae consectetur. Mauris tincidunt erat at mi feugiat, id gravida justo suscipit. Vestibulum non ipsum varius, sagittis est vitae, ultrices est. Donec semper ligula vel urna ultricies varius. Aenean lacinia risus ut aliquam bibendum. Nullam justo ex, auctor ultricies eros a, commodo dapibus massa. Etiam tristique semper tempus. Vivamus elementum nisl neque, eu eleifend metus lobortis sed.';

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(
            left: kHorizontalPadding,
            right: kHorizontalPadding,
            top: 16,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        '\$${place.costPerNight.toStringAsFixed(0)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Text(
                        ' / night',
                        style: TextStyle(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  RatingRow(
                      rating: place.rating,
                      numberOfRatings: place.numberOfRatings),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: const Size(164, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Check availability',
                ),
              )
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            leading: CircularIconButton(
              iconData: Icons.close,
              onPressed: () {
                Navigator.pop(context);
              },
              iconColor: Colors.grey[800],
            ),
            actions: [
              CircularIconButton(
                iconData: Icons.ios_share,
                iconSize: 20,
                onPressed: () {},
                iconColor: Colors.grey[800],
              ),
              CircularIconButton(
                iconData: isFavorited ? Icons.favorite : Icons.favorite_border,
                iconSize: 20,
                onPressed: () {
                  setState(() {
                    isFavorited = !isFavorited;
                  });
                },
                iconColor:
                    isFavorited ? Theme.of(context).primaryColor : Colors.black,
              ),
              const SizedBox(
                width: 12,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: PageViewWithIndicators(
                type: IndicatorType.numbered,
                children: place.imageUrls
                    .map((e) => Hero(
                          tag: e,
                          child: Image.network(
                            e,
                            fit: BoxFit.cover,
                          ),
                        ))
                    .toList(),
              ),
            ),
            expandedHeight: 280,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kHorizontalPadding, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: intersperse(
                          const SizedBox(width: 6),
                          [
                            RatingRow(
                              rating: place.rating,
                              numberOfRatings: place.numberOfRatings,
                            ),
                            const Text('·'),
                            if (place.owner.isSuperhost) ...[
                              Icon(
                                Icons.verified,
                                color: Theme.of(context).primaryColor,
                                size: 20,
                              ),
                              const Text('Superhost'),
                            ]
                          ],
                        ).toList(),
                      ),
                      const SizedBox(height: 8),
                      Text('${place.city}, ${place.state}, ${place.country}'),
                      const MyDivider(),
                      Row(
                        children: [
                          Text(
                            'Entire ${place.typeText}\nhosted by ${place.owner.name}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          CircleAvatar(
                            radius: 32,
                            backgroundImage: NetworkImage(
                              place.owner.profileImageUrl,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          ...intersperse(
                            const SizedBox(
                              width: 12,
                              child: Center(
                                child: Text('·'),
                              ),
                            ),
                            [
                              Text('${place.guestCount} guests'),
                              Text(place.numGuestsText),
                              Text(place.numBedsText),
                              Text(place.numBathsText),
                            ],
                          ),
                        ],
                      ),
                      const MyDivider(),
                      ...intersperse(
                        const SizedBox(
                          height: 24,
                        ),
                        [
                          PlaceDetailListTile(
                            iconData: Icons.home_outlined,
                            title: 'Entire home',
                            subTitle:
                                "You'll have the ${place.typeText} to yourself.",
                          ),
                          const PlaceDetailListTile(
                            iconData: Icons.flare_outlined,
                            title: 'Enhanced Clean',
                            subTitle:
                                "This host is committed to Flutter UI's 5-step enhanced cleaning process.",
                          ),
                          const PlaceDetailListTile(
                            iconData: Icons.sensor_door_outlined,
                            title: 'Self check-in',
                            subTitle: 'Check yourself in with the keypad',
                          ),
                          const PlaceDetailListTile(
                            iconData: Icons.calendar_today_outlined,
                            title: 'Free cancellation for 48 hours',
                            subTitle:
                                'After that, cancel up to 7 days before check-in and get a 50% refund, minus the service fee.',
                          ),
                          const PlaceDetailListTile(
                            iconData: Icons.gavel_outlined,
                            title: 'House rules',
                            subTitle: "This host doesn't allow smoking.",
                          ),
                        ],
                      ),
                      const MyDivider(),
                      Text(
                        place.description ?? loremIpsumText,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        child: const Row(
                          children: [
                            Text(
                              'Show more',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: () {},
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          child: const Text(
                            'Contact host',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 64),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceDetailListTile extends StatelessWidget {
  const PlaceDetailListTile(
      {required this.iconData,
      required this.title,
      required this.subTitle,
      super.key});

  final IconData iconData;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          iconData,
          size: 36,
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subTitle,
                style: const TextStyle(fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RatingRow extends StatelessWidget {
  const RatingRow(
      {super.key, required this.rating, required this.numberOfRatings});

  final double? rating;
  final int? numberOfRatings;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          Icons.star,
          size: 20,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 4),
        Text(
          rating.toString(),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 4),
        Text(
          '(${numberOfRatings.toString()})',
          style: const TextStyle(fontWeight: FontWeight.w300),
        )
      ],
    );
  }
}

class CircularIconButton extends StatelessWidget {
  const CircularIconButton(
      {this.iconData,
      this.onPressed,
      this.iconColor = Colors.black,
      this.backgroundColor = Colors.white,
      this.iconSize = 24,
      this.radius = 36,
      super.key});
  final IconData? iconData;
  final Function? onPressed;
  // Defaults to 36. This value should be larger than [iconSize]
  final double radius;
  // Defaults to 24. This value should be smaller than [radius]
  final double iconSize;
  final Color? iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed as void Function()?,
      color: iconColor,
      padding: EdgeInsets.zero,
      splashRadius: 24,
      iconSize: iconSize,
      icon: Container(
        height: radius,
        width: radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: Icon(
          iconData,
        ),
      ),
    );
  }
}

enum IndicatorType { dots, numbered }

class PageViewWithIndicators extends StatefulWidget {
  const PageViewWithIndicators(
      {required this.children, this.type = IndicatorType.dots, super.key});
  final List<Widget> children;
  final IndicatorType type;

  @override
  State<PageViewWithIndicators> createState() => _PageViewWithIndicatorsState();
}

class _PageViewWithIndicatorsState extends State<PageViewWithIndicators> {
  late int activeIndex;

  @override
  void initState() {
    activeIndex = 0;
    super.initState();
  }

  setActiveIndex(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  _buildDottedIndicators() {
    List<Widget> dots = [];
    const double radius = 8;

    for (int i = 0; i < widget.children.length; i++) {
      dots.add(
        Container(
          height: radius,
          width: radius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                i == activeIndex ? Colors.white : Colors.white.withOpacity(.6),
          ),
        ),
      );
    }
    dots = intersperse(const SizedBox(width: 6), dots)
        .toList(); // Add spacing between dots

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: dots,
        ),
      ),
    );
  }

  _buildNumberedIndicators() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.33),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Text(
            '${(activeIndex + 1).toString()} / ${widget.children.length.toString()}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          onPageChanged: setActiveIndex,
          children: widget.children,
        ),
        widget.type == IndicatorType.dots
            ? _buildDottedIndicators()
            : _buildNumberedIndicators(),
      ],
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 48,
      thickness: 1,
    );
  }
}

Iterable<T> intersperse<T>(T element, Iterable<T> iterable) sync* {
  final iterator = iterable.iterator;
  if (iterator.moveNext()) {
    yield iterator.current;
    while (iterator.moveNext()) {
      yield element;
      yield iterator.current;
    }
  }
}
