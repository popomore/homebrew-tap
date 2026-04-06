class Projj < Formula
  desc "Manage git repositories with directory conventions"
  homepage "https://github.com/popomore/projj"
  version "3.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/popomore/projj/releases/download/v3.1.1/projj-aarch64-apple-darwin.tar.xz"
      sha256 "07aa9c0df6c245775d0b0ef83aac8efe73a506ce9eca3ed0f644e19d232fb636"
    end
    if Hardware::CPU.intel?
      url "https://github.com/popomore/projj/releases/download/v3.1.1/projj-x86_64-apple-darwin.tar.xz"
      sha256 "0995110a13014fdc5fcbef98c4daac68381c7330b72dfd196b6fab0115cc6c31"
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
