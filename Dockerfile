FROM swipl:latest
RUN apt-get -y update
RUN apt-get -y install git
RUN apt-get -y install make
RUN apt-get -y install nano
RUN mkdir scasp
WORKDIR scasp
RUN mkdir codebase
RUN git clone https://github.com/SWI-Prolog/sCASP.git
WORKDIR sCASP
RUN swipl -g "pack_install(.)" -t halt
CMD ["swipl"]
