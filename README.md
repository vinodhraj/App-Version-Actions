# App-Version-Actions
GitHub Action program to handle application version file like auto-increment of version number.

## Inputs

### `file_name`

**Required** - The name of file contains version information.

### `tag_version`

**Optional** - Value can be 'true' or 'false'. If 'true' will create tag for this version and push the same to repository. By default it is always 'false'

## Outputs

### `app_version`

Output parameter to access Updated version.

## Example usage

```
name: App Version Actions
on: [push]

jobs:
  Version-check:
    runs-on: ubuntu-latest
    name: App Version
    steps:
    - uses: actions/checkout@master
    - name: Display version
      id: version   
      uses: vinodhraj/app-version-actions@master
      with:
        file_name: './VERSION'
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
