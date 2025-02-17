# SharePoint Site Cloner

This repository contains PowerShell scripts for cloning Modern SharePoint sites, including formatting, validation, and custom permissions.

## Prerequisites

- PowerShell 5.1 or later
- PnP PowerShell module
- Appropriate permissions on both source and target SharePoint sites

## Installation

1. Clone this repository
2. Install PnP PowerShell module:
   ```powershell
   Install-Module -Name PnP.PowerShell -Force -AllowClobber
   ```

## Configuration

1. Edit `config.json` with your SharePoint site URLs and desired target site title
2. Ensure you have appropriate permissions on both source and target sites

## Usage

```powershell
.\Clone-SharePointSite.ps1 -SourceSiteUrl "https://source.sharepoint.com/sites/source" -TargetSiteUrl "https://target.sharepoint.com/sites/target" -TargetSiteTitle "New Site Title"
```

## Features

- Clones site structure and content
- Preserves formatting and layouts
- Copies custom permissions
- Maintains form validation rules
- Supports modern SharePoint features

## Limitations

- Some customizations might require manual intervention
- Workflow history is not transferred
- Custom solutions need to be manually installed on the target site

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License