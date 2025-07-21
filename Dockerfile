FROM mcr.microsoft.com/powershell:lts-ubuntu-22.04

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /root

# Install dependencies
RUN apt-get update && apt-get install -y gss-ntlmssp unzip && \
    apt-get clean && apt-get autoremove -y

# Install VMware modules from PSGallery
SHELL [ "pwsh", "-command" ]
RUN Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
RUN Install-Module VMware.PowerCLI,PowerNSX,PowervRA,PSWSMan -Confirm:$False -Force -Scope AllUsers
RUN Install-WSMan
RUN Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Scope AllUsers -Confirm:$false

# Launch PowerShell
ENTRYPOINT ["/usr/bin/pwsh"]
