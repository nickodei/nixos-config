{ pkgs, vimUtils, fetchFromGitHub, netcoredbg }:

{
  # Pinned to an older version due to a bug with OmniSharpDebugProject not working anymore
  omnisharp-vim = vimUtils.buildVimPlugin {
    name = "omnisharp-vim";
    src = fetchFromGitHub {
      owner = "OmniSharp";
      repo = "omnisharp-vim";
      rev = "2b664e3d33b3174ca30c05b173e97331b74ec075";
      sha256 = "UJhV9rbefNWqbc3AB+jW/+zNx7mhcURGNN6lg4rvS9g=";
    };
  };
}
