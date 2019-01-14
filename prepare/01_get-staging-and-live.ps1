param (
    [string]$serverFarmName = $(throw '-serverFarmName is required'),
    [String]$bluePath = $(throw '-bluePath is required'),
    [String]$greenPath = $(throw '-greenPath is required')
)

Write-Output "Detecting live vs staging:"

$result = @{}

if (Get-ServerOnline $serverFarmName "$serverFarmName-blue") {
    Write-Output "`tLive is Blue"
    Write-Output "`tStaging is Green"
    Write-Output "------------------"

    $result["LiveBlueGreen"] = "Blue"
    $result["LiveDeployPath"] = $bluePath
    $result["LiveServer"] = "$serverFarmName-blue"

    $result["StagingBlueGreen"] = "Green"
    $result["StagingDeployPath"] = $greenPath
    $result["StagingServer"] = "$serverFarmName-green"
}
else {
    Write-Output "`tLive is Green"
    Write-Output "`tStaging is Blue"
    Write-Output "------------------"

    $result["LiveBlueGreen"] = "Green"
    $result["LiveDeployPath"] = $greenPath
    $result["LiveServer"] = "$serverFarmName-green"

    $result["StagingBlueGreen"] = "Blue"
    $result["StagingDeployPath"] = $bluePath
    $result["StagingServer"] = "$serverFarmName-blue"
}

return $result