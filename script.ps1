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
