# Imagen oficial de Flutter (más actualizada que cirrusci)
FROM ghcr.io/cirruslabs/flutter:stable

# Definimos el directorio de trabajo
WORKDIR /app

# Copiamos pubspec primero para cachear dependencias
COPY pubspec.* ./

# Descargar dependencias
RUN flutter pub get || true

# Copiamos el resto del proyecto
COPY . .

# Aseguramos que flutter esté en el PATH
ENV PATH="/flutter/bin:${PATH}"
# Copiamos el resto del proyecto

# Exponemos el puerto si vas a usar flutter web
EXPOSE 8080

# Entramos en bash por defecto
CMD ["/bin/bash"]
