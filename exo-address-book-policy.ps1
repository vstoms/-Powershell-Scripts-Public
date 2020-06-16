# Configuration for students:

New-AddressList -Name "AL-EDU-Users-DGs" -RecipientFilter {((RecipientTypeDetails -eq 'UserMailbox') -or (RecipientTypeDetails -eq "MailUniversalDistributionGroup") -or (RecipientTypeDetails -eq "DynamicDistributionGroup")) -and (CustomAttribute3 -eq "BLANK")}

New-AddressList -Name "AL-EDU-Rooms" -RecipientFilter {((Alias -ne $null) -and ((RecipientDisplayType -eq 'ConferenceRoomMailbox') -or (RecipientDisplayType -eq 'SyncedConferenceRoomMailbox'))) -and (CustomAttribute5 -eq "BLANK")}

New-GlobalAddressList -Name "GAL-EDU" -RecipientFilter {(CustomAttribute3 -eq "BLANK")}

New-OfflineAddressBook -Name "OAB-EDU" -AddressLists "GAL-EDU"

New-AddressBookPolicy -Name "ABP-EDU" -AddressLists "AL-EDU-Users-DGs","AL-EDU-Rooms" -OfflineAddressBook "\OAB-EDU" -GlobalAddressList "\GAL-EDU" -RoomList "\AL-EDU-Rooms"

Get-Mailbox | Where {$_.CustomAttribute3 -eq "Student"} | Set-Mailbox -AddressBookPolicy "ABP-EDU"



# Configuration for administrator personnel, managers and teachers:

New-AddressList -Name "AL-ADM-Users-DGs" -RecipientFilter {((RecipientTypeDetails -eq 'UserMailbox') -or (RecipientType -eq "MailUniversalDistributionGroup") -or (RecipientType -eq "DynamicDistributionGroup")) -and (CustomAttribute1 -eq "Employee")}

New-AddressList -Name "AL-ADM-Rooms" -RecipientFilter  {((Alias -ne $null) -and ((RecipientDisplayType -eq 'ConferenceRoomMailbox') -or (RecipientDisplayType -eq 'SyncedConferenceRoomMailbox'))) -and (CustomAttribute1 -eq "Employee")}

New-GlobalAddressList -Name "GAL-ADM" -RecipientFilter {(CustomAttribute1 -eq "Employee")}

New-OfflineAddressBook -Name "OAB-ADM" -AddressLists "GAL-ADM"

New-AddressBookPolicy -Name "ABP-ADM" -AddressLists "AL-ADM-Users-DGs","AL-ADM-Rooms" -OfflineAddressBook "\OAB-ADM" -GlobalAddressList "\GAL-ADM" -RoomList "\AL-ADM-Rooms"

Get-Mailbox | Where {$_.CustomAttribute1 -eq "Employee"}  | Set-Mailbox -AddressBookPolicy "ABP-ADM"



# Configuration for teachers (“Everyone”):

New-AddressBookPolicy -Name "ABP-Teachers" -AddressLists "All Groups","All Contacts","All Distribution Lists","All Rooms","All Users" -OfflineAddressBook "\Default Offline Address Book" -GlobalAddressList "\Default Global Address List" -RoomList "\All Rooms"

Get-Mailbox | Where {$_.CustomAttribute2 -eq “Faculty”} | Set-Mailbox -AddressBookPolicy "ABP-Teachers"
