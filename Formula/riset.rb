class Riset < Formula
  include Language::Python::Virtualenv

  desc "Change macOS wallpapers at sunrise/sunset"
  homepage "https://github.com/eataturk/Wallpaper-Sunrise-Sunset"
  url "https://github.com/eataturk/Wallpaper-Sunrise-Sunset/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"

  depends_on "python@3.12"

  resource "astral" do
    url "https://files.pythonhosted.org/packages/04/d1/1adbf06a38dc339e41a1666f6c7135924594c20fd46e060fb263248c564d/astral-3.2.tar.gz"
    sha256 "9b7c3b412e9e69d172cfb24be0e6addcc9f1bd01a28db8bebe66d75ccc533d88"
  end

  resource "pytz" do
    url "https://files.pythonhosted.org/packages/90/26/9f1f00a5d021fff16dee3de13d43e5e978f3d58928e129c3a62cf7eb9738/pytz-2024.1.tar.gz"
    sha256 "2a29735ea9c18baf14b448846bde5a48030ed267578472d8955cd0e7443a9812"
  end

  def install
    virtualenv_install_with_resources
    pkgshare.install "scripts", "assets"
  end

  def post_install
    ENV["SUNPROJECT_SCRIPTS_DIR"] = pkgshare/"scripts"
    system bin/"sunproject", "post_install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sunproject --version")
  end
end
