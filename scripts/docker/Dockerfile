FROM public.ecr.aws/amazonlinux/amazonlinux:2

# Set environment variables
ENV NODE_VERSION=16.20.2
ENV ANGULAR_CLI_VERSION=16.0.4

# Install dependencies
RUN yum update -y && \
    yum install -y git tar gzip sudo python3 python3-pip unzip curl jq shadow-utils && \
    yum clean all && \
    rm -rf /var/cache/yum

# Install Node.js
RUN curl -sL https://rpm.nodesource.com/setup_16.x | bash - && \
    yum install -y nodejs && \
    yum clean all && \
    rm -rf /var/cache/yum

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

# Install global dependencies
RUN npm install -g @angular/cli@${ANGULAR_CLI_VERSION} && \
    npm cache clean --force

# Create non-root user
RUN useradd -m -s /bin/bash builder && \
    echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set CloudFront ID
ENV CLOUDFRONT_ID=E2AOZ72PC8R9GV

# Copy and configure build script
COPY scripts/docker/build.sh /usr/local/bin/build.sh
RUN chmod +x /usr/local/bin/build.sh

# Set working directory
WORKDIR /workspace

# Switch to non-root user
USER builder

# Set default command
CMD ["/usr/local/bin/build.sh"]