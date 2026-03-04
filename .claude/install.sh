#!/bin/bash

curl -fsSL https://claude.ai/install.sh | bash
claude config set --global preferredNotifChannel terminal_bell
