package routes

import (
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/mwdev22/order-processor/api-gateway/handlers"
)

func Register(r *chi.Mux) {
	authHandler := handlers.NewAuthHandler()
	orderHandler := handlers.NewOrdersHandler()

	r.Get("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("API Gateway Root"))
	})

	r.Route("/auth", func(auth chi.Router) {
		auth.Post("/register", authHandler.HandleRegister)
		auth.Post("/login", authHandler.HandleLogin)
	})

	r.Route("/order", func(order chi.Router) {
		order.Use(AuthMiddleware)
		order.Post("/", orderHandler.HandleCreateOrder)
	})
}
