function welcome {
write-output "Welcome to planet $env:computername Overlord $env:username"
$today = get-date -format 'HH:MM tt on dddd'
write-output "It is $today."
}
