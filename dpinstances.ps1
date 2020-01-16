# servername;instancesnum;databases;instancesnames;productname

$filepath = "C:\Users\gen_SQL_J_T_Tier0\Documents\dpinstances.csv" 

$recs = Import-CSV $filepath -delimiter ";" 

$i=0
$dbs=0
Foreach ($rec in $recs) {
     $ServerName =$rec.servername
     $InstancesN =$rec.instancesnum
     $Databases  =$rec.databases
     $InstancesL =$rec.instancenames
     $ProductName=$rec.productname
     ##write-host $ServerName

     if ( $ServerName.IndexOf('T.') -GE 0 ) {
       $i += 1
       write-host 'Env is Test' 
       write-host '--> Server     ' $ServerName $i
       write-host '--> Databasses ' $Databases
       write-host '--> Instances  ' $InstancesL
       if ( $InstancesL.IndexOf(' ') -GT 0 ) {
         write-host '--------------------------> more than 1 instances'
       }
       write-host '--> Product    ' $ProductName
       write-host ''
       $dbs = $dbs + $Databases
     }
}

Write-Host 'Number of serversis ' $i
write-host 'Number of databases is ' $dbs

