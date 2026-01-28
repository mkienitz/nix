{
  writeShellApplication,
  fd,
  gum,
}:
writeShellApplication {
  name = "cleanup";
  runtimeInputs = [
    fd
    gum
  ];
  text = builtins.readFile ./cleanup.sh;
}
