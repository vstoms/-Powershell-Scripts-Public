# Configuration for students:

New-AddressList -Name "AL-EDU-Users-DGs" -RecipientFilter {((RecipientTypeDetails -eq 'UserMailbox') -or (RecipientTypeDetails -eq "MailUniversalDistributionGroup") -or (RecipientTypeDetails -eq "DynamicDistributionGroup")) -and (CustomAttribute5 -eq "EDU")}

New-AddressList -Name "AL-EDU-Rooms" -RecipientFilter {((Alias -ne $null) -and ((RecipientDisplayType -eq 'ConferenceRoomMailbox') -or (RecipientDisplayType -eq 'SyncedConferenceRoomMailbox'))) -and (CustomAttribute5 -eq "EDU")}

New-GlobalAddressList -Name "GAL-EDU" -RecipientFilter {(CustomAttribute5 -eq "EDU")}

New-OfflineAddressBook -Name "OAB-EDU" -AddressLists "AL-EDU-Users-DGs"

New-AddressBookPolicy -Name "ABP-EDU" -AddressLists "AL-EDU-Users-DGs","AL-EDU-Rooms" -OfflineAddressBook "\OAB-EDU" -GlobalAddressList "\GAL-EDU" -RoomList "\AL-EDU-Rooms"

Get-Mailbox | Where {$_.CustomAttribute5 -eq "EDU"} | Set-Mailbox -AddressBookPolicy "ABP-EDU"



# Configuration for administrator personnel, managers and teachers:

New-AddressList -Name "AL-ADM-Users-DGs" -RecipientFilter {((RecipientTypeDetails -eq 'UserMailbox') -or (RecipientType -eq "MailUniversalDistributionGroup") -or (RecipientType -eq "DynamicDistributionGroup")) -and (CustomAttribute5 -eq "ADM")}

New-AddressList -Name "AL-ADM-Rooms" -RecipientFilter  {((Alias -ne $null) -and ((RecipientDisplayType -eq 'ConferenceRoomMailbox') -or (RecipientDisplayType -eq 'SyncedConferenceRoomMailbox'))) -and (CustomAttribute5 -eq "ADM")}

New-GlobalAddressList -Name "GAL-ADM" -RecipientFilter {(CustomAttribute5 -eq "ADM")}

New-OfflineAddressBook -Name "OAB-ADM" -AddressLists "GAL-ADM"

New-AddressBookPolicy -Name "ABP-ADM" -AddressLists "AL-ADM-Users-DGs","AL-ADM-Rooms" -OfflineAddressBook "\OAB-ADM" -GlobalAddressList "\GAL-ADM" -RoomList "\AL-ADM-Rooms"

Get-Mailbox | Where {$_.CustomAttribute5 -eq "ADM"}  | Set-Mailbox -AddressBookPolicy "ABP-ADM"



# Configuration for teachers (“Everyone”):

New-AddressBookPolicy -Name "ABP-Teachers" -AddressLists "AL-ADM-Users-DGs","AL-ADM-Rooms","AL-EDU-Users-DGs","AL-EDU-Rooms","All Groups","All Contacts","All Distribution Lists","All Rooms","All Users" -OfflineAddressBook "\Default Offline Address Book" -GlobalAddressList "\Default Global Address List" -RoomList "\All Rooms"

Get-Mailbox | Where {$_.CustomAttribute6 -eq “teachers”} | Set-Mailbox -AddressBookPolicy "ABP-Teachers"
