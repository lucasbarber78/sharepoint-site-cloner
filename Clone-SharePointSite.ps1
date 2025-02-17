# SharePoint Site Cloning Script

# Parameters
param(
    [Parameter(Mandatory=$true)]
    [string]$SourceSiteUrl,
    [Parameter(Mandatory=$true)]
    [string]$TargetSiteUrl,
    [Parameter(Mandatory=$true)]
    [string]$TargetSiteTitle
)

# Ensure PnP PowerShell is installed
if (!(Get-Module -ListAvailable -Name PnP.PowerShell)) {
    Write-Host "Installing PnP PowerShell module..."
    Install-Module -Name PnP.PowerShell -Force -AllowClobber
}

try {
    # Connect to source site
    Write-Host "Connecting to source site..."
    Connect-PnPOnline -Url $SourceSiteUrl -Interactive
    
    # Get source site template
    Write-Host "Getting source site template..."
    $template = Get-PnPSiteTemplate -Out "template.xml" -Handlers All
    
    # Connect to target site
    Write-Host "Connecting to target site..."
    Connect-PnPOnline -Url $TargetSiteUrl -Interactive
    
    # Apply template to target site
    Write-Host "Applying template to target site..."
    Invoke-PnPSiteTemplate -Path "template.xml"
    
    # Clone permissions
    Write-Host "Cloning permissions..."
    $web = Get-PnPWeb
    $sourceWeb = Get-PnPWeb -Url $SourceSiteUrl
    
    $sourceRoleAssignments = Get-PnPRoleAssignment -Web $sourceWeb
    foreach ($roleAssignment in $sourceRoleAssignments) {
        Set-PnPWebPermission -Web $web -User $roleAssignment.PrincipalId -AddRole $roleAssignment.RoleDefinitionBindings
    }
    
    # Update site title
    Write-Host "Updating site title..."
    Set-PnPWeb -Title $TargetSiteTitle
    
    Write-Host "Site cloning completed successfully!" -ForegroundColor Green
} catch {
    Write-Host "An error occurred: $($_.Exception.Message)" -ForegroundColor Red
} finally {
    # Disconnect from SharePoint
    Disconnect-PnPOnline
}