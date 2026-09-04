# TeamViewer Sophos Deployment

Private repository used by the Sophos Live Response deployment command.

## Repository files

- `TVinstall.bat`
- `TeamViewer_Host.msi`

## Secrets

Do NOT store either of these in this repository:

- GitHub Personal Access Token
- TeamViewer Assignment ID

The Sophos command prompts for both at runtime.

The GitHub token should be a fine-grained Personal Access Token restricted to this repository with only:

- Repository permissions -> Contents: Read-only

`TVinstall.bat` receives the TeamViewer Assignment ID as its first argument.
