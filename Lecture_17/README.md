# Multi-Container Docker Application

This project demonstrates a multi-container application using `docker-compose`, with a setup that includes Nginx as a web server, PostgreSQL as a database, and Redis as a caching service.

## Project Structure

The directory structure of the project is as follows:

```
multi-container-app/
├── docker-compose.yml
├── web-data/
│   └── index.html
└── nginx_conf/
    └── default.conf
```

- `docker-compose.yml` - Defines the configuration for all services in the application.
- `web-data/index.html` - The HTML file served by Nginx.
- `nginx_conf/default.conf` - The Nginx configuration file.

## Setup Instructions

### 1. Clone the Repository

```bash
git clone <TODO>
cd Lecture_17
cd multi-container-app
```

### 2. Create Required Directories

Create the directories for web data and Nginx configuration:

```bash
mkdir web-data
mkdir nginx_conf
```

### 3. Create Docker Compose File

Create a `docker-compose.yml` file in the `multi-container-app` directory and add the following content:

```yaml
version: '3'
services:
  web:
    image: nginx
    volumes:
      - ./web-data:/usr/share/nginx/html
    ports:
      - "8080:80"
    networks:
      - appnet
  db:
    image: postgres
    volumes:
      - db-data:/var/lib/postgresql/data
    networks:
      - appnet
  cache:
    image: redis
    networks:
      - appnet
volumes:
  db-data:
  web-data:
networks:
  appnet:
```

### 4. Create Nginx Configuration File

Create a file named `default.conf` in the `nginx_conf` directory with the following content:

```nginx
server {
    listen 80;
    server_name localhost;

    location / {
        root /usr/share/nginx/html;
        index index.html;
    }
}
```

### 5. Create HTML File

Create an `index.html` file in the `web-data` directory with the following content:

```html
<!DOCTYPE html>
<html>
<head>
    <title>My Docker App</title>
</head>
<body>
    <h1>Hello from Docker!</h1>
</body>
</html>
```

### 6. Build and Run the Application

Navigate to the `multi-container-app` directory and run the following command:

```bash
docker-compose up -d
```

### 7. Check Application Status

To see the status of your running containers, use:

```bash
docker-compose ps
```

### 8. Access the Web Application

Open your browser and navigate to [http://localhost:8080](http://localhost:8080) to view your application.

### Screenshots

![Running app](![Screenshot of the running app](image.png))
![docker network ls](![docker network ls](image-1.png))
![docker volume ls](![docker volume ls](image-4.png))
![db connection](![db connection](image-3.png))

## Conclusion

This setup allows us to run a multi-container application with Nginx, PostgreSQL, and Redis using Docker.