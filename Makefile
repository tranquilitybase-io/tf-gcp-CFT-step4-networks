# Use bash instead of sh
SHELL := /usr/bin/env bash

.PHONY: networks
networks:
	@source scripts/3-networks/networks.sh
