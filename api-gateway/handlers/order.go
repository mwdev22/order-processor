package handlers

import (
	"net/http"
)

type OrderHandler struct {
}

func NewOrdersHandler() *OrderHandler {
	return &OrderHandler{}
}

func (h *OrderHandler) HandleCreateOrder(w http.ResponseWriter, r *http.Request) {

}

func (h *OrderHandler) HandleGetOrder(w http.ResponseWriter, r *http.Request) {

}

func (h *OrderHandler) HandleUpdateOrder(w http.ResponseWriter, r *http.Request) {

}

func (h *OrderHandler) HandleDeleteOrder(w http.ResponseWriter, r *http.Request) {

}
