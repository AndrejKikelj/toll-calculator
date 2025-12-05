FROM golang:1.25-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -o main .

FROM gcr.io/distroless/static-debian12:nonroot

COPY --from=builder /app/main /main

EXPOSE 3000

ENTRYPOINT ["/main"]
