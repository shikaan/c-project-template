C Project Template
---

Bootstrap C projects.

## Commands

```sh
  make help
```

## Dependencies

Dependencies are downloaded into the `lib` folder. Versions are tracked in the requirements file.

Installing goes like 

```sh
  make add url=$(permalink) # good idea is to use tags or sha commits in the url
```

Bootstraping project dependencies would be

```sh
  make install
```

which downloads all the dependencies referenced in the `requirements`. And finally removing dependencies

```sh
  make remove lib=$(file name of the lib to remove)
```

### Caveats

* better to use permalinks pointing to specific code versions (point to `v1` tag instead of `maina)
* cannot install more libraries with the same name

## Testing

This includes very rudimentary [test utilities](test/utils.c). 
An example test file can be found [here](test/greet_test.c).