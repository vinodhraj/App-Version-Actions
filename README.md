# App-Version-Actions
GitHub Action program to handle application version file like auto-increment of version number.

## Inputs

### `file_name`

**Required** The name of file contains version information.

## Outputs

### `app_version`

Updated version.

## Example usage

uses: vinodhraj/app-version-actions@v1
with:
  file_name: 'version.txt'