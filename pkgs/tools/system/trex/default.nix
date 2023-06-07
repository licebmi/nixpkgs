{ pkgs, stdenv, lib, fetchFromGitHub, perlPackages, shortenPerlShebang
, coreutils-full, perl, ... }:

perlPackages.buildPerlPackage rec {
  pname = "Rex";
  version = "a8520296d3a31a653ac76dd58c21819781346398";
  src = fetchFromGitHub {
    owner = "Adjust";
    repo = "Rex";
    rev = "a8520296d3a31a653ac76dd58c21819781346398";
    sha256 = "y2bLIR4MchKmjy+ZYggrTuYwq1fSQzVEILL8GOJ7JQ0=";
  };
  setSourceRoot = ''
    (cd source && dzil build --in $NIX_BUILD_TOP/dist)
    export sourceRoot=$NIX_BUILD_TOP/dist'';
  checkInputs = [ coreutils-full ];
  buildInputs = with perlPackages; [
    perl
    coreutils-full
    DistZilla
    DistZillaPluginMakeMakerAwesome
    DistZillaPluginMetaProvidesPackage
    DistZillaPluginOurPkgVersion
    DistZillaPluginOSPrereqs
    DistZillaPluginTestMinimumVersion
    DistZillaPluginTestPerlCritic
    FileShareDirInstall
    ParallelForkManager
    shortenPerlShebang
    StringEscape
    TestDeep
    TestPod
    TestOutput
    TestUseAllModules
  ];
  propagatedBuildInputs = with perlPackages; [
    AWSSignature4
    DataPrinter
    DataValidateIP
    DevelCaller
    DigestCRC
    DigestHMAC
    HTTPMessage
    HashMerge
    IOString
    IOTty
    JSONMaybeXS
    LWP
    ListMoreUtils
    NetCIDRLite
    NetOpenSSH
    NetSFTPForeign
    SearchElasticsearch
    SearchElasticsearchClient2_0
    SortNaturally
    TemplateToolkit
    TermProgressBar
    TermReadKey
    TextGlob
    TextTable
    URI
    URLEncode
    XMLSimple
    YAML
    ZabbixTiny
    autovivification
  ];
  postInstall = lib.optionalString stdenv.isDarwin ''
    shortenPerlShebang $out/bin/trex
    shortenPerlShebang $out/bin/trexify
  '';
  meta = {
    homepage = "https://www.rexify.org";
    description = "The friendly automation framework";
    license = lib.licenses.asl20;
  };
}
