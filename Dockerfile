# Latest Ubuntu LTS
FROM ghcr.io/selkies-project/nvidia-egl-desktop:24.04-20251011075504

ARG DEBIAN_FRONTEND=noninteractive

ENV WINEPREFIX="/home/ubuntu/wineprefix"
ENV WINEDLLOVERRIDES="mscoree,mshtml="
ENV WINEDEBUG="-all"

# Install all the required packages not included in base image
RUN sudo apt update
RUN sudo apt install -y software-properties-common wget
#RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN sudo dpkg --add-architecture i386
RUN mkdir -pm755 /etc/apt/keyrings
RUN sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
RUN sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources
RUN sudo apt update
RUN sudo apt-get install -y ca-certificates gnupg curl winehq-stable mangohud

RUN sudo rm -rf /var/lib/apt/lists/*

# Cleanup
RUN sudo apt autoremove -y

# Copy MangoHud config
COPY mangohud/MangoHud.conf /home/ubuntu/.config/MangoHud/MangoHud.conf

# Copy nvidia libraries for wine
COPY --chown=1000:1000 nvidia /home/ubuntu/nvidia
RUN sudo chmod +x /home/ubuntu/nvidia/setup_nvlibs.sh

# Set permissions for wineprefix
RUN mkdir /home/ubuntu/wineprefix
RUN chown -R 1000:1000 /home/ubuntu/wineprefix
RUN rm -rf /home/ubuntu/wineprefix/*

# Entrypoint
COPY --chown=1000:1000 entrypoint.sh /entrypoint.sh
COPY --chown=1000:1000 run_app.sh /run_app.sh
COPY --chown=1000:1000 create_wineprefix.sh /home/ubuntu/create_wineprefix.sh
RUN sudo chmod +x /entrypoint.sh
RUN sudo chmod +x /run_app.sh
ENTRYPOINT ["/entrypoint.sh"]

# Sensible defaults
ENV NVIDIA_DRIVER_CAPABILITIES=all \
    NVIDIA_VISIBLE_DEVICES=all \
    DISPLAY=:1

