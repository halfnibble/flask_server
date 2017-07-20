# Build with docker build -t flask .
FROM ubuntu:xenial

# Update and install
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    uwsgi-plugin-python3 \
    uwsgi \
    nginx \
    supervisor
RUN pip3 install --upgrade pip

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# Make NGINX run on the foreground
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Remove default configuration from Nginx
RUN rm /etc/nginx/sites-enabled/default

# Copy the modified Nginx conf
COPY nginx.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

# Copy the base uWSGI ini file to enable default dynamic uwsgi process number
COPY uwsgi.ini /etc/uwsgi/

# Custom Supervisord config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy over app
WORKDIR /app

EXPOSE 80

CMD pip3 install -r /app/requirements.txt && \
    /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf