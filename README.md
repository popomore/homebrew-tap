# Homebrew tap

## Release contract

This tap already distributes Projj through `Formula/projj.rb` (currently version 3.2.0), with separate macOS ARM64 and Intel release URLs and SHA-256 checksums. Formula maintenance updates those verified upstream artifacts; this migration does not change the formula or rebuild Projj.

Product builds and shared release adapters belong to their source repositories and meta. Future formulas for other products must likewise consume a declared, verified version and checksum. This distribution repository needs no independent artifact-build workflow.
