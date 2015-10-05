# Kimkëlen API

**API Kimkëlen** provee servicios para obtener información estudiantes y tutores del sistema de gestión integrada de colegios secundarios realizado por el [CeSPI](http://www.cespi.unlp.edu.ar/) perteneciente a la  [Universidad Nacional de La Plata UNLP](http://www.unlp.edu.ar/).
Los servicios permitirán acceso de consulta a inasistencias, sanciones disciplinarias y calificaciones.

# Instalación

## Editar la configuración de la base de datos

La configuración de la base de datos se realiza por medio del archivo
`database.yml`. Se provee este archivo a modo de ejemplo en
el directorio `config/`

```
cp config/database.yml-sample config/database.yml
```

Edite este archivo según la configuración de su entorno. Debe especificar el dsn (nombre de la base de datos, host, usuario de la BBDD y contraseña de la BBDD)

## Ejemplo de `database.yml`

```yml
....
development:
  database: alumnos
  adapter:  mysql2
  encoding: utf8
  pool:     5
  username: user
  password: beSAfePlease
  host:     localhost