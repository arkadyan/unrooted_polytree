defmodule UnrootedPolytree.MixProject do
  use Mix.Project

  def project do
    [
      app: :unrooted_polytree,
      version: "0.1.1",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "UnrootedPolytree",
      description:
        "GenStagA data type and related functions to support an unrooted (multiple starting nodes) polytree (a tree-like graph with edges).",
      source_url: "https://github.com/arkadyan/unrooted_polytree",
      docs: [main: "readme", extras: ["README.md"]],
      package: package(),
      dialyzer: [
        plt_add_deps: :app_tree
      ],
      test_coverage: [tool: LcovEx]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.1", only: :dev, optional: true},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      maintainers: ["Matthew Shanley <matthewshanley@littlesecretsrecords.com>"],
      links: %{
        "Github" => "https://github.com/arkadyan/unrooted_polytree"
      },
      files: ~w(lib/**/*.ex mix.exs README.md LICENSE)
    ]
  end
end
