# Dockerfile for a TShock Terraria Server
# https://github.com/PanIntegralus/docker-tshock
FROM mono:latest
MAINTAINER PanIntegralus <pablikoxyt@gmail.com>

# Install unzip package
RUN apt-get -qq update && \
    apt-get -qqy install unzip

ENV TSHOCK_VERSION=4.5.16
ENV TERRARIA_VERSION=1.4.3.6

# Download and setup TShock
RUN curl -sL https://github.com/Pryaxis/TShock/releases/download/v${TSHOCK_VERSION}/TShock${TSHOCK_VERSION}_Terraria${TERRARIA_VERSION}.zip > /tmp/tshock.zip && \
    unzip /tmp/tshock.zip -d /opt/tshock

COPY config.json /opt/tshock/tshock/config.json


# Start the server and expose the port
EXPOSE 7777 7878
WORKDIR /opt/tshock
ENTRYPOINT ["mono", "--server", "--gc=sgen", "-O=all", "TerrariaServer.exe"]
CMD ["-world", "Terraria/Worlds/Default.wld", "-autocreate", "2"]
