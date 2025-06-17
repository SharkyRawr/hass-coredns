# Home Assistant CoreDNS Add-on

[![GitHub Release][releases-shield]][releases]
[![GitHub Activity][commits-shield]][commits]
[![License][license-shield]](LICENSE)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

_A CoreDNS add-on for Home Assistant with mDNS support for local DNS resolution._

## About

This add-on provides CoreDNS, a flexible DNS server, with mDNS (multicast DNS) plugin support. It's perfect for resolving local `.local` domains and providing custom DNS resolution within your Home Assistant environment.

### Features

- 🔍 **Local DNS Resolution**: Resolve `.local` domains using mDNS
- 🚀 **High Performance**: Built on CoreDNS for fast and reliable DNS serving
- 🔧 **Configurable**: Customizable upstream DNS servers and domain handling
- 🏠 **Home Assistant Integration**: Seamless integration with Home Assistant networking
- 📝 **Logging**: Comprehensive query logging for troubleshooting
- 🛡️ **Access Control**: Network-based access control lists for security

## Installation

### Adding the Repository

1. Navigate to **Settings** in your Home Assistant web interface
2. Click on the **Add-ons** tab
3. Click on the **Add-on store** in the bottom right corner
4. Click the **⋮** (three dots) menu in the top right corner
5. Select **Repositories**
6. Add this repository URL:
   ```
   https://github.com/SharkyRawr/hass-coredns
   ```
7. Click **Add**

### Installing the Add-on

1. After adding the repository, refresh the Add-on Store page
2. Find **CoreDNS** in the list of available add-ons
3. Click on the CoreDNS add-on
4. Click **Install**
5. Wait for the installation to complete

## Configuration

### Basic Configuration

```yaml
defaults:
  - "8.8.8.8"
  - "8.8.4.4"
  - "1.1.1.1"
  - "1.0.0.1"
acl_allow:
  - "192.168.0.0/16"
  - "172.16.0.0/12"
  - "10.0.0.0/8"
  - "fd00::/16"
customize:
  active: false
  folder: "coredns"
```

### Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `defaults` | list | `["8.8.8.8", "8.8.4.4", "1.1.1.1", "1.0.0.1"]` | List of default upstream DNS servers |
| `acl_allow` | list | `["192.168.0.0/16", "172.16.0.0/12", "10.0.0.0/8"]` | Network ranges allowed to query the DNS server |
| `customize.active` | boolean | `false` | Enable custom DNS configuration files |
| `customize.folder` | string | `"coredns"` | Folder name in `/share/` for custom configuration files |

### Access Control Lists (ACL)

The `acl_allow` option controls which network ranges can query your DNS server. By default, it allows:

- `192.168.0.0/16` - Standard home networks (192.168.x.x)
- `172.16.0.0/12` - Docker networks and some corporate networks
- `10.0.0.0/8` - Large private networks
- `fd00::/16` - IPv6 is technically supported, though HASSIO may not expose containers to IPv6 yet(?)

**Example**: To allow only your local subnet:
```yaml
acl_allow:
  - "192.168.1.0/24"
```

### Custom Configuration

When `customize.active` is set to `true`, you can place custom CoreDNS configuration files in `/share/coredns/` (or the folder specified in `customize.folder`).

**Example custom configuration** (`/share/coredns/custom.conf`):
```
example.local:53 {
    file /share/coredns/example.local.zone
    log
}
```

## Network Configuration

### Port Information

The add-on exposes DNS on both TCP and UDP port 53:
- **53/tcp**: DNS over TCP
- **53/udp**: DNS over UDP (standard DNS queries)

## Advanced Usage

### Custom Zone Files

When using custom configuration, you can create zone files for local domains:

1. Enable custom configuration:
   ```yaml
   customize:
     active: true
     folder: "coredns"
   ```

2. Create a zone file in `/share/coredns/example.local.zone`:
   ```
   $ORIGIN example.local.
   @    IN SOA ns1.example.local. admin.example.local. (
            2023060101 ; serial
            3600       ; refresh
            1800       ; retry
            604800     ; expire
            86400      ; minimum
   )
   @    IN NS  ns1.example.local.
   ns1  IN A   192.168.1.10
   www  IN A   192.168.1.20
   api  IN A   192.168.1.30
   ```

3. Add configuration in `/share/coredns/examplezone.conf`:
   ```
   example.local:53 {
       file /share/coredns/example.local.zone
       log
   }
   ```

⚠️ The filename for custom CoreDNS configs has to end in: `.conf`

## Support

- 🐛 **Issues**: [GitHub Issues](https://github.com/SharkyRawr/hass-coredns/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/SharkyRawr/hass-coredns/discussions)
- 📖 **CoreDNS Documentation**: [CoreDNS Official Docs](https://coredns.io/)


## Acknowledgments

- [CoreDNS](https://coredns.io/) - The DNS server this add-on is based on
- [CoreDNS mDNS Plugin](https://github.com/openshift/coredns-mdns) - For mDNS support
- Home Assistant Community - For feedback and support

---

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
[commits-shield]: https://img.shields.io/github/commit-activity/y/SharkyRawr/hass-coredns.svg
[commits]: https://github.com/SharkyRawr/hass-coredns/commits/main
[license-shield]: https://img.shields.io/github/license/SharkyRawr/hass-coredns.svg
[releases-shield]: https://img.shields.io/github/release/SharkyRawr/hass-coredns.svg
[releases]: https://github.com/SharkyRawr/hass-coredns/releases