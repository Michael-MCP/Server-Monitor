#Prequists
$date = Get-Date
$email = "false"
#change path
Clear-Content C:\Servers2.txt
Clear-Content C:\Servers5.txt
#Begin
#Replace server names here.
$server1 = ping -n 1 server-01
$server2 = ping -n 1 server-02
write-host "server's pingged"
#Replace file locaions after >
$email[6]
# Server one
$server1
$1 = $server1
switch -wildcard ($1) 
    { 
        "Destination host unreachable" 
        {
        $email[1] = "false"
 write "Report of servers: the following report was generated at: " $date "server has a problem: There is an IP routing problem between your computer and the remote host " $server1 > C:\Servers2.txt
}
        "Ping request could not find host*" 
        {
        $email[1] = "false"
write "Report of servers: the following report was generated at: " $date "server has a problem: None of the client's name resolution mechanisms recognise the name that you typed - check that you typed the host name correctly " $server1 > C:\Servers2.txt
}
        "Request limed out "
        {
        $email[1] = "false"
write "Report of servers: the following report was generated at: " $date "server has a problem: The name resolution mechanisms have recognised the name, but the remote host did not receive the request or did not respond to it - check connectivity to the remote host " $server1 > C:\Servers2.txt
} 
        
        default {
         $email[1] = "true"
write "Report of servers: the following report was generated at: " $date "all seems okay" $server1 > C:\server2.txt
Start-Sleep -s 10
}
}
# Server 2
$server2
$2 = $server2
switch -wildcard ($1) 
    { 
        "Destination host unreachable" 
        {
        $email[5] = "false"
 write "Report of servers: the following report was generated at: " $date "server has a problem: There is an IP routing problem between your computer and the remote host " $server2 > C:\Servers5.txt
}
        "Ping request could not find host*" 
        {
         $email[5] = "false"
write "Report of servers: the following report was generated at: " $date "server has a problem: None of the client's name resolution mechanisms recognise the name that you typed - check that you typed the host name correctly " $server2 > C:\Servers5.txt
}
       "Request limed out "
        {
        $email[5] = "false"
write "Report of servers: the following report was generated at: " $date "server has a problem: The name resolution mechanisms have recognised the name, but the remote host did not receive the request or did not respond to it - check connectivity to the remote host " $server2 > C:\Servers5.txt
} 
        
        default {
         $email[5] = "true"
         write "all seems okay" $server2 > C:\server5.txt
         
Start-Sleep -s 10
}
}
######################################################
#Emil sender - only if eror occured ($email is true)
#Replace with username and password
#$msg to join server arrays- only one array canbe placed in body.
 {$msg = $server1, $server2}
for($i=0; $i -le $email.Length – 1; $i++)
{
if ($email[$i] = "false")
{
$current = "C:\servers".[$i].".txt"
$errormsg = "error message is, $errormsg and $current that is all."
}
}
 $error = "True"
 if ($error = "True")
{
$SourceFolder = "C:\SourceFolder"
$DestinationFolder = "C:\DestinationFolder"
$Log1 = $errormsg
$EmailFrom = "out.mail@googlemail.com"
$EmailTo = "in.mail@googlemail.com"   # your email address here
$EmailBody = $msg
$EmailSubject = "server Summary"
$Username = "out.mail@googlemail.com"
$Password = "Password"


# Send E-mail message with text file attachment
$Message = New-Object Net.Mail.MailMessage($EmailFrom, $EmailTo, $EmailSubject, $EmailBody)
$Attachment = New-Object Net.Mail.Attachment($Log1, 'text/plain')
$Message.Attachments.Add($Attachment)
$SMTPClient = New-Object Net.Mail.SmtpClient("smtp.gmail.com", 587)
$SMTPClient.EnableSsl = $true
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
$SMTPClient.Send($Message)
    }
    
    else {
    #else restart after wait?
        Exit-PSSession
    }
    
