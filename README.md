# AERA Recovery Project Device Tree for Redmi Note 13 5G (gold)

The Redmi Note 13 5G (codenamed `gold`) is a mid-range smartphone from Xiaomi, released in January 2024.

- **Maintainer**: Ayus

## Device Specifications

| Feature | Specification |
| :--- | :--- |
| Chipset | MediaTek Dimensity 6080 (6 nm) |
| CPU | Octa-core (2x2.4 GHz Cortex-A76 & 6x2.0 GHz Cortex-A55) |
| GPU | Mali-G57 MC2 |
| Memory | 6 GB / 8 GB / 12 GB RAM |
| Storage | 128 GB / 256 GB UFS 2.2 |
| Battery | 5000 mAh (Li-Po) |
| Display | 6.67 inches, AMOLED, 120Hz, 1080 x 2400 pixels |

## Enabled Features

- **Native LVGL Touch-first GUI**: Responsive, smooth touch interface.
- **Integrated Root Manager**: Built-in support for KernelSU, KernelSU Next, and SukiSU.
- **Mobile Internet Connectivity**: Cellular data, APN, and SIM status directly in recovery.
- **PC Connection & Web Control**: Browser-based PC control and management over Wi-Fi / ADB.
- **Hardware Decryption**: Full File-Based Encryption (FBE v2) data decryption via Mitee TrustZone.
- **Fastbootd Mode**: Built-in fastbootd integration for flashing dynamic logical partitions.
- **Full Partition Management**: Support for logical partitions (EROFS/EXT4) and user data (F2FS).

## Build Instructions

### 1. Initialize AERA Manifest

```bash
repo init -u https://github.com/AERA-Recovery/android_manifest.git -b aera-16.0 --depth=1
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
```

### 2. Clone Device Tree

Clone this repository into `device/xiaomi/gold`:

```bash
git clone <url-to-this-repo> device/xiaomi/gold
```

### 3. Compile AERA Recovery

```bash
export AERA_BUILD_DEVICE=gold
source build/envsetup.sh
lunch aera_gold-bp2a-eng
mka recoveryimage vendorbootimage -j$(nproc --all)
```

## Flashing Instructions

Since this device uses a Virtual A/B partition layout with recovery stored inside `vendor_boot`:

```bash
fastboot flash vendor_boot out/target/product/gold/vendor_boot.img
fastboot reboot recovery
```
