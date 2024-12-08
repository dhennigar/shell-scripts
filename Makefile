# Define the directories
INSTALL_DIR := $(HOME)/.local/bin
SCRIPT_DIR := $(PWD)/bin

# List all shell script files you want to install
SCRIPTS := $(wildcard $(SCRIPT_DIR)/*.sh)

# Install all shell scripts to INSTALL_DIR
install:
	@echo "Installing shell scripts..."
	@for script in $(SCRIPTS); do \
		ln -sf $$script $(INSTALL_DIR)/$$(basename $$script); \
	done
	@echo "Shell scripts installed."

# Uninstall the shell scripts only if they were installed by this repo
uninstall:
	@echo "Uninstalling shell scripts..."
	@for script in $(SCRIPTS); do \
		rm -f $(INSTALL_DIR)/$$(basename $$script); \
	done
	@echo "Shell scripts uninstalled."

# List files that will be installed (optional, just for checking)
list:
	@echo "Scripts to be installed:"
	@for script in $(SCRIPTS); do \
		echo $$script; \
	done
