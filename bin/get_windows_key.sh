#!/bin/sh

sudo strings /sys/firmware/acpi/tables/MSDM | tail -1
