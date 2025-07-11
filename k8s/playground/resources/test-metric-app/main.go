package main

import (
	"fmt"
	"log"
	"net/http"
	"strconv"
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var (
	port    = 7070
	name    = "test-metric-app"
	version = "v0.1.4"
)

// handler with metrics
type handler struct {
	// Prometheus metrics
	metrics *metrics
}

func main() {
	// Create Prometheus registry
	reg := prometheus.NewRegistry()
	m := NewMetrics(reg)

	// Create Prometheus HTTP server to expose metrics
	pMux := http.NewServeMux()
	promHandler := promhttp.HandlerFor(reg, promhttp.HandlerOpts{})
	pMux.Handle("/metrics", promHandler)

	// Start an HTTP server to expose Prometheus metrics in the background.
	go func() {
		log.Fatal(http.ListenAndServe(":8081", pMux))
	}()

	app := fiber.New()

	// Initialize Fiber handler.
	h := handler{metrics: m}

	app.Get("/api/cpu", h.cpu)
	app.Get("/about", h.about)
	app.Get("/health", h.health)

	app.Listen(fmt.Sprintf(":%d", port))
}

func (h *handler) cpu(c *fiber.Ctx) error {
	// Get the current time to record the duration of the request.
	now := time.Now()

	index := c.Query("index")
	i, err := strconv.Atoi(index)
	if err != nil {
		return fmt.Errorf("strconv.Atoi failed: %w", err)
	}

	n := fib(i)
	msg := fmt.Sprintf("Testing CPU load (Fibonacci index is %d, number is %d)", i, n)

	// Record the duration of the insert query.
	h.metrics.duration.With(prometheus.Labels{"path": "/api/cpu"}).Observe(time.Since(now).Seconds())

	return c.JSON(&fiber.Map{"message": msg})
}

func fib(n int) int {
	if n <= 1 {
		return n
	}
	return fib(n-1) + fib(n-2)
}

func (h *handler) about(c *fiber.Ctx) error {
	return c.JSON(&fiber.Map{"service": name, "version:": version})
}

func (h *handler) health(c *fiber.Ctx) error {
	return c.JSON(&fiber.Map{"status": "ok"})
}
