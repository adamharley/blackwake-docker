FROM debian:stable-slim
LABEL maintainer="Adam Harley"

# Expose default ports
EXPOSE 25001/udp
EXPOSE 26915/udp
EXPOSE 27015/udp

# Disable Wine debug output
ENV WINEDEBUG -all

# Install SteamCMD and necessary packages
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
		ca-certificates \
		curl \
		lib32gcc1 \
		xauth \
		xvfb \
		wine && \
	mkdir /steamcmd && \
	curl -sqL https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -C /steamcmd -zxf - && \
	apt-get remove -y curl && \
	apt-get autoremove -y && \
	apt-get clean && \
    /steamcmd/steamcmd.sh +login anonymous +quit && \
	rm -rf ~/.steam ~/Steam /tmp/* /var/lib/apt/lists/*

# Set working directory
WORKDIR /blackwake

# Download Blackwake server
RUN /steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType windows +login anonymous +force_install_dir /blackwake +app_update 423410 validate +quit && \
	rm -rf ~/.steam ~/Steam /tmp/*

CMD xvfb-run -a wine ./BlackwakeServer.exe -batchmode -logFile - -nographics