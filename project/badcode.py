import subprocess

# This will trigger a Bandit warning due to shell=True
subprocess.call("ls -l", shell=True)
