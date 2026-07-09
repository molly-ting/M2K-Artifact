$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$oldPythonPath = $env:PYTHONPATH
if ($oldPythonPath) {
    $env:PYTHONPATH = "$scriptDir\py;$oldPythonPath"
} else {
    $env:PYTHONPATH = "$scriptDir\py"
}

python "$scriptDir\py\sxia\main.py" @args
