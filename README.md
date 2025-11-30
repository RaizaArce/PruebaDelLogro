# Sistema de Gestión de Denuncias

Aplicación web para el registro, consulta y actualización de denuncias ciudadanas.  
Proyecto desarrollado como parte de la evaluación **P01-ED03 – PRUEBA DE NIVEL DEL LOGRO DE COMPETENCIAS - SIS – VIII**.

---

## 1. Stack tecnológico utilizado

- Lenguaje backend: **Java (JDK 25)**
- IDE: **Apache NetBeans 27**
- Servidor de aplicaciones: **Apache Tomcat 10.1.49**
- Tecnología web: **JSP (JavaServer Pages)**
- Acceso a datos: **JDBC** (driver de Microsoft SQL Server)
- Base de datos: **Microsoft SQL Server Express 2022**
- Frontend: **HTML5 y CSS3** (diseño centralizado en `css/estilos.css`)


---

## 2. Estructura del proyecto

Estructura principal (según NetBeans):

- `Web Pages/`
  - `Login.jsp` – Página de autenticación.
  - `LoginProcesar.jsp` – Valida credenciales y crea la sesión.
  - `Logout.jsp` – Cierra sesión y redirige a Login.
  - `Dashboard.jsp` – Página principal después del login.
  - `index.jsp` – Formulario para registrar una nueva denuncia.
  - `DenunciasLista.jsp` – Listado de denuncias (tabla).
  - `DenunciaGuardar.jsp` – Recibe el formulario y guarda una nueva denuncia.
  - `DenunciaEditar.jsp` – Formulario para editar una denuncia existente.
  - `DenunciaActualizar.jsp` – Actualiza la denuncia en base de datos.
  - `DenunciaEliminar.jsp` – Elimina una denuncia por id.
  - `css/estilos.css` – Hoja de estilos principal (login, formularios, tablas, responsive).

- `src/java/`
  - `model/`
    - `Denuncia.java` – Clase de entidad que representa la tabla de denuncias.
  - `dao/`
    - `DenunciaDAO.java` – Clase de acceso a datos (CRUD de denuncias: insertar, listar, actualizar, eliminar).
  - `conexion/` (nombre orientativo)
    - `Conexion.java` – Clase que administra la conexión JDBC a SQL Server Express.

- `database/` 
  - Script SQL con:
    - Creación de la base de datos.
    - Creación de la tabla `denuncia`.
    - (Opcional) Inserción de datos de prueba.

---

## 3. Funcionamiento de la aplicación

1. Login
   - El usuario accede a `Login.jsp`.
   - El formulario envía los datos a `LoginProcesar.jsp`.
   - Si las credenciales son correctas, se crea el atributo de sesión `usuarioLogueado` y se redirige a `Dashboard.jsp`.
   - Si son incorrectas, se redirige a `Login.jsp?error=1` y se muestra un mensaje de error estilizado.

2. Registro de denuncia
   - Desde el dashboard o la barra superior se accede a `index.jsp`.
   - El usuario completa el formulario (título, descripción, ubicación, estado, datos del ciudadano).
   - El formulario envía los datos a `DenunciaGuardar.jsp`, que:
     - Crea un objeto `Denuncia`.
     - Llama a `DenunciaDAO.insertar(...)`.
     - Muestra un mensaje de éxito y botones para registrar otra denuncia o ir al listado.

3. Listado de denuncias
   - `DenunciasLista.jsp` muestra todas las denuncias en una tabla.
   - Cada fila tiene acciones para:
     - Editar → `DenunciaEditar.jsp?id=...`
     - Eliminar → `DenunciaEliminar.jsp?id=...`

4. Edición y actualización
   - `DenunciaEditar.jsp`:
     - Recibe el `id` por parámetro.
     - Usa `DenunciaDAO.obtenerPorId(id)` para precargar los datos en el formulario.
   - Al enviar el formulario, `DenunciaActualizar.jsp`:
     - Actualiza los datos en base de datos con `DenunciaDAO.actualizar(...)`.
     - Muestra un mensaje de confirmación.

5. Eliminación
   - `DenunciaEliminar.jsp` recibe el `id`, llama a `DenunciaDAO.eliminar(id)` y muestra un mensaje de confirmación.

6. Gestión de sesión
   - En todas las páginas protegidas se comprueba:
     - `if (session.getAttribute("usuarioLogueado") == null) { response.sendRedirect("Login.jsp"); }`
   - `Logout.jsp` invalida la sesión y redirige a `Login.jsp`.

---

## 4. Diseño y responsive (UI/UX)

El diseño de toda la aplicación se controla desde `css/estilos.css`:

- Fondo general en tonos claros para las páginas internas.
- Página de Login con fondo en gradiente morado, tarjeta centrada y animación.
- Componentes reutilizables:
  - Tarjetas: `.form-card`, `.card`.
  - Layout: `.form-container`, `.page-wrap`, `.top-bar`.
  - Formulario: `.form-header`, `.form-icon`, `.form-title`, `.form-subtitle`, `.form-grid`, `.form-row`, `.form-group`.
  - Campos: `.form-input`, `.form-textarea`, `.form-select`, `.form-label`.
  - Mensajes: `.mensaje-exito`, `.error-message`.
  - Botones: `.btn-submit`, `.btn-secondary`, `.btn-top`, `.btn-dashboard`, `.btn-logout`, `.btn-accion`, `.btn-accion-mod`, `.btn-accion-del`.
  - Tablas: estilos de `table`, `thead`, `tbody`, `th`, `td`.

- Responsive:
  - Media query para pantallas menores a 768px.
  - Formularios pasan a una sola columna.
  - Botones se apilan verticalmente.
  - Se reducen paddings y tamaños de fuente en tablas.

---

## 5. Conexión a SQL Server Express

La conexión a la base de datos se realiza mediante JDBC al servidor **SQL Server Express**.  
En la clase `Conexion.java` se configura:

- Driver JDBC de Microsoft SQL Server.
- URL JDBC con el servidor/instancia y puerto.
- Usuario y contraseña.

String url = "jdbc:sqlserver://Raiza\SQLEXPRESS;databaseName=DenunciasDB;encrypt=false";
String user = "sa";
String password = "dba";


Asegúrate de:
- Tener el driver `mssql-jdbc` agregado al classpath de tu proyecto.
- Tener SQL Server Express activo y accesible (puerto 1433 o el que corresponda).

---

## 6. Cómo ejecutar el proyecto

1. Clonar el repositorio

git clone <https://github.com/RaizaArce/PruebaDelLogro>


2. Importar en NetBeans 27
   - Abrir NetBeans.
   - Archivo → Abrir proyecto → seleccionar la carpeta del proyecto.

3. Configurar la base de datos (SQL Server Express)
   - Crear la base de datos en SQL Server Express.
   - Ejecutar el script SQL incluido en el proyecto (creación de BD y tabla `denuncia`).
   - Ajustar URL, usuario y contraseña en la clase de conexión JDBC.

4. Configurar servidor Tomcat 10.1.49
   - Agregar el servidor Apache Tomcat 10.1.49 en NetBeans.
   - Asociar el proyecto al servidor.

5. Desplegar y probar
   - Ejecutar el proyecto desde NetBeans.
   - Acceder en el navegador a:  
     http://localhost:8080/WebDenuncias/Login.jsp

6. Credenciales de prueba

Usuario: admin
Contraseña: 1234


*(Según lo definido en `LoginProcesar.jsp`.)*

---

## 7. Entregables del curso

En la entrega en el aula virtual se incluye:

- Archivo comprimido con:
  - Código fuente completo del proyecto.
  - Script de la base de datos (SQL Server Express).
- Link al repositorio de código fuente:  
  https://github.com/RaizaArce/PruebaDelLogro
- Link al video en YouTube (cámara encendida) explicando:
  - Stack tecnológico utilizado (Java, JSP, JDBC, SQL Server Express, Tomcat, NetBeans, etc.).
  - Estructura del proyecto (paquetes, JSP, CSS).
  - Funcionamiento de la aplicación web (demo: login, registro, listado, edición, eliminación, responsive).

