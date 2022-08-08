FROM  golang:alpine3.16 as builder

WORKDIR /app

COPY main.go ./
COPY go.* ./
RUN go mod download
COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o hello_go .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/hello_go ./

ENTRYPOINT [ "hello_go" ]