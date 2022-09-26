# rust-futhark

Investigating and experimenting with various ways of using futhark in rust.

## Important stuff

https://futhark-lang.org/blog/2022-07-01-how-futhark-talks-to-its-friends.html

https://github.com/Erk-/genfut

## Related stuff we probably wont need

https://doc.rust-lang.org/std/ffi/index.html

[sep. 2022] https://github.com/zshipko/futhark-bindgen/tree/main/examples/rust

[oct. 2021] https://github.com/SafariMonkey/futhark-experiments

[oct. 2020] https://github.com/Michael-F-Bryan/futhark-rs

## What you need to use genfut

1. A futhark sourcefile with an entrypoint.

2. The module-generator, which will generate a rust-module that wraps around the futhark sourcefile, and exposes a rust wrapper around the entrypoint.

3. The generated library/module resulting from running the generator.

4. A rust library or test or binary that imports the generated module, and uses it.

It is might be useful to segregate all of these. You *could* possibly combine all the first three in one, and then just 'update' the crate by changing the futhark code, rerunning the generator, and then checking the generated library and the new futhark code into git. That way, they follow each other around, which is probably useful. 

The issue, then, is that the generator might have its own dependencies overwritten by itself. For this reason, I am using a workspace.

Important: The generator finds the futhark source file from wherever you run the binary, and it spits out the module from wherever you run the binary. Therefore, please run the binary from the workspace folder, so that the generated library is not dumped into the generator-module as a subfolder. Please also specify, in `generator/src/main.rs`, the full path __from the workspace folder__ to the specific file with an entrypoint, which you want the module to wrap around. 

Since you can only specify one file, you will want to segregate futhark implementations from the outer entry-point file, which should import from other futhark fules and expose entry-points to the generator.

