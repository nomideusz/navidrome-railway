FROM ghcr.io/navidrome/navidrome:0.63.2

# Single-service image for Railway: Navidrome (:4533) + Filebrowser (:8080)
# in one container sharing one volume — Railway volumes can't be shared across
# services and have no native upload path, so Filebrowser is the way music
# gets onto the volume.
USER root
ADD https://github.com/filebrowser/filebrowser/releases/download/v2.63.23/linux-amd64-filebrowser.tar.gz /tmp/fb.tar.gz
RUN tar -xzf /tmp/fb.tar.gz -C /usr/local/bin filebrowser && rm /tmp/fb.tar.gz

ENV ND_MUSICFOLDER=/data/music ND_DATAFOLDER=/data/navidrome

COPY railway-entrypoint.sh /railway-entrypoint.sh
RUN chmod +x /railway-entrypoint.sh

ENTRYPOINT ["/railway-entrypoint.sh"]
