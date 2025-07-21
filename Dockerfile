# PowerCLI Core Container
# AMD64-only build (compatible with Apple Silicon via Rosetta 2)

FROM --platform=linux/amd64 mcr.microsoft.com/powershell:7.5-ubuntu-20.04

# Set labels
LABEL authors="jasonsova@gmail.com"
LABEL description="PowerCLI Core Container with VMware PowerCLI modules and PowerShell remoting support"
LABEL version="1.0.0"

# Set environment variables
ENV TZ=etc/UTC
ENV POWERSHELL_TELEMETRY_OPTOUT=1

# Set working directory
WORKDIR /root

# Install Python and dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-dev \
        wget \
        git \
        dnsutils \
        ca-certificates \
        curl \
    && pip3 install --upgrade pip six psutil lxml pyopenssl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install VMware PowerCLI modules
RUN pwsh -c "Set-PSRepository -Name PSGallery -InstallationPolicy Trusted" \
    && pwsh -c "Install-Module PSDesiredStateConfiguration -MinimumVersion 2.0.6" \
    && pwsh -c "Install-Module -Name VMware.PowerCLI" \
    && pwsh -c "Install-Module -Name VMware.vSphereDSC" \
    && pwsh -c "Install-Module -Name VMware.CloudServices" \
    && pwsh -c "Install-Module -Name VMware.vSphere.SsoAdmin" \
    && pwsh -c "Install-Module -Name PowerVCF" \
    && pwsh -c "Install-Module -Name PowerNSX" \
    && pwsh -c "Install-Module -Name PowervRA" \
    && pwsh -c "Set-PowerCLIConfiguration -PythonPath /usr/bin/python3 -Scope AllUsers -InvalidCertificateAction Ignore -Confirm:\$false" \
    && find / -name "net45" | xargs rm -rf

# Install PowerShell remoting modules and dependencies
RUN pwsh -c "Install-Module -Name PSSessionToolkit" \
    && pwsh -c "Install-Module -Name PSRemoteOperations" \
    && pwsh -c "Install-Module -Name Posh-SSH" \
    && pwsh -c "Install-Module -Name CredentialManager" \
    && pwsh -c "Install-Module -Name Microsoft.PowerShell.SecretManagement" \
    && pwsh -c "Install-Module -Name Microsoft.PowerShell.SecretStore"

# Install additional tools and example scripts
RUN git clone https://github.com/vmware/PowerCLI-Example-Scripts.git \
    && mkdir --parents /usr/local/share/powershell/Modules \
    && mv ./PowerCLI-Example-Scripts/Modules/* /usr/local/share/powershell/Modules/ \
    && rm -rf /usr/local/share/powershell/Modules/VMware.vSphere.SsoAdmin \
    && apt-get remove -y git \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set PowerShell as default command
CMD ["pwsh"] 