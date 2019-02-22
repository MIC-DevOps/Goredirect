include .env
export

GO=go
GO_BUILD=$(GO) build
GO_CLEAN=$(GO) clean

NAME=goredirect

all: clean run

clean:
	$(GO_CLEAN)

build:
	$(GO_BUILD) -o $(NAME)

run: build
	./$(NAME)

rm-gcp:
	rm -rf out/$(NAME)-gcp out/$(NAME)-gcp.tar

gcp: clean rm-gcp
	GOOS=linux GOARCH=amd64 $(GO_BUILD) -v -o out/$(NAME)-gcp .
	tar -c -f out/$(NAME)-gcp.tar -C out $(NAME)-gcp
