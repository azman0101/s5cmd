FROM golang:1.14 as build-env
ARG LDFLAGS
WORKDIR /go/src/s5cmd
ADD . /go/src/s5cmd
RUN echo $LDFLAGS
RUN go get -d -v ./...

RUN go build ${GCFLAGS} -ldflags "${LDFLAGS}" -o /go/bin/s5cmd

FROM gcr.io/distroless/base
COPY --from=build-env /go/bin/s5cmd /
CMD ["/s5cmd"]
