FROM --platform=$BUILDPLATFORM golang:1.21.3-bookworm AS build

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download && go mod verify
COPY . .

ARG TARGETOS TARGETARCH
ENV CGO_ENABLED=0 \
  GOOS=${TARGETOS} \
  GOARCH=${TARGETARCH}

RUN go build -o /myapp .

FROM gcr.io/distroless/base-debian12
COPY --from=build /myapp /myapp
ENTRYPOINT ["/myapp"]
