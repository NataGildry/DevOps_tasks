# Multi-Container Docker Application

This project demonstrates a multi-container application using `docker-compose`, with a setup that includes Nginx as a web server, PostgreSQL as a database, and Redis as a caching service.

## Setup Instructions

### 1. Clone the Repository

```bash
git clone <path_to_repo>
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
services:
  web:
    image: nginx
    volumes:
      - web-data:/usr/share/nginx/html  # Serve static content from the web-data volume
      - ./nginx_conf/default.conf:/etc/nginx/conf.d/default.conf
    networks:
      - appnet
    deploy:
      replicas: 3
    # No ports needed here as they will be accessed through the reverse proxy

  reverse_proxy:
    image: nginx:latest
    volumes:
      - ./nginx_conf/reverse_proxy.conf:/etc/nginx/conf.d/reverse_proxy.conf
    networks:
      - appnet
    ports:
      - "8080:80"  # Expose port 8080 to access the reverse proxy from outside

  db:
    image: postgres  
    environment:
      POSTGRES_USER: postgres        
      POSTGRES_PASSWORD: 1234  
      POSTGRES_DB: dev_db  
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
  appnet:  # Custom network for the application services

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

Create a file named `reverse_proxy.conf` in the `nginx_conf` directory with the following content:

```nginx
server {
    listen 80;
    listen [::]:80;  # Listen on both IPv4 and IPv6
    server_name localhost; 

    location / {
        proxy_pass http://web/;  # Forward requests to the 'web' service
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Using a reverse proxy with your Docker Compose setup for the task of scaling web server provides several advantages, particularly in the context of managing multiple instances of the web service.

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
![docker-compose up -d --scale web=3](![docker-compose up -d --scale web=3](image-5.png))

## Conclusion

This setup allows us to run a multi-container application with Nginx, PostgreSQL, and Redis using Docker.