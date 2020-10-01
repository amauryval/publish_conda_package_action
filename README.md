# Publish Anaconda Package Action
A Github Action to publish your Python package to Anaconda Cloud repository.

### Example workflow
```yaml
name: Publish

on: [release]

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:

    - name: Checkout
      uses: actions/checkout@v2

    - name: publish-to-conda
      uses: amauryval/publish_conda_package_action@master
      with:
        CondaDir: 'conda_recipe'
        Platforms: 'osx-64 linux-32 linux-64 win-32 win-64'
        CondaUsername: ${{ secrets.CONDA_USERNAME }}
        CondaPassword: ${{ secrets.CONDA_PASSWORD }}
```