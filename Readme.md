# NixOS Configuration Guide

## Setting Up Hostname for Flake Deployment

Ensure that the hostname in each `configuration.nix` matches your desired hostname.

### Steps:
1. Set the hostname:
   ```bash
   hostnamectl set-hostname my-super-pc
   ```
2. Deploy the configuration:
   ```bash
   sudo nixos-rebuild switch --flake .#my-super-pc
   ```

### Temporarily Change Hostname Before Flake Deployment
1. Temporarily set the hostname:
   ```bash
   sudo hostname my-super-pc
   ```

---

## TODOs:
1. Reuse duplicated configurations across files to reduce redundancy.