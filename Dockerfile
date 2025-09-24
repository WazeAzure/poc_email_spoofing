FROM ubuntu:22.04

# Install Postfix
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y postfix && \
    # Ensure proper Postfix spool directories
    mkdir -p /var/spool/postfix/{active,bounce,corrupt,defer,deferred,flush,incoming,private,public,saved,maildrop} && \
    chown -R postfix:postdrop /var/spool/postfix && \
    chmod -R 755 /var/spool/postfix

# Copy custom Postfix configuration
COPY postfix/main.cf /etc/postfix/main.cf

EXPOSE 587

# Run Postfix in foreground
CMD ["postfix", "start-fg"]

