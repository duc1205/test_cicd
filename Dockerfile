# Install dependencies
FROM instrumentisto/flutter:3.19.6 AS build

ARG ENV

# Copy the app files
COPY . /package/webapp
WORKDIR /package/webapp

# Get App Dependencies
RUN flutter pub get

# Generate Env
# RUN flutter pub run build_runner build --delete-conflicting-outputs

RUN echo $ENV

# Build the app for the web (release)
RUN flutter build web --release --dart-define=ENV=$ENV

FROM nginx:1.21.1-alpine

# Set capabilities to allow Nginx to bind to privileged ports
RUN apk add --no-cache libcap && \
    setcap 'cap_net_bind_service=+ep' /usr/sbin/nginx && \
    apk del libcap

RUN rm /etc/nginx/conf.d/default.conf

COPY --from=build /package/webapp/.docker/nginx/site.conf /etc/nginx/conf.d/default.conf

COPY --from=build /package/webapp/build/web/ /var/www/html/

RUN chown -R nginx:nginx /var/cache/nginx && \
        chown -R nginx:nginx /var/log/nginx && \
        chown -R nginx:nginx /etc/nginx/conf.d
RUN touch /var/run/nginx.pid && \
        chown -R nginx:nginx /var/run/nginx.pid

USER nginx
