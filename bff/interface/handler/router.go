package handler

import (
	"net/http"

	"github.com/labstack/echo/v4"
)

func InitRouting(
	e *echo.Echo,
	strapiHandler StrapiHandler,
) {
	e.GET("/", func(c echo.Context) error {
		return c.JSON(http.StatusOK, echo.Map{
			"status": "ok",
		})
	})

	e.GET("/api/*", strapiHandler.GetHandler)
	e.POST("/api/*", strapiHandler.PostHandler)
	e.PUT("/api/*", strapiHandler.PutHandler)
	e.DELETE("/api/*", strapiHandler.DeleteHandler)
}
