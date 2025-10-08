{ flake-utils, nixpkgs, system, ...}:

let
   pkgs = import nixpkgs {
      system = system;
   };
   pythonEnv = pkgs.python3.withPackages (ps: with ps; [
      pandas
      pydantic
      ipykernel
   ]);
   kernelSpec = pkgs.writeTextDir
      "kernels/nix_kernel/kernel.json"
      (builtins.toJSON {
         display_name = "Basic Data Munging";
         language = "python";
         argv = [
            "${pythonEnv}/bin/python"
            "-m"
            "ipykernel_launcher"
            "-f"
            "{connection_file}"
         ];
         env = {};
      });
   jupyterServerApp = pkgs.writeShellApplication {
      name = "jupyter-data-munging";
      runtimeInputs = [
         pkgs.jupyter
         pythonEnv
      ];
      text = ''
			export JUPYTER_PATH="${kernelSpec}:''${JUPYTER_PATH:-}"
         exec jupyter lab "$@"
      '';
   };
in {
   shell = pkgs.mkShell {
      buildInputs = with pkgs; [
         pythonEnv
         jupyter
      ];
      shellHook = /*bash*/ ''
			export JUPYTER_PATH="${kernelSpec}:''${JUPYTER_PATH:-}"
		'';
   };
   server = flake-utils.lib.mkApp { drv = jupyterServerApp; };
}
