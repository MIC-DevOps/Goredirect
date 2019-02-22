include .env
export

GO=go
GO_BUILD=$(GO) build
GO_CLEAN=$(GO) clean

GO_LINKER=-ldflags
GO_ENV_INJECT=$(GO_LINKER) "-X main.port=${port}"

GO_BUILD_ENV=$(GO_BUILD) $(GO_ENV_INJECT)

NAME=goredirect

all: clean run

clean:
	$(GO_CLEAN)

build:
	$(GO_BUILD_ENV) -o $(NAME)

run: build
	./$(NAME)

rm-gcp:
	rm -rf out/$(NAME)-gcp out/$(NAME)-gcp.tar

gcp: clean rm-gcp
	GOOS=linux GOARCH=amd64 $(GO_BUILD_ENV) -v -o out/$(NAME)-gcp .
	tar -c -f out/$(NAME)-gcp.tar -C out $(NAME)-gcp
