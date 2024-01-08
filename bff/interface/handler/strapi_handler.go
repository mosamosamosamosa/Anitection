package handler

import (
	"github.com/labstack/echo/v4"
	"io/ioutil"
	"log"
	"net/http"

	"bff/config"
)

type StrapiHandler interface {
	GetHandler(c echo.Context) error
	PostHandler(c echo.Context) error
	PutHandler(c echo.Context) error
	DeleteHandler(c echo.Context) error
}

type strapiHandler struct{}

func NewStrapiHandler() StrapiHandler {
	return &strapiHandler{}
}

var StrapiURL = config.GetEnv("CMS_URL", "http://cms:1337")

func (h *strapiHandler) GetHandler(c echo.Context) error {
	// 元のリクエストからクエリパラメータを取得
	q := c.Request().URL.Query()
	q.Add("populate", "*")

	// クエリパラメータを更新
	c.Request().URL.RawQuery = q.Encode()

	// Authorizationヘッダーの値を取得し、リクエストヘッダーに追加
	authHeader := c.Request().Header.Get("Authorization")

	// 新しいGETリクエストを作成
	req, err := http.NewRequest(http.MethodGet, StrapiURL+c.Request().URL.Path+"?"+c.Request().URL.RawQuery, nil)
	if err != nil {
		log.Fatal(err)
	}

	// Authorizationヘッダーを設定
	req.Header.Set("Authorization", authHeader)
	req.Header.Set("Content-Type", "application/json")

	// HTTPクライアントを作成してリクエストを送信
	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		log.Fatal(err)
	}
	defer resp.Body.Close()

	// レスポンスのボディを読み取り、JSONレスポンスとして返す
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Fatal(err)
	}

	return c.JSONBlob(resp.StatusCode, body)
}

func (h *strapiHandler) PostHandler(c echo.Context) error {
	authHeader := c.Request().Header.Get("Authorization")
	req, err := http.NewRequest(http.MethodPost, StrapiURL+c.Request().URL.Path, c.Request().Body)
	if err != nil {
		log.Fatal(err)
	}
	defer req.Body.Close()

	req.Header.Set("Authorization", authHeader)
	req.Header.Set("Content-Type", "application/json")

	client := &http.Client{}
	res, err := client.Do(req)
	if err != nil {
		log.Fatal(err)
	}
	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		log.Fatal(err)
	}

	return c.JSONBlob(res.StatusCode, body)
}

func (h *strapiHandler) PutHandler(c echo.Context) error {
	authHeader := c.Request().Header.Get("Authorization")
	req, err := http.NewRequest(http.MethodPut, StrapiURL+c.Request().URL.Path+"?"+c.Request().URL.RawQuery, nil)
	if err != nil {
		log.Fatal(err)
	}

	req.Header.Set("Authorization", authHeader)
	req.Header.Set("Content-Type", "application/json")

	client := &http.Client{}
	res, err := client.Do(req)
	if err != nil {
		log.Fatal(err)
	}
	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		log.Fatal(err)
	}

	return c.JSONBlob(res.StatusCode, body)
}

func (h *strapiHandler) DeleteHandler(c echo.Context) error {
	authHeader := c.Request().Header.Get("Authorization")
	req, err := http.NewRequest(http.MethodDelete, StrapiURL+c.Request().URL.Path, c.Request().Body)
	if err != nil {
		log.Fatal(err)
	}

	req.Header.Set("Authorization", authHeader)
	req.Header.Set("Content-Type", "application/json")

	client := &http.Client{}
	res, err := client.Do(req)
	if err != nil {
		log.Fatal(err)
	}
	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		log.Fatal(err)
	}

	return c.JSONBlob(res.StatusCode, body)
}
