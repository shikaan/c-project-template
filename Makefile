LOCAL_CACHE_DIR = .cache
LIB_DIR = lib

MAIN_SRC = ./bin/main.c
MAIN_BIN = $(LOCAL_CACHE_DIR)/server

TEST_SRC = ./test/main.c
TEST_BIN = $(LOCAL_CACHE_DIR)/test

REQUIREMENTS = requirements
REQUIREMENTS_TMP = $(REQUIREMENTS).tmp
WGET = wget -q -nc

## debug: Compile example and run binary with lldb
.PHONY: debug
debug: build
	@echo "Debugging app...\n"
	@lldb $(MAIN_BIN)

## run: Compile example and run binary
.PHONY: run
run: build
	@echo "Running app...\n"
	@$(MAIN_BIN)

## build: Compile example to binary
.PHONY: build
build: clean
	@echo "Compiling $(MAIN_SRC)..."
	@gcc -Wall -Werror -g -o $(MAIN_BIN) $(MAIN_SRC)
	@chmod +x $(MAIN_BIN)

## clean: Clean compilation artifacts
.PHONY: clean
clean:
	@rm $(MAIN_BIN) || true 2> /dev/null

## test: Run unit tests
.PHONY: test
test:
	@rm $(TEST_BIN) || true 2> /dev/null
	@mkdir -p .cache
	@gcc -o $(TEST_BIN) $(TEST_SRC)
	@chmod +x $(TEST_BIN)
	@time $(TEST_BIN)

## add: Installs a library from a url (required arg `url`)
.PHONY: add
add:
	@echo "Downloading \"$$url\"..."
	@cd $(LIB_DIR); $(WGET) $$url

	@echo "  Updating \"$(REQUIREMENTS)\"..."
	@touch $(REQUIREMENTS)
	@echo $$url >> $(REQUIREMENTS)
	@cat $(REQUIREMENTS) | uniq >> $(REQUIREMENTS_TMP)
	@rm $(REQUIREMENTS)
	@mv $(REQUIREMENTS_TMP) $(REQUIREMENTS)
	@echo "  Updated \"$(REQUIREMENTS)\""
	
	@printf "Installed at $(LIB_DIR)/"
	@sed 's/.*\///' <<< $$url

## install: Installs libraries from requirements
.PHONY: install
install:
	@echo "Installing dependencies from \"$(REQUIREMENTS)\"..."
	@cd $(LIB_DIR); $(WGET) -i ../$(REQUIREMENTS)
	@echo "Done!"

## remove: Uninstalls a local library (required arg `lib`)
.PHONY: remove
remove:
	@echo "Uninstalling \"$$lib\"..."
	@rm "$(LIB_DIR)/$$lib" 2> /dev/null || true

	@echo "  Updating \"$(REQUIREMENTS)\"..."
	@(grep -s -v -e "$${lib//./\\.}$$" $(REQUIREMENTS) || true) >> $(REQUIREMENTS_TMP)
	@rm $(REQUIREMENTS)
	@mv $(REQUIREMENTS_TMP) $(REQUIREMENTS)
	@echo "  Updated \"$(REQUIREMENTS)\""

	@echo "Done!"

## help: Show help and exit
.PHONY: help
help: Makefile
	@echo
	@echo "  Choose a command:"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo
