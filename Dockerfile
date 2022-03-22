FROM  debian:11.2

SHELL ["/bin/bash", "-c"]

COPY . /eBiznes

WORKDIR /eBiznes

RUN apt-get update && apt-get install -y curl zip unzip gpg sudo

RUN apt-get update && apt-get install -y default-jdk
RUN apt-get update && apt-get install -y scala 

RUN curl -s "https://get.sdkman.io" | bash
RUN chmod a+x "$HOME/.sdkman/bin/sdkman-init.sh"
RUN source "$HOME/.sdkman/bin/sdkman-init.sh" && \
    sdk install sbt

RUN curl -fLo coursier "https://git.io/coursier-cli" && \
    chmod +x coursier
RUN ./coursier install scalafix --quiet --install-dir /usr/bin


RUN scalac ./testScala.scala 
CMD scala Hello