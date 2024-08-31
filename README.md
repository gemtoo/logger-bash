# Bash logger
## How to add it to my script?
### Static import
Copy and paste functions to the beginning of your shell script. That way you won't have to carry around `logger.sh` file.

### Dynamic import
Include this library into your shell script as follows:
```
source /path/to/logger.sh
```
Note that when using dynamic import, if you move `logger.sh` to anoter place, any scripts that depend on it will stop working.
## Usage
Import `logger.sh` to your script. Pass space separated list of commands to `check_deps` function. This will silently check if host system has the specified commands and verbosely exit with error if at least one of them wasn't found.
```
check_deps "date nproc cat this_command_does_not_exist"
```
Informational functions just print pretty text to console.
```
info "This is a info message."
debug "Debug message."
trace "Trace message."
warn "This is a warning."
error "This non-fatal error."
```
Bash executes commands synchronously one after another in a row. If something throws an error, Bash will still try to execute what's next. Sometimes this can be undesired behavior. It is programmers' responsibility to handle such cases. The `die` function will make your program exit when something goes wrong. For example:
```
command -v "this_command_does_not_exist" || die "command -v failed"
```
The XOR operator `||` makes sure `die` is executed only if `command -v` has non-zero exit code.