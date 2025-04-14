# AppImage Integrator

A modern, user-friendly tool to integrate AppImage applications into your Linux desktop environment.

![Version](https://img.shields.io/badge/version-2.1-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

## Features

- 🚀 Easy AppImage integration into your desktop environment
- 🎨 Automatic icon extraction and desktop entry creation
- 🔒 Optional sandboxing support (Firejail, Flatpak)
- 📦 XDG Base Directory compliance
- 🎯 Smart application detection and configuration
- 🔄 Clean uninstallation support
- 💻 Modern, user-friendly interface

## Installation

### Quick Install (Recommended)

```bash
# Clone the repository
git clone https://github.com/benyaminrmb/appimage-integrator.git

# Enter the directory
cd appimage-integrator

# Run the installer
./install.sh
```

### Manual Installation

1. Make sure you have the following dependencies:
   - `desktop-file-utils`
   - `glib2`
   - `zenity` (optional, for GUI dialogs)

2. Clone and install:
   ```bash
   git clone https://github.com/benyaminrmb/appimage-integrator.git
   cd appimage-integrator
   mkdir -p ~/.local/bin
   cp -r lib/* ~/.local/lib/appimage-integrator/
   cp bin/appimage-integrator ~/.local/bin/
   chmod +x ~/.local/bin/appimage-integrator
   ```

## Usage

### Basic Usage

```bash
# Integrate an AppImage
appimage-integrator /path/to/your/application.AppImage

# List installed AppImages
appimage-integrator --list

# Remove an installed AppImage
appimage-integrator --remove AppName
```

### Advanced Options

```bash
# Set custom name and categories
appimage-integrator --name "My App" --categories "Development;Utility;" app.AppImage

# Use Firejail sandboxing
appimage-integrator --sandbox firejail app.AppImage

# Add to autostart
appimage-integrator --autostart app.AppImage

# Force overwrite existing integration
appimage-integrator --force app.AppImage
```

For more options, run:
```bash
appimage-integrator --help
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspired by the need for better AppImage integration in Linux
- Thanks to all contributors and users for their feedback and support

## Support

If you find this tool helpful, please consider:
- Starring the repository
- Reporting issues
- Contributing to the code
- Sharing with others

## Contact

Your Name - [@benyaminrmb](https://twitter.com/benyaminrmb)

Project Link: [https://github.com/benyaminrmb/appimage-integrator](https://github.com/benyaminrmb/appimage-integrator) 