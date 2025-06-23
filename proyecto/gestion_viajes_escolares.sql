-- CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE gestion_viajes_escolares;

-- LUGARES
CREATE TABLE Lugares (
    idLugar SERIAL PRIMARY KEY,
    CP INTEGER NOT NULL,
    noInterior VARCHAR(10),
    noExterior VARCHAR(10) NOT NULL,
    ciudad VARCHAR(30) NOT NULL,
    pais VARCHAR(30) NOT NULL,
    estado VARCHAR(30) NOT NULL,
    calle VARCHAR(30) NOT NULL
);

-- DESTINOS
CREATE TABLE Destinos (
    idDestino SERIAL UNIQUE,
    nombreEstablecimiento VARCHAR(50) NOT NULL,
    PRIMARY KEY(idDestino),
    FOREIGN KEY (idDestino) REFERENCES Lugares(idLugar)
);

-- ORIGENES
CREATE TABLE Origenes (
    idOrigen SERIAL UNIQUE,
    nombreEscuela VARCHAR(50) NOT NULL,
    PRIMARY KEY(idOrigen),
    FOREIGN KEY (idOrigen) REFERENCES Lugares(idLugar)
);

-- ESPECIALIDADES
CREATE TABLE Especialidades (
    idEspecialidad SERIAL PRIMARY KEY,
    especialidad VARCHAR(50) NOT NULL
);

-- DOCENTES
CREATE TABLE Docentes (
    idDocente SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    aPaterno VARCHAR(50) NOT NULL,
    aMaterno VARCHAR(50),
    idEspecialidad INTEGER NOT NULL,
    FOREIGN KEY (idEspecialidad) REFERENCES Especialidades(idEspecialidad)
);

-- TELEFONOS DE DOCENTES
CREATE TABLE TelefonoDocentes (
    idTelefonoDocente SERIAL PRIMARY KEY,
    idDocente INTEGER NOT NULL,
    telefono BIGINT NOT NULL,
    FOREIGN KEY (idDocente) REFERENCES Docentes(idDocente)
);

-- AUTORIZACIONES
CREATE TABLE Autorizaciones (
    idAutorizacion SERIAL PRIMARY KEY,
    fechaAutorizacion DATE NOT NULL,
    nombreTutor VARCHAR(50) NOT NULL,
    comentarios VARCHAR(100),
    estado VARCHAR(20) CHECK (estado IN ('Rechazado', 'Autorizado'))
);

-- TELEFONOS DE TUTORES
CREATE TABLE AutorizacionTelefono (
    idTelefonoTutor SERIAL PRIMARY KEY,
    idAutorizacion INTEGER NOT NULL,
    telefonoTutor BIGINT NOT NULL,
    FOREIGN KEY (idAutorizacion) REFERENCES Autorizaciones(idAutorizacion)
);

-- ESTUDIANTES
CREATE TABLE Estudiantes (
    idEstudiante SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    aPaterno VARCHAR(50) NOT NULL,
    aMaterno VARCHAR(50),
    idAutorizacion INTEGER NOT NULL UNIQUE,
    FOREIGN KEY (idAutorizacion) REFERENCES Autorizaciones(idAutorizacion)
);

-- PAGOS
CREATE TABLE Pagos (
    idPago SERIAL PRIMARY KEY,
    monto INTEGER,
    fechaPago DATE NOT NULL,
    idEstudiante INTEGER NOT NULL,
    FOREIGN KEY (idEstudiante) REFERENCES Estudiantes(idEstudiante)
);

-- GRUPOS
CREATE TABLE Grupos (
    idGrupo SERIAL PRIMARY KEY,
    grupo VARCHAR(10) NOT NULL UNIQUE
);

-- RELACIÓN GRUPO-ALUMNO
CREATE TABLE GrupoAlumno (
    idGrupo INTEGER NOT NULL,
    idEstudiante INTEGER NOT NULL,
    PRIMARY KEY (idGrupo, idEstudiante),
    FOREIGN KEY (idGrupo) REFERENCES Grupos(idGrupo),
    FOREIGN KEY (idEstudiante) REFERENCES Estudiantes(idEstudiante)
);

-- VIAJES
CREATE TABLE Viajes (
    idViaje SERIAL PRIMARY KEY,
    nombreViaje VARCHAR(50) NOT NULL,
    descripcion VARCHAR(100),
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    idDestino INTEGER NOT NULL UNIQUE,
    idOrigen INTEGER NOT NULL,
    FOREIGN KEY (idDestino) REFERENCES Destinos(idDestino),
    FOREIGN KEY (idOrigen) REFERENCES Origenes(idOrigen),
    CHECK (fechaFin > fechaInicio)
);

-- DETALLES DE VIAJE
CREATE TABLE DetallesViaje (
    idDetalle SERIAL PRIMARY KEY,
    costoTotal INTEGER NOT NULL,
    comentarios VARCHAR(100),
    idViaje INTEGER NOT NULL,
    idEstudiante INTEGER NOT NULL,
    FOREIGN KEY (idViaje) REFERENCES Viajes(idViaje),
    FOREIGN KEY (idEstudiante) REFERENCES Estudiantes(idEstudiante)
);

-- DOCENTES A CARGO DE VIAJES
CREATE TABLE DocentesACargo (
    idDetalle INTEGER NOT NULL,
    idDocente INTEGER NOT NULL,
    PRIMARY KEY (idDetalle, idDocente),
    FOREIGN KEY (idDetalle) REFERENCES DetallesViaje(idDetalle),
    FOREIGN KEY (idDocente) REFERENCES Docentes(idDocente)
);