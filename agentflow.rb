class Agentflow < Formula
  desc "AI agent orchestration and management CLI tool for goal-driven autonomous task execution"
  homepage "https://github.com/sohei1l/agentflow"
  url "https://github.com/sohei1l/agentflow/archive/v1.0.0.tar.gz"
  sha256 "4b58aea0d9720d0ce5588b7910647ffa7bfa7c920a22e983ca43760761c07b90"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", "--production"
    system "npm", "run", "build"
    
    # Install the built CLI
    libexec.install Dir["*"]
    
    # Create a wrapper script
    (bin/"agentflow").write_env_script libexec/"bin/agentflow.js", PATH: "#{Formula["node"].opt_bin}:$PATH"
  end

  test do
    assert_match "agentflow", shell_output("#{bin}/agentflow --help")
    assert_match "version", shell_output("#{bin}/agentflow --version")
  end
end