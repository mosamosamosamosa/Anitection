FROM golang:1.19-alpine

ENV TZ /usr/share/zoneinfo/Asia/Tokyo
ENV GO111MODULE=on

WORKDIR /go/src/app
COPY . .

EXPOSE 8080

# Install libraries for testing
# RUN apk add --no-cache gcc musl-dev

# RUN go install github.com/cosmtrek/air@v1.49.0
# CMD ["air"]
CMD ["go", "run", "main.go"]
