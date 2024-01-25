class Usuarios {
  final String nombre_usuario;
  final String edad;
  final List<String> juegos;
  final String rango;
  final String pais;

  Usuarios ({
      required this.nombre_usuario,
      required this.edad,
      required this.juegos,
      required this.rango,
      required this.pais,
      });
}

class DatosPerfil {
  final String nombre;
  final String descripcion;
  DatosPerfil({required this.nombre, required this.descripcion});
}
