# Use a base image with your preferred Linux distribution
# For example, you can use Alpine Linux as a minimal base image
FROM alpine:latest

WORKDIR /app
# Update the package manager and install the required packages
RUN apk update && \
    apk add --no-cache curl

# Download the "hey" binary and make it executable
RUN curl -L -o /app/hey https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_amd64 && \
    chmod +x /app/hey

# # Set environment variables for the "hey" command
# ENV HEY_N=100000
# ENV HEY_C=100
# ENV HEY_M=GET
# ENV HEY_TARGET=phpdemo

# # CMD uname -a
# # Set the entry point for the container to run "hey" with the environment variables
# # ENTRYPOINT ["./hey", "-n", $HEY_N, "-c", $HEY_C, "-m", "$HEY_M", "$HEY_TARGET"]

