# Terceros — Sistema de Gestión de Pagos a Proveedores

## Descripción

Aplicación web desarrollada para la administración de pagos a proveedores (terceros) por parte de una facultad. Permite gestionar facultades, proveedores, facturas y pagos mediante interfaces CRUD, con autenticación de usuarios y control de acceso.

Trabajo práctico final de **Programación III** — **UTN · FRP (Facultad Regional Paraná)**.

### Alumnos

- **Vinzon, Eric Alan**
- **Almarante, Manuel**

### Docentes

- **Zapata Icart, Ernesto A.**
- **Carpio, Mariano**
- **Schönals-Fischer, Rodolfo**


<div align="center">

![Java](https://img.shields.io/badge/Java-21-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring_Boot-4.0.6-6DB33F?style=for-the-badge&logo=spring-boot&logoColor=white)
![Vaadin](https://img.shields.io/badge/Vaadin-25.1.6-00B4F0?style=for-the-badge&logo=vaadin&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Maven](https://img.shields.io/badge/Maven-Wrapper-C71A36?style=for-the-badge&logo=apache-maven&logoColor=white)
![Hibernate](https://img.shields.io/badge/Hibernate-6.x-59666C?style=for-the-badge&logo=hibernate&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Supported-2496ED?style=for-the-badge&logo=docker&logoColor=white)

</div>



## Consigna

El objetivo es desarrollar una aplicación web completa (**frontend**, **backend** y **base de datos**) utilizando:


| Capa          | Tecnología     |
| ------------- | --------------- |
| Frontend      | **Vaadin Flow** |
| Backend       | **Spring Boot** |
| Base de datos | **PostgreSQL**  |

### Opción base

- Restaurar la base de datos (estructura + datos)
- Crear un proyecto Vaadin 25+
- Interfaz para crear / actualizar datos de la Facultad
- CRUD de Proveedores (Terceros)
- CRUD de Facturas (con ítems, vinculadas a un tercero)
- CRUD de Pagos (con detalles, vinculados a un tercero)

### Opción avanzada

- Tabla de usuarios con control de acceso (login / registro)

---

## Funcionalidades


| Funcionalidad | Ruta        | Descripción                                                                    |
| ------------- | ----------- | ------------------------------------------------------------------------------- |
| Inicio        | `/`         | Pantalla de bienvenida                                                          |
| Login         | `/login`    | Inicio de sesión con usuario y contraseña                                     |
| Registro      | `/register` | Registro de nuevo usuario                                                       |
| CRUD Facultad | `/facultad` | Alta, baja, modificación y consulta de facultades                              |
| CRUD Terceros | `/tercero`  | CRUD de proveedores (nombre, CUIT, situación IVA, dirección, saldo)           |
| CRUD Facturas | `/factura`  | CRUD de facturas con ítems, vinculadas a un tercero                            |
| CRUD Pagos    | `/pago`     | CRUD de pagos con detalles (instrumento, banco, fecha), vinculados a un tercero |

## Seguridad

El proyecto utiliza autenticación **custom** (sin Spring Security completo). Mecanismo:

- **Registro:** `RegisterView` permite crear un usuario. La contraseña se hashea con **BCrypt** (`spring-security-crypto`).
- **Login:** `LoginView` verifica usuario y contraseña contra la base de datos.
- **Sesión:** El usuario autenticado se guarda como atributo de `VaadinSession` mediante `SeguridadUtils`.
- **Protección de rutas:** `ConfigurarInicioUIListener` (un `VaadinServiceInitListener`) intercepta la navegación y redirige a `/login` si no hay sesión activa. Las rutas `/login` y `/register` son públicas.
- **Logout:** Botón *"Cerrar Sesión"* en el layout principal que limpia la sesión y redirige al login.

## Estructura del proyecto

```
src/main/java/utn/frp/comp/terceros/
├── Application.java                    # Punto de entrada Spring Boot + Vaadin
├── model/                              # Entidades JPA
│   ├── Facultad.java
│   ├── Tercero.java
│   ├── Factura.java
│   ├── Item.java
│   ├── Pago.java
│   ├── PagoDetalle.java
│   └── Usuario.java
├── repositorios/                       # Repositorios Spring Data JPA
│   ├── FacultadRepository.java
│   ├── TerceroRepository.java
│   ├── FacturaRepository.java
│   ├── PagoRepository.java
│   └── UsuarioRepository.java
├── servicios/                          # Lógica de negocio
│   └── UsuarioService.java
├── seguridad/                          # Autenticación y control de acceso
│   ├── ConfigurarInicioUIListener.java
│   ├── PasswordConfig.java
│   └── SeguridadUtils.java
├── ui/                                 # Componentes de layout
│   └── MainLayout.java
└── views/                              # Vistas Vaadin (interfaces CRUD)
    ├── HomeView.java
    ├── LoginView.java
    ├── RegisterView.java
    ├── FacultadView.java
    ├── TerceroView.java
    ├── FacturaView.java
    └── PagoView.java
```

---

## Base de datos

### Esquema de entidades y relaciones

```
Facultad           (independiente)

Tercero ──1:N──> Factura
                   └──1:N──> Item

Tercero ──1:N──> Pago
                   └──1:N──> PagoDetalle

Usuario            (independiente, para autenticación)
```

### Restaurar la base de datos

El proyecto incluye un dump de PostgreSQL con la estructura y datos iniciales.

1. Crear la base de datos y el usuario:

   ```sql
   CREATE DATABASE terceros01;
   CREATE USER terceros01 WITH PASSWORD '654321';
   GRANT ALL PRIVILEGES ON DATABASE terceros01 TO terceros01;
   ```
2. Restaurar el dump:

   ```bash
   psql -U terceros01 -d terceros01 -f dump-terceros01-202606241822.sql
   ```

La configuración de conexión está en `application.properties`:

```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/terceros01
spring.datasource.username=terceros01
spring.datasource.password=654321
spring.jpa.hibernate.ddl-auto=update
```

## Requisitos


| Herramienta | Versión                                      |
| ----------- | --------------------------------------------- |
| Java        | 21 o superior                                 |
| PostgreSQL  | 14+ corriendo en`localhost:5432`              |
| Maven       | Wrapper incluido (no requiere instalar Maven) |

## Ejecución

### Modo desarrollo

```bash
./mvnw
```

Inicia la aplicación en `http://localhost:8080` y abre el navegador automáticamente.

