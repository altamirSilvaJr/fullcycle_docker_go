FROM golang:1.16-alpine AS build

WORKDIR /app

COPY go.mod ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o app

FROM scratch

COPY --from=build /app/app /

CMD ["/app"]