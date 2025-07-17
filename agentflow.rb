class Agentflow < Formula
  desc "AI agent orchestration and management CLI tool for goal-driven autonomous task execution"
  homepage "https://github.com/sohei1l/agentflow"
  url "https://github.com/sohei1l/agentflow/archive/v1.0.0.tar.gz"
  sha256 "d3ad68369060fc49e3e1e5f1a9851d5040eed75de1bca09baaf4014b8378f0c8"
  license "MIT"

  depends_on "node"

  def install
    # Install all dependencies including dev dependencies (needed for TypeScript)
    system "npm", "install"
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