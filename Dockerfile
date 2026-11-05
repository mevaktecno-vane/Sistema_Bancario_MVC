# 1. Imagen base oficial de Python
FROM python:3.11-slim

# 2. Evitar que Python escriba archivos .pyc y forzar buffer directo en logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 3. Directorio de trabajo dentro del contenedor
WORKDIR /app

# 4. Copiar e instalar dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar todo el proyecto al contenedor
COPY . .

# 6. Exponer el puerto por defecto de Flet web (si aplica)
EXPOSE 8550

# 7. Comando de inicio de la aplicación
CMD ["python", "main.py"]