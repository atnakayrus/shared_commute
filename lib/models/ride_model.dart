class Ride {
  final String id;
  final String userId;
  final String origin;
  final String destination;
  final String originAddress;
  final String destinationAddress;
  final DateTime createdAt;
  final DateTime travelDate;
  final int availableSeats;

  Ride({
    required this.id,
    required this.userId,
    required this.origin,
    required this.destination,
    required this.originAddress,
    required this.destinationAddress,
    required this.createdAt,
    required this.travelDate,
    required this.availableSeats,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'origin': origin,
        'destination': destination,
        'originAddress': originAddress,
        'destinationAddress': destinationAddress,
        'createdAt': createdAt,
        'travelDate': travelDate,
        'availableSeats': availableSeats,
      };

  factory Ride.fromJson(Map<String, dynamic> json) => Ride(
        id: json['id'],
        userId: json['userId'],
        origin: json['origin'],
        destination: json['destination'],
        originAddress: json['originAddress'],
        destinationAddress: json['destinationAddress'],
        createdAt: json['createdAt'].toDate(),
        travelDate: json['travelDate'].toDate(),
        availableSeats: json['availableSeats'],
      );
}
