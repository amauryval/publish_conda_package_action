# Publish Anaconda Package
A Github Action to publish your Python package to Anaconda repository.

### Example workflow
```yaml
name: Publish

on: [release]

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: publish-to-conda
      uses: amauryval/conda-package-publish-action@master
      with:
        CondaDir: 'conda_recipe'
        Platforms: 'osx-64 linux-32 linux-64 win-32 win-64'
        CondaUsername: ${{ secrets.ANACONDA_PASSWORD }}
        CondaPassword: ${{ secrets.ANACONDA_USERNAME }}
```