include ./.env
export $(shell sed 's/=.*//' .env)

PROJECT_NAME := order-processor
PKG := ./...
MAIN := ./cmd/
MIGRATIONS_DIR = migrations


BUILD := go build
CLEAN := go clean
TEST := go test
RUN := go run
MIGRATE := migrate

# Targets
.PHONY: all build clean fmt vet test run migrate-create migrate-up migrate-down migrate-drop

all: fmt vet test build

build:
	read -p "Enter project name: " name; \
	GOOS=linux GOARCH=amd64 go build -o ./bin/$$name.exe $(MAIN)/$$name/main.go

clean:
	$(CLEAN)
	rm -f $(PROJECT_NAME)

fmt:
	$(FMT) $(PKG)

vet:
	$(VET) $(PKG)

test:
	$(TEST) $(PKG)

run:
	read -p "Enter project name: " name; \
	$(RUN) $(MAIN)/$$name/main.go


gen:
	protoc --go_out=paths=source_relative:proto/gen --go-grpc_out=paths=source_relative:proto/gen order.proto
	protoc --go_out=paths=source_relative:proto/gen --go-grpc_out=paths=source_relative:proto/gen payment.proto
	protoc --go_out=paths=source_relative:proto/gen --go-grpc_out=paths=source_relative:proto/gen notification.proto


# Migration commands
migrate-create:
	@export DB_SOURCE=$$(if [ "$(DB_TYPE)" = "sqlite" ]; then \
		echo "sqlite3://$(DB_NAME).sqlite"; \
	else \
		echo "$(DB_URI)"; \
	fi); \
	read -p "Enter migration name: " name; \
	$(MIGRATE) create -ext sql -dir $(MIGRATIONS_DIR) -seq $$name

migrate-up:
	@export DB_SOURCE=$$(if [ "$(DB_TYPE)" = "sqlite" ]; then \
		echo "sqlite3://$(DB_NAME).sqlite"; \
	else \
		echo "$(DB_URI)"; \
	fi); \
	$(MIGRATE) -database $$DB_SOURCE -path $(MIGRATIONS_DIR) up


migrate-down:
	@export DB_SOURCE=$$(if [ "$(DB_TYPE)" = "sqlite" ]; then \
		echo "sqlite3://$(DB_NAME).sqlite"; \
	else \
		 echo "$(DB_URI)"; \
	fi); \
	$(MIGRATE) -database $$DB_SOURCE -path $(MIGRATIONS_DIR) down 1;

migrate-force:
	@export DB_SOURCE=$$(if [ "$(DB_TYPE)" = "sqlite" ]; then \
		echo "sqlite3://$(DB_NAME).sqlite"; \
	else \
		echo "$(DB_URI)"; \
	fi); \
	$(MIGRATE) -database $$DB_SOURCE -path $(MIGRATIONS_DIR) force $(VERSION);

migrate-drop:
	@export DB_SOURCE=$$(if [ "$(DB_TYPE)" = "sqlite" ]; then \
		echo "sqlite3://$(DB_NAME).sqlite"; \
	else \
		echo "$(DB_URI)"; \
	fi); \
	$(MIGRATE) -database $$DB_SOURCE -path $(MIGRATIONS_DIR) drop

swag:
	read -p "Enter project name: " name; \
	swag init --generalInfo ./cmd/$$name/main.go --output ./docs/$$name


