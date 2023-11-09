[![Pharo-CI](https://github.com/StevenCostiou/AmmoliteMagenta/actions/workflows/ammolitemagenta.yml/badge.svg)](https://github.com/StevenCostiou/AmmoliteMagenta/actions/workflows/ammolitemagenta.yml)

# AmmoliteMagenta
A small app to divide geology students in homogeneous groups.

# Loading

```Smalltalk
Metacello new
		baseline: 'AmmoliteMagenta';
		repository: 'github://adri09070/AmmoliteMagenta:failing-test-example';
		load
```

To load Seeker:

```Smalltalk
Metacello new
    baseline: 'Seeker';
    repository: 'github://ValentinBourcier/SeekerDebugger:new-object-centric-ttqs';
    load.
```

To load NeoCSV:

```Smalltalk
Metacello new
  repository: 'github://svenvc/NeoCSV/repository';
  baseline: 'NeoCSV';
  load.
```
