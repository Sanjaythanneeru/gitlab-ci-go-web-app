FROM golang:1.22.5 as intermediate

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

# Final stage with distroless image
FROM gcr.io/distroless/base

COPY --from=intermediate /app/main .

COPY --from=intermediate /app/static ./static

EXPOSE 8080

CMD [ "./main" ]