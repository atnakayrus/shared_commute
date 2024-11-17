import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/controllers/location/location_controller.dart';
import 'package:shared_commute/models/address.dart';
import 'package:shared_commute/services/geocoding_service.dart';
import 'package:shared_commute/views/widgets/sc_icon_button.dart';
import 'package:shared_commute/views/widgets/sc_text_input.dart';

class MapLayover extends StatefulWidget {
  final TextEditingController originController;
  final TextEditingController destController;
  final Function(Address) setSource;
  final Function(Address) setDest;

  const MapLayover(
      {super.key,
      required this.originController,
      required this.destController,
      required this.setSource,
      required this.setDest});

  @override
  State<MapLayover> createState() => _MapLayoverState();
}

class _MapLayoverState extends State<MapLayover> {
  bool showSourceSuggestions = false;
  bool showDestSuggestions = false;

  List<Address> suggestions = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white54,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ScIconButton(
                            onPressed: () {},
                            icon: Icons.person_pin_circle_rounded),
                        Expanded(
                          child: ScTextInput(
                            controller: widget.originController,
                            width: double.infinity,
                            height: 50,
                            bgColor: Colors.white,
                            hintText: 'Select origin',
                            onChanged: (text) async {
                              if (text != '') {
                                final newSuggestions = await GeocodingService()
                                    .getSuggestions(text);
                                setState(() {
                                  suggestions = newSuggestions;
                                });
                              } else {
                                suggestions = [];
                              }
                            },
                            onSumbitted: (text) {},
                            onTap: () {
                              setState(() {
                                showSourceSuggestions = true;
                                showDestSuggestions = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                      child: Text('--- TO ---'),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ScIconButton(onPressed: () {}, icon: Icons.location_on),
                        Expanded(
                          child: ScTextInput(
                            controller: widget.destController,
                            width: double.infinity,
                            height: 50,
                            bgColor: Colors.white,
                            hintText: 'Select Destination',
                            onChanged: (text) async {
                              if (text != '') {
                                final newSuggestions = await GeocodingService()
                                    .getSuggestions(text);
                                setState(() {
                                  suggestions = newSuggestions;
                                });
                              } else {
                                suggestions = [];
                              }
                            },
                            onSumbitted: (text) {},
                            onTap: () {
                              setState(() {
                                showSourceSuggestions = false;
                                showDestSuggestions = true;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              if (showDestSuggestions || showSourceSuggestions)
                GestureDetector(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    LatLng latLng = LocationController().getUserLocation;
                    Address address = await GeocodingService()
                        .getAddressByLatLng(latLng.latitude, latLng.longitude);
                    if (showSourceSuggestions) {
                      widget.setSource(address);
                      widget.originController.text = address.formattedAddress!;
                    } else {
                      widget.setDest(address);
                      widget.destController.text = address.formattedAddress!;
                    }
                    setState(() {
                      showDestSuggestions = false;
                      showSourceSuggestions = false;
                      suggestions = [];
                    });
                  },
                  child: const SuggestionsTile(title: 'Your Location'),
                ),
              if ((showDestSuggestions || showSourceSuggestions) &&
                  suggestions.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        if (showSourceSuggestions) {
                          widget.setSource(suggestions[index]);
                        } else {
                          widget.setDest(suggestions[index]);
                        }
                        setState(() {
                          FocusScope.of(context).unfocus();
                          if (showSourceSuggestions) {
                            widget.originController.text =
                                suggestions[index].formattedAddress!;
                          } else if (showDestSuggestions) {
                            widget.destController.text =
                                suggestions[index].formattedAddress!;
                          }
                          showSourceSuggestions = false;
                          showDestSuggestions = false;
                          suggestions = [];
                        });
                      },
                      child: SuggestionsTile(
                          title: suggestions[index].formattedAddress!)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuggestionsTile extends StatelessWidget {
  final String title;
  const SuggestionsTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey[800]!),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
      child: Text(
        title,
        style: Appstyle().contentText,
        maxLines: 3,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
