import v1

schema FooBase(v1.Base):
    version = "FooBase in main.k"

schema BarFooBase(FooBase):
    version = "BarFooBase in main.k"

schema FooConfig[myvalue: str](v1.Config):
    $type = "foo"
    value: str = myvalue

schema BarConfig[myvalue: str](FooConfig):
    $type = "bar"
    value: str = myvalue

schema FooFooConfig[myvalue: str](v1.FooConfig):
    $type = "foo"
    value: str = myvalue

main_1 = v1.Config {$type = "v1.Config in main.k (missing in Base.instances())"}
main_2 = BarConfig("BarConfig in main.k (missing in Base.instances())")
main_3 = FooConfig("FooConfig in main.k (missing in Base.instances())")
main_4 = FooFooConfig("FooFooConfig in main.k (missing in Config.instances())")
main_5 = v1.FooConfig("v1.FooConfig in main.k (missing in Config.instances())")
main_6_from_v1_main_1 = v1.v1_main_1
main_7_from_v1_main_2 = v1.v1_main_2

main_8 = FooBase {}
main_9 = BarFooBase {}
