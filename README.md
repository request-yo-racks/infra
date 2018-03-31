# RYR Infra

Request-yo-racks infrastructure management.

## Make targets

### Bootstrap

The `bootstrap-osx` target installs the main software required by the RYR projects.

Some additional software that help the developers accomplishing their tasks can be installed with the
`bootstrap-osx-extras`.

In case the bootstrap process fails, disable the silent mode by setting up the `BS_SILENT` environment variable to `0`.

```bash
export BS_SILENT=0
```
Or
```bash
BS_SILENT=0 bootstrap-osx bootstrap-osx-extras
```
