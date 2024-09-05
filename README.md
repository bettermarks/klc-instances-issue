# kcl-lang schema `instances` test

I observed missing instances when calling `instances` member on a parent schema.

* kclvm version: v0.10.0-beta.2

## Demo

```
❯ kcl run main.k foo/bar/test.k
# v1/main.k #####
v1.Base instances in v1/main.k:  []
v1.Config instances in v1/main.k:  []
v1.FooConfig instances in v1/main.k:  []



# foo/bar/test.k #####
v1.Base instances in foo/bar/test.k 2: [{'version': 'FooBase in main.k'}, {'version': 'BarFooBase in main.k'}]

v1.Config instances in foo/bar/test.k 3: [{'version': '1', 'type': 'v1.Config in main.k (missing in Base.instances())'}, {'version': '1', 'type': 'bar', 'value': 'BarConfig in main.k (missing in Base.instances())'}, {'version': '1', 'type': 'foo', 'value': 'FooConfig in main.k (missing in Base.instances())'}]

v1.FooConfig instances in foo/bar/test.k 2: [{'version': '1', 'type': 'foo', 'value': 'FooFooConfig in main.k (missing in Config.instances())'}, {'version': '1', 'type': 'foo', 'value': 'v1.FooConfig in main.k (missing in Config.instances())'}]



main_1:
  version: '1'
  type: v1.Config in main.k (missing in Base.instances())
main_2:
  version: '1'
  type: bar
  value: BarConfig in main.k (missing in Base.instances())
main_3:
  version: '1'
  type: foo
  value: FooConfig in main.k (missing in Base.instances())
main_4:
  version: '1'
  type: foo
  value: FooFooConfig in main.k (missing in Config.instances())
main_5:
  version: '1'
  type: foo
  value: v1.FooConfig in main.k (missing in Config.instances())
main_6_from_v1_main_1:
  version: '1'
  type: Config in v1 (missing everywhere)
main_7_from_v1_main_2:
  version: '1'
  type: foo
  value: FooConfig in v1 (missing everywhere)
main_8:
  version: FooBase in main.k
main_9:
  version: BarFooBase in main.k
```

## Analysis

1. `instances()` for deeply nested schemas defined within the root package is working
    ```
    BarFooBase -> FooBase -> v1.Base
    ```

2. `instances()` for schemas deeply subclassed from `v1` are loosing their inheritance chain for their immediate parent located in `v1`
    ```  
                             lost
                              v 
    FooConfig -> v1.Config -> v1.Base

                                          lost
                                           v
    BarConfig -> FooConfig -> v1.Config -> v1.Base

                                   lost
                                    v
    FooFooConfig -> v1.FooConfig -> v1.Config -> v1.Base
    ```
