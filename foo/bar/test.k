import v1

print("# foo/bar/test.k #####")
print("v1.Base instances in foo/bar/test.k ${len(v1.Base.instances())}:", v1.Base.instances())
print("\nv1.Config instances in foo/bar/test.k ${len(v1.Config.instances())}:", v1.Config.instances())
print("\nv1.FooConfig instances in foo/bar/test.k ${len(v1.FooConfig.instances())}:", v1.FooConfig.instances())
print("\n\n")
