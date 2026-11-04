import 'package:flutter/material.dart';

///Tipos  de hotel en Canarias. Cada uno tiene su texto y su icono Material.
enum HotelType {
  beach(label: 'Hotel de playa', icon: Icons.beach_access),
  rural(label: 'Hotel rural', icon: Icons.park),
  urban(label: 'Hotel urbano', icon: Icons.location_city),
  mountain(label: 'Hotel de montaña', icon: Icons.landscape);

  const HotelType({required this.label, required this.icon});

  final String label; // Texto que se muestra
  final IconData icon; // Icono del selector y de la tarjeta del fichaje
}