#!/bin/bash
echo "Starting Bastion setup..."
echo "Installing MySQL client..."
dnf install mysql -y
echo "MySQL client installed."
echo "Bastion setup completed."