# syntax=docker/dockerfile:1.4
ARG TARGETOS
ARG TARGETARCH

FROM --platform=$BUILDPLATFORM golang:1.24 AS builder
WORKDIR /src
ARG goproxy=https://proxy.golang.org
ENV GOPROXY=$goproxy
COPY go.mod go.sum ./
RUN --mount=type=cache,target=/go/pkg/mod go mod download
COPY . .
RUN --mount=type=cache,target=/root/.cache/go-build \
  --mount=type=cache,target=/go/pkg/mod \
  CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH \
  go build -trimpath -ldflags "-s -w -extldflags '-static'" \
  -o /out/manager ./   

FROM gcr.io/distroless/static:nonroot
COPY --from=builder /out/manager /manager
USER 65532
ENTRYPOINT ["/manager"]
