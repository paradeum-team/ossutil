FROM golang:1.17-alpine as build
COPY ./ /go/src/ossutil
WORKDIR /go/src/ossutil 
ENV GOPROXY=https://proxy.golang.com.cn,direct
RUN go mod tidy && \
    go build && \
    cp ossutil / 

FROM alpine:3.15
COPY --from=build /ossutil /usr/local/bin/ossutil
ENTRYPOINT ["/usr/local/bin/ossutil"]
