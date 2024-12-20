{
  pkgs ? import <nixpkgs> {}
}:

pkgs.callPackage (
  { stdenv
  , lib
  , zlib
  }:

  stdenv.mkDerivation {
    pname = "standalone-android-partition_tools";
    version = "2021-03-19";

    src = builtins.fetchGit ./.;

    buildInputs = [
      zlib
    ];

    postPatch = ''
      patchShebangs ./make.sh
    '';

    buildPhase = ''
      export LDFLAGS="-Wl,-rpath -Wl,$out/lib"
      ./make.sh
    '';

    installPhase = ''
      mkdir -p $out/{bin,lib}
      cp -t $out/bin lpunpack lpmake lpdump lpadd
      cp -t $out/lib \
		liblp.so \
		libsparse.so \
		libbase.so \
		liblog.so \
		libcrypto.so \
		libcrypto_utils.so \
		libext4_utils.so
    '';
  }
)
{
  stdenv = with pkgs; overrideCC stdenv buildPackages.clang;
}
