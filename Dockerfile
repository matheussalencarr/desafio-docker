FROM golang:1.7.4-alpine3.5 as builder

WORKDIR /app 

COPY *.go /app/

RUN CGO_ENABLED=0 GOOS=linux go build main.go

FROM scratch

WORKDIR /app

COPY --from=builder /app .

ENTRYPOINT ["./main"]