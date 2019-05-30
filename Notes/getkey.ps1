#still testing
$ESCKey = 27
$running = $true
while ($running)
	{
	# check and see if ESC was pressed
	if ($host.ui.RawUi.KeyAvailable)
		{
		$key = $host.ui.RawUI.ReadKey("NoEcho,IncludeKeyUp,IncludeKeyDown")

		if ($key.VirtualKeyCode -eq $ESCkey)
			{
			$running = $false
			}
		}
    Write-Host "running"
}