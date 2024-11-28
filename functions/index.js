/* eslint-disable require-jsdoc */
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const firestore = admin.firestore();

function calculateDistance(lat1, lon1, lat2, lon2) {
  const R = 6371;
  const dLat = ((lat2 - lat1) * Math.PI) / 180;
  const dLon = ((lon2 - lon1) * Math.PI) / 180;
  const a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos((lat1 * Math.PI) / 180) *
      Math.cos((lat2 * Math.PI) / 180) *
      Math.sin(dLon / 2) *
      Math.sin(dLon / 2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  return R * c;
}

exports.findNearbyRides = functions.https.onCall(async (data, context) => {
  const {originLat, originLng, destLat, destLng, travelDate} = data;
  const maxDistance = 10; // 10 km radius

  try {
    const ridesQuery = await firestore
        .collection("rides")
        .where("travelDate", ">=", new Date(travelDate))
        .where("availableSeats", ">", 0)
        .get();

    const matchedRides = ridesQuery.docs
        .filter((ride) => {
          const rideData = ride.data();
          const originDistance = calculateDistance(
              originLat,
              originLng,
              rideData.origin.latitude,
              rideData.origin.longitude,
          );

          const destDistance = calculateDistance(
              destLat,
              destLng,
              rideData.destination.latitude,
              rideData.destination.longitude,
          );

          return originDistance <= maxDistance && destDistance <= maxDistance;
        })
        .map((ride) => ({
          id: ride.id,
          ...ride.data(),
        }));

    return {
      success: true,
      rides: matchedRides,
    };
  } catch (error) {
    console.error("Error finding nearby rides:", error);
    return {
      success: false,
      error: error.message,
    };
  }
});
