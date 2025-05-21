package handlers

import (
	"net/http"

	"github.com/mwdev22/order-processor/api-gateway/handlers/types"
)

type AuthHandler struct {
}

func NewAuthHandler() *AuthHandler {
	return &AuthHandler{}
}

func (h *AuthHandler) HandleRegister(w http.ResponseWriter, r *http.Request) {
	var payload types.RegisterUserPayload
	if err := types.ParseJSON(r, &payload); err != nil {
		types.WriteError(w, http.StatusBadRequest, "invalid request payload")
		return
	}

}

func (h *AuthHandler) HandleLogin(w http.ResponseWriter, r *http.Request) {
	var payload types.LoginPayload
	if err := types.ParseJSON(r, &payload); err != nil {
		types.WriteError(w, http.StatusBadRequest, "invalid request payload")
		return
	}
}

func (h *AuthHandler) HandleSendResetPassword(w http.ResponseWriter, r *http.Request) {

}

func (h *AuthHandler) HandleVerifyCode(w http.ResponseWriter, r *http.Request) {

}
