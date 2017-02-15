# Ansible Seed

Install tools:

```
curl -L https://raw.githubusercontent.com/TakesxiSximada/anseed/master/bootstrap.sh | sh
```

Write your Makefile.

```
ANSEED := $(CURDIR)/.anseed
include environ/$(environ)/config.mk
include $(ANSEED)/anseed.mk
```

Display help:

```
$ environ=staging make
```


Need unmake https://github.com/TakesxiSximada/unmake
