# build:
#  docker build -t baroka/idrive .

FROM ubuntu:latest

RUN mkdir -p /home/backup

WORKDIR /work

# Copy entrypoint script
COPY entrypoint.sh .
RUN chmod a+x entrypoint.sh

# Install packages
# iproute2 for /bin/ip, which is used to find/generate a unique host ID
RUN apt-get update && apt-get -y install vim unzip curl libfile-spec-native-perl iproute2

# Timezone (no prompt)
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
#RUN echo "Europe/Madrid" > /etc/timezone
#RUN rm -f /etc/localtime
#RUN dpkg-reconfigure -f noninteractive tzdata

# Install IDrive
# Runs also at each entrypoint run
#RUN curl -O https://www.idrivedownloads.com/downloads/linux/download-for-linux/IDriveForLinux.zip && \
#    unzip IDriveForLinux.zip && rm IDriveForLinux.zip

WORKDIR /work/IDriveForLinux/scripts

# Give execution rights
#RUN chmod a+x *.pl

# Create the log file to be able to run tail
RUN touch /var/log/idrive.log

# Run the command on container startup
ENTRYPOINT ["/work/entrypoint.sh"]
