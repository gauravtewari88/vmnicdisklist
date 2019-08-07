Select-AzSubscription "subscription_name"
$report = @()
$rgs = Get-AzResourceGroup
foreach($rg in $rgs)
{
    $info = "" | Select ResourceGroupName, VmNames, NicNames, DiskNames
    $info.ResourceGroupName = $rg.ResourceGroupName
    $vms = Get-AzVM -ResourceGroupName $rg.ResourceGroupName
    $nics = Get-AzNetworkInterface -ResourceGroupName $rg.ResourceGroupName
    $disks = Get-AzDisk -ResourceGroupName $rg.ResourceGroupName
        if($vms -ne $null)
        {
           $vmnames = $null
           foreach($vm in $vms)
                 {
                    $vmname = $vm.Name
                    $vmnames = $vmnames + $vmname + "`n"
        
                  }
         }
    else
    {    
        $vmnames = $null
     }
       
    if($nics -ne $null)
        {
        $nicnames = $null
        foreach($nic in $nics)
                {  
            $nicname = $nic.Name
            $nicnames = $nicnames + $nicname + "`n"
                 }
         }
    else
    {
        $nicnames = $null
    }

     if($disks -ne $null)
    {
        $disknames = $null        
        foreach($disk in $disks)
                  {      
            $diskname = $disk.Name
            $disknames = $disknames + $diskname + "`n"
                  }       
    }
    else
    {    
        $disknames = $null
    }
    
    $info.VmNames = $vmnames
    $info.NicNames = $nicnames
    $info.DiskNames = $disknames

    $report+=$info

}

$report | ft ResourceGroupName, VmNames, NicNames, DiskNames
$report | Export-CSV "c:\temp\vminfo.csv"  
