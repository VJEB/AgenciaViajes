import 'package:agencia_viajes/models/hotel.dart';
import 'package:agencia_viajes/models/place.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
// import 'dart:collection';

class HotelScreen extends StatefulWidget {
  final Place place;
  final Hotel hotel;
  const HotelScreen({required this.hotel, required this.place, super.key});

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  var tipoDeCama;

  var numeroDeCamas;

  var numeroDePersonas;

  Place get place => widget.place;
  Hotel get hotel => widget.hotel;

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
          padding: const EdgeInsets.only(left: 1, right: 1),
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
                        '\$${hotel.haHoPrecioPorNoche.toStringAsFixed(0)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Text(
                        ' / noche',
                        style: TextStyle(),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 4),
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        '\$${hotel.haHoPrecioPorNoche.toStringAsFixed(0)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(
                          width: 4), // Add some spacing between the texts
                      const Text(
                        ' / todo incluido',
                        style: TextStyle(),
                        softWrap: true,
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width:
                    140, // Set width to maximum to make it fill available space
                height: 50, // Set the desired height
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFBD59),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(5), // Set border radius
                    ),
                  ),
                  label: const Text("Reservar",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black)), // Increase text size
                  icon: const Icon(
                    Icons.book,
                    size: 20,
                    color: Colors.black,
                  ), // Increase icon size
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: const Color(0xFFFFBD59),
            leading: CircularIconButton(
              iconData: Icons.close,
              onPressed: () {
                Navigator.pop(context);
              },
              iconColor: Colors.grey[800],
            ),
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
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Número de camas:",
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove,
                                          color: Colors.white),
                                      onPressed: () {
                                        // Implement decrement logic
                                      },
                                    ),
                                    SizedBox(width: 10),
                                    Text("1",
                                        style: TextStyle(
                                            color: Colors
                                                .white)), // Display selected value
                                    SizedBox(width: 10),
                                    IconButton(
                                      icon:
                                          Icon(Icons.add, color: Colors.white),
                                      onPressed: () {
                                        // Implement increment logic
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Número de personas:",
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove,
                                          color: Colors.white),
                                      onPressed: () {
                                        // Implement decrement logic
                                      },
                                    ),
                                    SizedBox(width: 10),
                                    Text("1",
                                        style: TextStyle(
                                            color: Colors
                                                .white)), // Display selected value
                                    SizedBox(width: 10),
                                    IconButton(
                                      icon:
                                          Icon(Icons.add, color: Colors.white),
                                      onPressed: () {
                                        // Implement increment logic
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Tipo de cama",
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                        ),
                        value:
                            null, // Selected value, set to null if no value is selected initially
                        onChanged: (value) {
                          // Implement dropdown value change logic
                        },
                        items: [
                          DropdownMenuItem(
                            value: "Single",
                            child: Text("Single",
                                style: TextStyle(color: Colors.white)),
                          ),
                          DropdownMenuItem(
                            value: "Double",
                            child: Text("Double",
                                style: TextStyle(color: Colors.white)),
                          ),
                          DropdownMenuItem(
                            value: "King",
                            child: Text("King",
                                style: TextStyle(color: Colors.white)),
                          ),
                          DropdownMenuItem(
                            value: "Queen",
                            child: Text("Queen",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                      const MyDivider(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: intersperse(
                          const SizedBox(width: 6),
                          [
                            Text(
                              hotel.hoteNombre,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RatingRow(
                              rating: place.rating,
                            ),
                          ],
                        ).toList(),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.phone,
                              color:
                                  Color(0xFFFFBD59)), // Icon for phone number
                          SizedBox(
                              width:
                                  5), // Add some spacing between the icon and text
                          Text(
                            '31466774',
                            style: const TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                              width:
                                  20), // Add some spacing between phone number and email
                          Icon(Icons.email,
                              color: Color(0xFFFFBD59)), // Icon for email
                          SizedBox(
                              width:
                                  5), // Add some spacing between the icon and text
                          Text(
                            'correo@gmail.com',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Text(
                        '${hotel.ciudDescripcion}, ${hotel.estaDescripcion}, ${hotel.paisDescripcion}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      const MyDivider(),
                      Text(
                        /*place.description ?? */ loremIpsumText,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, height: 1.5, color: Colors.white),
                      ),
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

class RatingRow extends StatelessWidget {
  const RatingRow({super.key, required this.rating});

  final double? rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.star,
          size: 20,
          color: Color(0xFFFFBD59),
        ),
        const SizedBox(width: 4),
        Text(
          rating.toString(),
          style:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ],
    );
  }
}

class CircularIconButton extends StatelessWidget {
  const CircularIconButton(
      {this.iconData,
      this.onPressed,
      this.iconColor = Colors.white,
      this.backgroundColor = Colors.black,
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
      color: const Color(0xFFFFBD59),
      padding: EdgeInsets.zero,
      splashRadius: 24,
      iconSize: iconSize,
      icon: Container(
        height: radius,
        width: radius,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
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
