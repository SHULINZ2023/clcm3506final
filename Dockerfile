# Use the httpd base image
FROM httpd:latest
# Set the working directory to Apache's document root
WORKDIR /var/www/html
# Copy the HTML file into the container at /var/www/html
COPY * /var/www/html/

