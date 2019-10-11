# App-Version-Actions
GitHub Action program to handle application version file like auto-increment of version number.

## Inputs

### `file_name`

**Required** The name of file contains version information.

## Outputs

### `app_version`

Updated version.

## Example usage

jobs:
  Version-check:
    runs-on: ubuntu-latest
    name: App Version
    steps:
    - uses: actions/checkout@master
    - name: Display version
      id: version
      uses: vinodhraj/app-version-actions@v1
      with:
        file_name: './version'