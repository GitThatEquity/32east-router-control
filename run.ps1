param(
  [ValidateSet('control','treatment')][string]$Arm = 'control',
  [string]$Model = 'sonnet',
  [string]$Attempt = 'run-01'
)
$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$dest = Join-Path $root "$Arm/$Attempt"
if (Test-Path -LiteralPath $dest) { throw 'Use a new attempt name; raw evidence must never be overwritten.' }
New-Item -ItemType Directory -Path $dest -Force | Out-Null
$source = Get-Content -LiteralPath (Join-Path $root 'reference/Router.md') -Raw
$questions = Get-Content -LiteralPath (Join-Path $root 'prompts/questions.txt') -Raw
$prompt = "<reference name=`"Router.md`">`n$source`n</reference>`n`n$questions"
$system = 'You answer questions from supplied reference text. Do not use tools or external information.'
if ($Arm -eq 'treatment') {
  foreach ($file in @('identity.md','rules.md','examples.md')) {
    $system += "`n`n<$file>`n" + (Get-Content -LiteralPath (Join-Path $root $file) -Raw) + "`n</$file>"
  }
}
[IO.File]::WriteAllText((Join-Path $dest 'prompt.txt'), $prompt)
[IO.File]::WriteAllText((Join-Path $dest 'system.txt'), $system)
$info = [Diagnostics.ProcessStartInfo]::new()
$info.FileName = (Get-Command claude).Source
$info.WorkingDirectory = $dest
$info.UseShellExecute = $false
$info.RedirectStandardInput = $true
$info.RedirectStandardOutput = $true
$info.RedirectStandardError = $true
$cliArgs = @('--print','--safe-mode','--model',$Model,'--effort','medium','--tools','','--disable-slash-commands','--strict-mcp-config','--no-session-persistence','--system-prompt',$system,'--output-format','json')
foreach ($arg in $cliArgs) { $info.ArgumentList.Add($arg) }
$started = [DateTimeOffset]::UtcNow
$process = [Diagnostics.Process]::new()
$process.StartInfo = $info
$process.Start() | Out-Null
$outFile = [IO.File]::Create((Join-Path $dest 'stdout.json'))
$errFile = [IO.File]::Create((Join-Path $dest 'stderr.txt'))
$outTask = $process.StandardOutput.BaseStream.CopyToAsync($outFile)
$errTask = $process.StandardError.BaseStream.CopyToAsync($errFile)
$process.StandardInput.Write($prompt)
$process.StandardInput.Close()
$process.WaitForExit()
$outTask.GetAwaiter().GetResult()
$errTask.GetAwaiter().GetResult()
$outFile.Dispose()
$errFile.Dispose()
$ended = [DateTimeOffset]::UtcNow
$metadata = [ordered]@{ arm=$Arm; requested_model=$Model; started_utc=$started.ToString('o'); ended_utc=$ended.ToString('o'); wall_seconds=($ended-$started).TotalSeconds; exit_code=$process.ExitCode; cli_version=(& claude --version); arguments=$cliArgs; source_sha256=(Get-FileHash -LiteralPath (Join-Path $root 'reference/Router.md')).Hash; questions_sha256=(Get-FileHash -LiteralPath (Join-Path $root 'prompts/questions.txt')).Hash }
$metadata | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath (Join-Path $dest 'metadata.json') -Encoding utf8
Write-Output "$Arm/$Attempt saved; exit=$($process.ExitCode); seconds=$([math]::Round(($ended-$started).TotalSeconds,2))"
