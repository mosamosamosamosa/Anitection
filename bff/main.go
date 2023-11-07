package main

import (
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"

	"bff/config"
	"bff/interface/handler"
)

func init() {
	config.LoadEnv()
}

func main() {
	// Handler
	strapiHandler := handler.NewStrapiHandler()

	// Echo instance
	e := echo.New()

	// Middleware
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())
	e.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowHeaders: []string{"*"},
		AllowOrigins: []string{"*"},
		AllowMethods: []string{"*"},
	}))

	// Router
	handler.InitRouting(
		e,
		strapiHandler,
	)

	// Start server
	e.Logger.Fatal(e.Start(":8080"))
}
