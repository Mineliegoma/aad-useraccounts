# Sign in to Azure account
Connect-AzAccount

# Set the Azure subscription, you need to replace subscriptionID with your own credentials
Set-AzContext -SubscriptionId "<yoursubscriptionId here> "

# Create users in Azure Active Directory
for ($i = 1; $i -le 20; $i++) {
 $displayName = "Test User $i"
 $password = ConvertTo-SecureString -String "Password" -AsPlainText -Force
 $userPrincipalName = "test.user$i@mineliegomalembetoutlook.onmicrosoft.com"
 $mailNickname = "test.user$i"
 New-AzADUser -DisplayName $displayName -Password $password -UserPrincipalName $userPrincipalName -ForceChangePasswordNextLogin -MailNickname $mailNickname
}
# Create a new Azure AD group
$group = New-AzADGroup -DisplayName "Varonis Assignment Group" -MailNickname "AssignmentGroup"

# Add each user to the group and log the attempt
$logFile = "UserGroupLog.txt"
for ($i = 1; $i -le 20; $i++) {
    $userPrincipalName = "test.user$i@mineliegomalembetoutlook.onmicrosoft.com"
    $user = Get-AzADUser -UserPrincipalName $userPrincipalName
    try {
        Add-AzADGroupMember -TargetGroupObjectId $group.Id -MemberObjectId $user.Id
        $result = "Success"
    }
    catch {
        $result = "Failure: " + $_.Exception.Message
    }
    finally {
        $logEntry = "Username: $userPrincipalName, Timestamp: $(Get-Date), Result: $result"
        Add-Content -Path $logFile -Value $logEntry
    }
}
