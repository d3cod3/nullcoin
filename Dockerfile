FROM ubuntu:18.04


COPY . /nullcoin
WORKDIR /nullcoin

RUN apt update
RUN apt-get install -y build-essential libtool autotools-dev automake pkg-config bsdmainutils python3
RUN apt-get install -y libevent-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev libboost-thread-dev
RUN apt-get install -y libminiupnpc-dev
RUN apt-get install -y libzmq3-dev
RUN apt-get install -y libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools
RUN apt-get install -y libqrencode-dev

RUN cd depends/
RUN make
RUN cd ..

RUN ./autogen.sh
RUN ./configure --prefix=$PWD/depends/x86_64-pc-linux-gnu/
RUN make
RUN make install

EXPOSE 8647 18647

CMD ["nullcoind", "--printtoconsole"]
