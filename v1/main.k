schema Base:
    version = "1"

schema Config(Base):
    $type: str

schema FooConfig[myvalue: str](Config):
    $type = "foo"
    value: str = myvalue

v1_main_1 = Config {$type = "Config in v1 (missing everywhere)"}
v1_main_2 = FooConfig("FooConfig in v1 (missing everywhere)")
print("# v1/main.k #####")
print("v1.Base instances in v1/main.k: ", Base.instances())
print("v1.Config instances in v1/main.k: ", Config.instances())
print("v1.FooConfig instances in v1/main.k: ", FooConfig.instances())
print("\n\n")
