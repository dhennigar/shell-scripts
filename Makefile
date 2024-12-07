# Define installation directories
BIN_DIR = $(HOME)/.local/bin

# List of scripts to install
SCRIPTS = $(wildcard bin/*.sh)

# Default target: install the scripts
install: $(SCRIPTS)
	@echo "Installing scripts to $(BIN_DIR)..."
	@mkdir -p $(BIN_DIR)
	@cp $(SCRIPTS) $(BIN_DIR)
	@chmod +x $(BIN_DIR)/*.sh

# Uninstall the scripts
uninstall:
	@echo "Uninstalling scripts from $(BIN_DIR)..."
	@rm -f $(BIN_DIR)/*.sh

# Clean up temporary files
clean:
	@echo "Cleaning up..."
	@rm -f *.bak *~ .swp
