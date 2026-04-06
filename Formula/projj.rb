class Projj < Formula
  desc "Manage git repositories with directory conventions"
  homepage "https://github.com/popomore/projj"
  version "3.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/popomore/projj/releases/download/v3.0.0/projj-aarch64-apple-darwin.tar.xz"
      sha256 "1ef0c72db678a6eaa05e319107c16a253aa30e6f941f70be7cae34e29fa8426d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/popomore/projj/releases/download/v3.0.0/projj-x86_64-apple-darwin.tar.xz"
      sha256 "7997f1fc7181d684d1d5e73c4fd3b7afb25c3c94dd7a84dd33452f080de8ab3b"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":  {},
    "x86_64-apple-darwin":   {},
    "x86_64-pc-windows-gnu": {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "projj" if OS.mac? && Hardware::CPU.arm?
    bin.install "projj" if OS.mac? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
