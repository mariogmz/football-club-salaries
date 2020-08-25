# Football Clubs Salaries API

Este servicio calcula el salario completo basado en bonos y metas para equipos
de fútbol, expone una API JSON que está lista para recibir la información de los
miembros del equipo de fútbol y en base al rendimiento grupal e individual, cada
uno recibe un salario compuesto de un salario base más un bono.

Stack basado en un boilerplate hecho en un repositorio aparte
[https://github.com/mariogmz/grape-boilerplate](https://github.com/mariogmz/grape-boilerplate)

## Requisitos

- Ruby 2.7.1 con bundler
- Capacidad para generar llaves ssh

## Setup

Se puede tener Ruby instalado a nivel de sistema, o se puede usar un version
manager como [rbenv](https://github.com/rbenv/rbenv) ó [rvm](https://rvm.io/)
para instalar la versión necesaria.

```
# En la carpeta raíz del proyecto
$ rbenv use
$ gem install bundle
$ bundle install
```
Antes de continuar se necesitan tener ciertas configuraciones.

## Configuración

Se puede encontrar un archivo de ejemplo para la configuración en
`config/settings.yml.sample`, se puede copiar el archivo removiendo la extensión
`.sample` y reemplazar los valores necesarios.

```
$ cp config/settings.sample.yml config/settings.yml
```

### ENV

La configuración puede también ser definida usando variables de entorno,
estas estarán disponibles en el código a través del objeto `Settings`, pero
tendrán que se definidas usando la siguiente sintaxis:

```
SETTINGS__LOGS__PATH="tmp/logs"
```

Usando `__` (doble guión bajo) entre los namespaces y con el prefijo `SETTINGS`,
estas configuraciones tienen precedencia sobre las definidas en el archivo de
`config/settings.yml`, esto puede ayudar en la configuración en entornos donde
no se pueden acceder a estos archivos (como Heroku).

### JWT

Para la capa de autenticación en la API, se usa un mecanismo llamado
[JWT](https://www.jwt.io).

Para poder generar y desencriptar tokens de JWT se requiere configurar un par
de llaves RSA (una privada y una pública), para crearlas se puede correr el
archivo `jwtRS256.sh` incluído en la carpeta raíz del proyecto (funciona en
entornos Linux y OSX).

Para su configuración se puede:

1. Colocar directamente el valor de ambas llaves en los valores del archivo de
configuración:

```yaml
jwt:
  issuer: Sample Issuer
  beholder: Sample Audience
  private_key: |
    -----BEGIN RSA PRIVATE KEY-----
    AQUI VA TU LLAVE PRIVADA
    -----END RSA PRIVATE KEY-----
  public_key: |
    -----BEGIN PUBLIC KEY-----
    AQUI VA TU LLAVE PUBLICA
    -----END PUBLIC KEY-----
  expiration_time_minutes: 1440
```
2. Teniendo acceso a los archivos de llave y escribiendo sus rutas / urls en
el archivo de configuración (nótese que las entradas tienen un nombre distinto):

```yaml
jwt:
  issuer: Sample Issuer
  beholder: Sample Audience
  private_key_path: path_to_private_key_path
  public_key_url: path_to_public_key_path
  expiration_time_minutes: 1440
```

3. Usando variables de entorno:

```
SETTINGS__JWT__PRIVATE_KEY="your private key here"
SETTINGS__JWT__PUBLIC_KEY="your public key here"
```

## Desarrollo

Para facilidad de desarrollo se recomienda usar `guard`:

```
$ bundle exec guard
```

De otro modo se puede usar `bundle exec rackup` para ejecutar rack, de esta
manera cada cambio en código se verá reflejado reiniciando el servicio.

## Usando Docker

Se puede ejecutar la aplicación a través de un contenedor de docker:

```
$ docker build -t football-club-salaries .
$ docker run -p 3000:3000 football-club-salaries
```

La app estará accesible en http://localhost:3000/

Se puede también usar `docker-compose`:

```
$ docker-compose up
```

## Testing

El comando `rake` por default ejecuta `rubocop` y `minitest`

```
$ bundle exec rake test # sólo pruebas
$ bundle exec rake # linter y pruebas
```

Alternativamente para ejecutar pruebas individuales se puede ejecutar:

```
$ bundle exec m test/ruta_de_tu_prueba/some_test.rb
```

## API & Rutas

La API disponible en la aplicación puede ser versionada para futuros cambios,
por ahora se encuentra disponible la `v1`, junto con rutas adicionales para
autenticarse y obtener el token JWT.

Para ver la lista de rutas:

```
$ bundle exec rake routes

      POST       /api/login
      POST       /api/:version/salaries
      GET        /swagger_doc
      GET        /swagger_doc/:name
      *          /*path
```

## Documentación

La documentación de la API es generada usando Swagger, para obtener el schema
de la documentación:

```
GET        /swagger_doc
```

El resultado de la consulta se puede visualizar usando
[Swagger UI](https://editor.swagger.io/)

## ¿Cómo usar la API?

Antes de poder consultar la API se debe autenticar y obtener un token JWT, la
ruta es

```
POST       /api/login
```
Se obtendrá una respuesta JSON como la siguiente:

```json
{
    "status": "success",
    "data": {
        "user": "mariogomezmtz",
        "jwt": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ1c2VybmFtZSI6Im1hcmlvZ29tZXptdHoiLCJleHAiOjE2MDM1MDI0MzIsImlzcyI6IlNhbXBsZSBJc3N1ZXIiLCJhdWQiOiJTYW1wbGUgQXVkaWVuY2UifQ.dmvR4oqwtdSprSWqYeFw0j5hRBk7LYn4U14qEmvlglyUiVP9gXLaH929MnHeIa3grNOPQGsEmi1_Reak7t9CObqlVw3Pwp5_sLBl7UsFFjWCcTeIzv2MgB0eVShA8IUby_Bdbc9EZ-OlC3rVH1A2m4nwN_a6SgN8LNXoNeFA9otoBLK_UazHanvaPiNT8I6YL0CxDQs2F7Wx_czcTEVZES0Lst_1qNBrDKIJ3KznDAyliJJsH9XUNOzBordiK3IQx9UUKXnEwq9yKlk7eJI5RXVldmNfN6CITP7jZi3jM3yk0N7joOQJBlHYSvLZWhmLMJzU3n8eCIN5JPiXQwqy7AM2BEB1lxQDkRvvsGwUI4DgLOz8YHxjtI5A4O75xlYoEY-KujU5T8vVev2_m5J0Ww18NO66en8_cz8ZHEIaDhBpb3ET7BUNqV3rCZt8jUUeEdr1VL6O2FaYqUeFIAUZxA39OBvQCPN8wuzXwSjNnnLhCLkL04n84tYlEgooSqwKvwzHHdB8aa47S8iPZ36K3hPmsb1vsIdPukrHkBGD7_XUtLypeY-gmbGfite1pETCY8jxQcSTQHvxLq8eE5_i4wdF5jkZmEiaAzraqCfelbp-UptqHv6As_4SiZDJkZH-Jma8xlCVO-_XimzHzSiMRbG8wdJsaKwOPpvj2Y2lfTw"
    }
}
```

El token se encuentra dentro de el namespace de `data.jwt`.

Una vez que se tiene el token JWT, debe incluirse en los headers de las
peticiones a la API usando el header de `Authorization` con un valor de
`Bearer TOKEN_JWT`.

El token tiene una expiración configurable en la app, también se puede modificar
la identidad incluida en el payload según se necesite.

## Demo

La app está disponible en Heroku:

1. Para hacer login hacer un `POST`:

```
https://fc-club-salaries.herokuapp.com/api/login
```

El endpoint espera un body:

```
username: mariogomezmtz
password: test123!
```

2. Una vez que se obtenga el token y se haya incluido en el `Authorization`
header, se puede hacer `POST` a:

```
https://fc-club-salaries.herokuapp.com/api/v1/salaries
```

Ejemplos de `body` para las peticiones:

1. Lista de jugadores solamente:

```json
{
   "jugadores": [
      {
         "nombre":"Juan Perez",
         "nivel":"C",
         "goles":10,
         "sueldo":50000,
         "bono":25000,
         "sueldo_completo":null,
         "equipo":"rojo"
      },
      {
         "nombre":"EL Cuauh",
         "nivel":"Cuauh",
         "goles":30,
         "sueldo":100000,
         "bono":30000,
         "sueldo_completo":null,
         "equipo":"azul"
      },
      {
         "nombre":"Cosme Fulanito",
         "nivel":"A",
         "goles":7,
         "sueldo":20000,
         "bono":10000,
         "sueldo_completo":null,
         "equipo":"azul"
      },
      {
         "nombre":"El Rulo",
         "nivel":"B",
         "goles":9,
         "sueldo":30000,
         "bono":15000,
         "sueldo_completo":null,
         "equipo":"rojo"
      }
   ]
}

```

2. Lista de jugadores con metas específicas por equipo:

```json
{
   "jugadores": [
      {
         "nombre":"Juan Perez",
         "nivel":"C",
         "goles":10,
         "sueldo":50000,
         "bono":25000,
         "sueldo_completo":null,
         "equipo":"rojo"
      },
      {
         "nombre":"EL Cuauh",
         "nivel":"Cuauh",
         "goles":30,
         "sueldo":100000,
         "bono":30000,
         "sueldo_completo":null,
         "equipo":"azul"
      },
      {
         "nombre":"Cosme Fulanito",
         "nivel":"A",
         "goles":7,
         "sueldo":20000,
         "bono":10000,
         "sueldo_completo":null,
         "equipo":"azul"
      },
      {
         "nombre":"El Rulo",
         "nivel":"B",
         "goles":9,
         "sueldo":30000,
         "bono":15000,
         "sueldo_completo":null,
         "equipo":"rojo"
      }
   ],
   "equipos": [
     {
       "nombre": "rojo",
       "metas": [
         { "nivel": "A", "goles": 5 },
         { "nivel": "B", "goles": 10 },
         { "nivel": "C", "goles": 15 },
         { "nivel": "Cuauh", "goles": 20 }
       ]
     },
     {
       "nombre": "azul",
       "metas": [
         { "nivel": "A", "goles": 10 },
         { "nivel": "B", "goles": 17 },
         { "nivel": "C", "goles": 20 },
         { "nivel": "Cuauh", "goles": 22 }
       ]
     }
   ]
}

```

Nótese que se pueden cambiar los niveles como se necesite.
