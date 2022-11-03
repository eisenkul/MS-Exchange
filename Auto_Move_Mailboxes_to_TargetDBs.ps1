$script:starttime = Get-Date

function Connect-Exchange {
    if (! (Get-PSSnapin Microsoft.Exchange.Management.PowerShell.E2010 -ErrorAction:SilentlyContinue) )
    {
        Add-PSSnapin Microsoft.Exchange.Management.PowerShell.E2010
    }
}

Connect-Exchange

function UserDefinitions {

$script:allmailbox= Get-Mailbox -ResultSize unlimited
$script:db_all_count= $script:allmailbox | Group-Object -Property:Database | Select-Object Name,Count | Sort-Object Name 
$script:tkidm=$script:allmailbox | ?{$_.Database -eq "tkidm"}
#$toplam_tasinacak=$tkidm.Count


#################### UNVAN BAZLI PARAMETRELER ####################

$script:TKbaskan_Params = $script:tkidm |?{(($_.CustomAttribute6 -eq '1') -or ($_.CustomAttribute6 -eq '15') -or ($_.CustomAttribute6 -eq '20') -or ($_.CustomAttribute6 -eq '22') -or ($_.CustomAttribute6 -eq '25') -or ($_.CustomAttribute6 -eq '27') -or ($_.CustomAttribute6 -eq '30') -or ($_.CustomAttribute6 -eq '32')) -AND (($_.CustomAttribute7 -eq 'CLDR') -or ($_.CustomAttribute7 -eq 'ETKAO') -or ($_.CustomAttribute7 -eq 'TKAO') -or ($_.CustomAttribute7 -eq 'TKTB'))}
$script:TKmudur_Params = $script:tkidm |?{(($_.CustomAttribute6 -eq '35') -or ($_.CustomAttribute6 -eq '36') -or ($_.CustomAttribute6 -eq '37')) -AND (($_.CustomAttribute7 -eq 'CLDR') -or ($_.CustomAttribute7 -eq 'ETKAO') -or ($_.CustomAttribute7 -eq 'TKAO') -or ($_.CustomAttribute7 -eq 'TKTB'))}
$script:TKsef_Params = $script:tkidm |?{(($_.CustomAttribute6 -eq '44') -or ($_.CustomAttribute6 -eq '45') -or ($_.CustomAttribute6 -eq '46') -or ($_.CustomAttribute7 -eq '47') -or ($_.CustomAttribute7 -eq '48') -or ($_.CustomAttribute7 -eq '49') -or ($_.CustomAttribute7 -eq '53')) -AND (($_.CustomAttribute7 -eq 'CLDR') -or ($_.CustomAttribute7 -eq 'ETKAO') -or ($_.CustomAttribute7 -eq 'TKAO'))}
$script:TKstd_Params = $script:tkidm |?{(($_.CustomAttribute6 -eq '50') -or ($_.CustomAttribute6 -eq '51') -or ($_.CustomAttribute6 -eq '55') -or ($_.CustomAttribute6 -eq '60') -or ($_.CustomAttribute6 -eq '75') -or ($_.CustomAttribute6 -eq '80') -or ($_.CustomAttribute6 -eq '81') -or ($_.CustomAttribute6 -eq '82') -or ($_.CustomAttribute6 -eq '83') -or ($_.CustomAttribute6 -eq '85') -or ($_.CustomAttribute6 -eq '90') -or ($_.CustomAttribute6 -eq '95') -or ($_.CustomAttribute6 -eq 'A5') -or ($_.CustomAttribute6 -like 'B*') -or ($_.CustomAttribute6 -like 'C*') -or ($_.CustomAttribute6 -eq 'D5') -or ($_.CustomAttribute6 -eq 'E5') -or ($_.CustomAttribute6 -like 'F*') -or ($_.CustomAttribute6 -like 'G*') -or ($_.CustomAttribute6 -like 'H*') -or ($_.CustomAttribute6 -like 'I*') -or ($_.CustomAttribute6 -eq 'N0') -or ($_.CustomAttribute6 -eq 'Q7') -or ($_.CustomAttribute6 -like 'R*') -or ($_.CustomAttribute6 -eq 'N0')) -AND (($_.CustomAttribute7 -eq 'CLDR') -or ($_.CustomAttribute7 -eq 'ETKAO') -or ($_.CustomAttribute7 -eq 'TKAO'))}
$script:TKkgbt_Params = $script:tkidm |?{(($_.CustomAttribute6 -eq '61') -or ($_.CustomAttribute6 -eq '62')) -AND (($_.CustomAttribute7 -eq 'TKTB'))}
$script:TKtsr_Params = $script:tkidm |?{(($_.CustomAttribute6 -like 'T*')) -AND (($_.CustomAttribute7 -eq 'CLDR') -or ($_.CustomAttribute7 -eq 'ETKAO') -or ($_.CustomAttribute7 -eq 'TKAO') -or ($_.CustomAttribute7 -eq 'TKTB') -or ($_.CustomAttribute7 -eq 'DTKTB') -or ($_.CustomAttribute7 -eq 'TKHB') -or ($_.CustomAttribute7 -eq 'TTKAO') -or ($_.CustomAttribute7 -eq 'TTKTB'))}
$script:TKservis_Params = $script:tkidm |?{(($_.CustomAttribute7 -eq 'SRVC'))}
$script:TKfirmalar_Params = $script:tkidm |?{(($_.CustomAttribute7 -eq '3RDP') -or ($_.CustomAttribute7 -eq 'FTGS'))}
$script:TKortak_Params = $script:tkidm |?{(($_.CustomAttribute7 -eq 'ORTAK'))}
$script:TKucucuidm_Params = $script:tkidm |?{(($_.CustomAttribute6 -like 'J*') -or ($_.CustomAttribute6 -like 'K*') -or ($_.CustomAttribute6 -like 'L*') -or ($_.CustomAttribute6 -like 'M*')) -AND (($_.CustomAttribute7 -eq 'ETKAO') -or ($_.CustomAttribute7 -eq 'TKAO'))}
$script:TKstj_Params = $script:tkidm |?{(($_.CustomAttribute6 -like 'P0') -or ($_.CustomAttribute6 -eq 'S2')) -AND (($_.CustomAttribute7 -eq 'TTAS'))}
$script:TASbaskan_Params = $script:tkidm |?{(($_.CustomAttribute6 -eq '1') -or ($_.CustomAttribute6 -eq '15') -or ($_.CustomAttribute6 -eq '20') -or ($_.CustomAttribute6 -eq '22') -or ($_.CustomAttribute6 -eq '25') -or ($_.CustomAttribute6 -eq '27') -or ($_.CustomAttribute6 -eq '30') -or ($_.CustomAttribute6 -eq '32')) -AND (($_.CustomAttribute7 -eq 'ETTAS') -or ($_.CustomAttribute7 -eq 'TTAS') -or ($_.CustomAttribute7 -eq 'TTTAS'))}
$script:TASmudur_Params = $script:tkidm |?{(($_.CustomAttribute6 -eq '35') -or ($_.CustomAttribute6 -eq '36') -or ($_.CustomAttribute6 -eq '37')) -AND (($_.CustomAttribute7 -eq 'ETTAS') -or ($_.CustomAttribute7 -eq 'TTAS') -or ($_.CustomAttribute7 -eq 'TTTAS'))}
$script:TASsef_Params = $script:tkidm |?{(($_.CustomAttribute6 -eq '44') -or ($_.CustomAttribute6 -eq '45') -or ($_.CustomAttribute6 -eq '46') -or ($_.CustomAttribute7 -eq '47') -or ($_.CustomAttribute7 -eq '48') -or ($_.CustomAttribute7 -eq '49') -or ($_.CustomAttribute7 -eq '53')) -AND (($_.CustomAttribute7 -eq 'ETTAS') -or ($_.CustomAttribute7 -eq 'TTAS') -or ($_.CustomAttribute7 -eq 'TTTAS'))}
$script:TASstd_Params = $script:tkidm |?{(($_.CustomAttribute6 -eq '50') -or ($_.CustomAttribute6 -eq '51') -or ($_.CustomAttribute6 -eq '55') -or ($_.CustomAttribute6 -eq '60') -or ($_.CustomAttribute6 -eq '75') -or ($_.CustomAttribute6 -eq '80') -or ($_.CustomAttribute6 -eq '81') -or ($_.CustomAttribute6 -eq '82') -or ($_.CustomAttribute6 -eq '83') -or ($_.CustomAttribute6 -eq '85') -or ($_.CustomAttribute6 -eq '90') -or ($_.CustomAttribute6 -eq '95') -or ($_.CustomAttribute6 -eq 'A5') -or ($_.CustomAttribute6 -like 'B*') -or ($_.CustomAttribute6 -like 'C*') -or ($_.CustomAttribute6 -eq 'D5') -or ($_.CustomAttribute6 -eq 'E5') -or ($_.CustomAttribute6 -like 'F*') -or ($_.CustomAttribute6 -like 'G*') -or ($_.CustomAttribute6 -like 'H*') -or ($_.CustomAttribute6 -like 'I*') -or ($_.CustomAttribute6 -eq 'N0') -or ($_.CustomAttribute6 -eq 'Q7') -or ($_.CustomAttribute6 -like 'R*') -or ($_.CustomAttribute6 -eq 'N0')) -AND (($_.CustomAttribute7 -eq 'ETTAS') -or ($_.CustomAttribute7 -eq 'TTAS') -or ($_.CustomAttribute7 -eq 'TTTAS'))}
$script:TASstj_Params = $script:tkidm |?{(($_.CustomAttribute6 -like 'P0') -or ($_.CustomAttribute6 -eq 'S2')) -AND (($_.CustomAttribute7 -eq 'ETTAS') -or ($_.CustomAttribute7 -eq 'TTAS') -or ($_.CustomAttribute7 -eq 'TTTAS'))}
$script:TAStsr_Params = $script:tkidm |?{(($_.CustomAttribute6 -like 'T*')) -AND (($_.CustomAttribute7 -eq 'ETTAS') -or ($_.CustomAttribute7 -eq 'TTAS') -or ($_.CustomAttribute7 -eq 'TTTAS'))}
$script:Hatali_Params = $script:tkidm |?{(($_.CustomAttribute6 -eq '') -and ($_.CustomAttribute7 -eq '')) -or ($_.CustomAttribute7 -eq '')}

}

UserDefinitions

function MoveVariables {       



#################### VARIABLES ####################

$script:tasinacak_tkbaskan = ($script:TKbaskan_Params.Name).Count
$script:kalan_tkbaskan=$script:tasinacak_tkbaskan
$script:tkbaskan_0=0

$script:tasinacak_tkmudur = ($script:TKmudur_Params.Name).count
$script:kalan_tkmudur=$script:tasinacak_tkmudur
$script:tkmudur_0=0

$script:tasinacak_tksef = ($script:TKsef_Params.Name).count
$script:kalan_tksef =$script:tasinacak_tksef
$script:tksef_0=0

$script:tasinacak_tkstd = ($script:TKstd_Params.Name).count
$script:kalan_tkstd =$script:tasinacak_tkstd
$script:tkstd_0 = 0

$script:tasinacak_tkkgbt = ($script:TKkgbt_Params.Name).count
$script:kalan_tkkgbt = $script:tasinacak_tkkgbt
$script:tkkgbt_0 = 0

$script:tasinacak_tktsr = ($script:TKtsr_Params.Name).count
$script:kalan_tktsr = $script:tasinacak_tktsr
$script:tktsr_0 = 0

$script:tasinacak_tkservis = ($script:TKservis_Params.Name).count
$script:kalan_tkservis = $script:tasinacak_tkservis
$script:tkservis_0 = 0

$script:tasinacak_tkfirmalar = ($script:TKfirmalar_Params.Name).count
$script:kalan_tkfirmalar = $script:tasinacak_tkfirmalar
$script:tkfirmalar_0 = 0

$script:tasinacak_tkortak = ($script:TKortak_Params.Name).count
$script:kalan_tkortak = $script:tasinacak_tkortak
$script:tkortak_0 = 0

$script:tasinacak_tkucucuidm = ($script:TKucucuidm_Params.Name).count
$script:kalan_tkucucuidm = $script:tasinacak_tkucucuidm
$script:tkucucuidm_0 = 0

$script:tasinacak_tkstj = ($script:TKstj_Params.Name).count
$script:kalan_tkstj = $script:tasinacak_tkstj
$script:tkstj_0 = 0

$script:tasinacak_tasbaskan = ($script:TASbaskan_Params.Name).count
$script:kalan_tasbaskan = $script:tasinacak_tasbaskan
$script:tasbaskan_0 = 0

$script:tasinacak_tasmudur = ($script:TASmudur_Params.Name).count
$script:kalan_tasmudur = $script:tasinacak_tasmudur
$script:tasmudur_0 = 0

$script:tasinacak_tassef = ($TASsef_Params.Name).count
$script:kalan_tassef = $tasinacak_tassef
$script:tassef_0 = 0

$script:tasinacak_tasstd = ($TASstd_Params.Name).count
$script:kalan_tasstd = $tasinacak_tasstd
$script:tasstd_0 = 0

$script:tasinacak_tasstj = ($TASstj_Params.Name).count
$script:kalan_tasstj = $tasinacak_tasstj
$script:tasstj_0 = 0

$script:tasinacak_tastsr = ($TAStsr_Params.Name).count
$script:kalan_tastsr = $tasinacak_tastsr
$script:tastsr_0 = 0

$script:tasinacak_hatali = ($Hatali_Params.Name).count
$script:kalan_hatali = $tasinacak

}

MoveVariables

function MoveIDMIterations {

    foreach ($dbn in $db_all_count)
        {
            $script:dbname=$dbn.Name
            $script:dbcount=$dbn.Count
                
                # TK-BASKAN #
                 If ($script:dbname -like "tk-baskan*" -and $script:dbcount -le "30" -and $script:kalan_tkbaskan -gt "0") {
                        
                         
                        $script:tasinacakdb=$script:dbname
                        Write-Host "işlem yapılan db $script:dbname" -ForegroundColor Yellow
                        $script:tasimasayisi=101-$script:dbcount
                        $script:x=1
 

                    while ($script:x -lt $script:tasimasayisi)
                        {

                        $script:identity=$script:TKbaskan_Params[$script:tkbaskan_0].Identity
                        Write-Host "işlem yapılan $script:identity " -ForegroundColor Blue
                        New-MoveRequest -Identity $script:identity -PrimaryOnly -TargetDatabase $script:tasinacakdb -BadItemLimit 100
                        $script:x++
                        $script:tkbaskan_0++
                        $script:kalan_tkbaskan--

          

                        if($script:kalan_tkbaskan -eq 0 ){
                            
                            Write-Host "Break Statement executed $script:kalan_tkbaskan " -ForegroundColor Red
                                break
                                         }
                        }
                }
                # TK-MUDUR #
                elseif ($script:dbname -like "tk-mudur*" -and $script:dbcount -le "30" -and $script:kalan_tkmudur -gt "0"){

                     $script:tasinacakdb=$script:dbname
                        Write-Host "işlem yapılan db $script:dbname" -ForegroundColor Yellow
                        $script:tasimasayisi=101-$script:dbcount
                        $script:x=1
 

                    while ($script:x -lt $script:tasimasayisi)
                        {

                        $script:identity=$script:TKmudur_Params[$script:tkmudur_0].Identity
                        Write-Host "işlem yapılan $script:identity " -ForegroundColor Blue
                        New-MoveRequest -Identity $script:identity -PrimaryOnly -TargetDatabase $script:tasinacakdb -BadItemLimit 100
                        $script:x++
                        $script:tkmudur_0++
                        $script:kalan_tkmudur--

                        if($script:kalan_tkmudur -eq 0 ){
                            
                            Write-Host "Break Statement executed $script:kalan_tkmudur " -ForegroundColor Red
                                break
                                         }
                        }
                
                } 
                # TK-SEF #
                elseif ($script:dbname -like "tk-sef*" -and $script:dbcount -le "100" -and $script:kalan_tksef -gt "0"){

                     $script:tasinacakdb=$script:dbname
                        Write-Host "işlem yapılan db $script:dbname" -ForegroundColor Yellow
                        $script:tasimasayisi=101-$script:dbcount
                        $script:x=1
 

                    while ($script:x -lt $script:tasimasayisi)
                        {

                        $script:identity=$script:TKsef_Params[$script:tksef_0].Identity
                        Write-Host "işlem yapılan $script:identity " -ForegroundColor Blue
                        New-MoveRequest -Identity $script:identity -PrimaryOnly -TargetDatabase $script:tasinacakdb -BadItemLimit 100
                        $script:x++
                        $script:tksef_0++
                        $script:kalan_tksef--

                        if($script:kalan_tksef -eq 0 ){
                            
                            Write-Host "Break Statement executed $script:kalan_tksef " -ForegroundColor Red
                                break
                                         }
                        }
                
                } 
                # TK-STD #
                elseif ($script:dbname -like "tk-std*" -and $script:dbcount -le "100" -and $script:kalan_tkstd -gt "0"){

                     $script:tasinacakdb=$script:dbname
                        Write-Host "işlem yapılan db $script:dbname" -ForegroundColor Yellow
                        $script:tasimasayisi=101-$script:dbcount
                        $script:x=1
 

                    while ($script:x -lt $script:tasimasayisi)
                        {

                        $script:identity=$script:TKstd_Params[$script:tkstd_0].Identity
                        Write-Host "işlem yapılan $script:tkstd_0 " -ForegroundColor Blue
                        New-MoveRequest -Identity $script:identity -PrimaryOnly -TargetDatabase $script:tasinacakdb -BadItemLimit 100
                        $script:x++
                        $script:tkstd_0++
                        $script:kalan_tkstd--

                        if($script:kalan_tkstd -eq 0 ){
                            
                            Write-Host "Break Statement executed $script:kalan_tkstd " -ForegroundColor Red
                                break
                                         }
                        }
                
                } 
                # TK-KGBT #
                elseif ($script:dbname -like "tk-kgbt*" -and $script:dbcount -le "100" -and $script:kalan_tkkgbt -gt "0"){

                     $script:tasinacakdb=$script:dbname
                        Write-Host "işlem yapılan db $script:dbname" -ForegroundColor Yellow
                        $script:tasimasayisi=101-$script:dbcount
                        $script:x=1
 

                    while ($script:x -lt $script:tasimasayisi)
                        {

                        $script:identity=$script:TKkgbt_Params[$script:tkkgbt_0].Identity
                        Write-Host "işlem yapılan $script:identity " -ForegroundColor Blue
                        New-MoveRequest -Identity $script:identity -PrimaryOnly -TargetDatabase $script:tasinacakdb -BadItemLimit 100
                        $script:x++
                        $script:tkkgbt_0++
                        $script:kalan_tkkgbt--

                        if($script:kalan -eq 0 ){
                            
                            Write-Host "Break Statement executed $script:kalan_tkkgbt " -ForegroundColor Red
                                break
                                         }
                        }
                
                } 
                # TK-TSR #
                elseif ($script:dbname -like "tk-tsr*" -and $script:dbcount -le "150" -and $script:kalan_tktsr -gt "0"){

                     $script:tasinacakdb=$script:dbname
                        Write-Host "işlem yapılan db $script:dbname" -ForegroundColor Yellow
                        $script:tasimasayisi=151-$script:dbcount
                        $script:x=1
 

                    while ($script:x -lt $script:tasimasayisi)
                        {

                        $script:identity=$script:TKtsr_Params[$script:tktsr_0].Identity
                        Write-Host "işlem yapılan $script:identity " -ForegroundColor Blue
                        New-MoveRequest -Identity $script:identity -PrimaryOnly -TargetDatabase $script:tasinacakdb -BadItemLimit 100
                        $script:x++
                        $script:tktsr_0++
                        $script:kalan_tktsr--

                        if($script:kalan_tktsr -eq 0 ){
                            
                            Write-Host "Break Statement executed $script:kalan_tktsr" -ForegroundColor Red
                                break
                                         }
                        }
                
                } 
                # TK-SERVIS #
                elseif ($script:dbname -like "tk-servis*" -and $script:dbcount -le "300" -and $script:kalan_tkservis -gt "0"){

                     $script:tasinacakdb=$script:dbname
                        Write-Host "işlem yapılan db $script:dbname" -ForegroundColor Yellow
                        $script:tasimasayisi=301-$script:dbcount
                        $script:x=1
 

                    while ($script:x -lt $script:tasimasayisi)
                        {

                        $script:identity=$script:TKservis_Params[$script:tkservis_0].Identity
                        Write-Host "işlem yapılan $script:identity " -ForegroundColor Blue
                        New-MoveRequest -Identity $script:identity -PrimaryOnly -TargetDatabase $script:tasinacakdb -BadItemLimit 100
                        $script:x++
                        $script:tkservis_0++
                        $script:kalan_tkservis--

                        if($script:kalan -eq 0 ){
                            
                            Write-Host "Break Statement executed $script:kalan_tkservis " -ForegroundColor Red
                                break
                                         }
                        }
                
                } 
                # TK-FIRMALAR #
                elseif ($script:dbname -like "tk-firmalar*" -and $script:dbcount -le "200" -and $script:kalan_tkfirmalar -gt "0"){

                     $script:tasinacakdb=$script:dbname
                        Write-Host "işlem yapılan db $script:dbname" -ForegroundColor Yellow
                        $script:tasimasayisi=201-$script:dbcount
                        $script:x=1
 

                    while ($script:x -lt $script:tasimasayisi)
                        {

                        $script:identity=$script:TKfirmalar_Params[$script:tkfirmalar_0].Identity
                        Write-Host "işlem yapılan $script:identity " -ForegroundColor Blue
                        New-MoveRequest -Identity $script:identity -PrimaryOnly -TargetDatabase $script:tasinacakdb -BadItemLimit 100
                        $script:x++
                        $script:tkfirmalar_0++
                        $script:kalan_tkfirmalar--

                        if($script:kalan_tkfirmalar -eq 0 ){
                            
                            Write-Host "Break Statement executed $script:kalan_tkfirmalar" -ForegroundColor Red
                                break
                                         }
                        }
                
                }
                # TK-ORTAK #
                elseif ($script:dbname -like "tk-ortak*" -and $script:dbcount -le "100" -and $script:kalan_tkortak -gt "0"){

                     $script:tasinacakdb=$script:dbname
                        Write-Host "işlem yapılan db $script:dbname" -ForegroundColor Yellow
                        $script:tasimasayisi=101-$script:dbcount
                        $script:x=1
 

                    while ($script:x -lt $script:tasimasayisi)
                        {

                        $script:identity=$script:TKortak_Params[$script:tkortak_0].Identity
                        Write-Host "işlem yapılan $script:identity " -ForegroundColor Blue
                        New-MoveRequest -Identity $script:identity -PrimaryOnly -TargetDatabase $script:tasinacakdb -BadItemLimit 100
                        $script:x++
                        $script:tkortak_0++
                        $script:kalan_tkortak--

                        if($script:kalan_tkortak -eq 0 ){
                            
                            Write-Host "Break Statement executed $script:kalan_tkortak" -ForegroundColor Red
                                break
                                         }
                        }
                
                }
                # TK-UCUCU-IDM #
                elseif ($script:dbname -like "tk-ucucu-idm*" -and $script:dbcount -le "350" -and $script:kalan_tkucucuidm -gt "0"){

                     $script:tasinacakdb=$script:dbname
                        Write-Host "işlem yapılan db $script:dbname" -ForegroundColor Yellow
                        $script:tasimasayisi=351-$script:dbcount
                        $script:x=1
 

                    while ($script:x -lt $script:tasimasayisi)
                        {

                        $script:identity=$script:TKucucuidm_Params[$script:tkucucuidm_0].Identity
                        Write-Host "işlem yapılan $script:identity " -ForegroundColor Blue
                        New-MoveRequest -Identity $script:identity -PrimaryOnly -TargetDatabase $script:tasinacakdb -BadItemLimit 100
                        $script:x++
                        $script:tkucucuidm_0++
                        $script:kalan_tkucucuidm--

                        if($script:kalan_tkucucuidm -eq 0 ){
                            
                            Write-Host "Break Statement executed $script:kalan_tkucucuidm " -ForegroundColor Red
                                break
                                         }
                        }
                
                }
                # TK-STJ #
                elseif ($script:dbname -like "tk-stj*" -and $script:dbcount -le "100" -and $script:kalan_tkstj -gt "0"){

                     $script:tasinacakdb=$script:dbname
                        Write-Host "işlem yapılan db $script:dbname" -ForegroundColor Yellow
                        $script:tasimasayisi=101-$script:dbcount
                        $script:x=1
 

                    while ($script:x -lt $script:tasimasayisi)
                        {

                        $script:identity=$script:TKstj_Params[$script:tkstj_0].Identity
                        Write-Host "işlem yapılan $script:identity " -ForegroundColor Blue
                        New-MoveRequest -Identity $script:identity -PrimaryOnly -TargetDatabase $script:tasinacakdb -BadItemLimit 100
                        $script:x++
                        $script:tkstj_0++
                        $script:kalan_tkstj--

                        if($script:kalan_tkstj -eq 0 ){
                            
                            Write-Host "Break Statement executed $script:kalan_tkstj " -ForegroundColor Red
                                break
                                         }
                        }
                
                }
                # TAS-BASKAN #
                elseif ($script:dbname -like "tas-baskan*" -and $script:dbcount -le "30" -and $script:kalan_tasbaskan -gt "0"){

                     $script:tasinacakdb=$script:dbname
                        Write-Host "işlem yapılan db $script:dbname" -ForegroundColor Yellow
                        $script:tasimasayisi=101-$script:dbcount
                        $script:x=1
 

                    while ($script:x -lt $script:tasimasayisi)
                        {

                        $script:identity=$script:TASbaskan_Params[$script:tasbaskan_0].Identity
                        Write-Host "işlem yapılan $script:identity " -ForegroundColor Blue
                        New-MoveRequest -Identity $script:identity -PrimaryOnly -TargetDatabase $script:tasinacakdb -BadItemLimit 100
                        $script:x++
                        $script:tasbaskan_0++
                        $script:kalan_tasbaskan--

                        if($script:kalan_tasbaskan -eq 0 ){
                            
                            Write-Host "Break Statement executed $script:kalan_tasbaskan " -ForegroundColor Red
                                break
                                         }
                        }
                
                }
                # TAS-MUDUR #
                elseif ($script:dbname -like "tas-mudur*" -and $script:dbcount -le "30" -and $script:kalan_tasmudur -gt "0"){

                     $script:tasinacakdb=$script:dbname
                        Write-Host "işlem yapılan db $script:dbname" -ForegroundColor Yellow
                        $script:tasimasayisi=101-$script:dbcount
                        $script:x=1
 

                    while ($script:x -lt $script:tasimasayisi)
                        {

                        $script:identity=$script:TASmudur_Params[$script:tasmudur_0].Identity
                        Write-Host "işlem yapılan $script:identity " -ForegroundColor Blue
                        New-MoveRequest -Identity $script:identity -PrimaryOnly -TargetDatabase $script:tasinacakdb -BadItemLimit 100
                        $script:x++
                        $script:tasmudur_0++
                        $script:kalan_tasmudur--

                        if($script:kalan_tasmudur -eq 0 ){
                            
                            Write-Host "Break Statement executed $script:kalan_tasmudur" -ForegroundColor Red
                                break
                                         }
                        }
                
                }
                # TAS-SEF #
                elseif ($script:dbname -like "tas-sef*" -and $script:dbcount -le "100" -and $script:kalan_tassef -gt "0"){

                     $script:tasinacakdb=$script:dbname
                        Write-Host "işlem yapılan db $script:dbname" -ForegroundColor Yellow
                        $script:tasimasayisi=101-$script:dbcount
                        $script:x=1
 

                    while ($script:x -lt $script:tasimasayisi)
                        {

                        $script:identity=$script:TASsef_Params[$script:tassef_0].Identity
                        Write-Host "işlem yapılan $script:identity " -ForegroundColor Blue
                        New-MoveRequest -Identity $script:identity -PrimaryOnly -TargetDatabase $script:tasinacakdb -BadItemLimit 100
                        $script:x++
                        $script:tassef_0++
                        $script:kalan_tassef--

                        if($script:kalan -eq 0 ){
                            
                            Write-Host "Break Statement executed $script:kalan_tassef" -ForegroundColor Red
                                break
                                         }
                        }
                
                }
                # TAS-STD #
                elseif ($script:dbname -like "tas-std*" -and $script:dbcount -le "100" -and $script:kalan_tasstd -gt "0"){

                     $script:tasinacakdb=$script:dbname
                        Write-Host "işlem yapılan db $script:dbname" -ForegroundColor Yellow
                        $script:tasimasayisi=101-$script:dbcount
                        $script:x=1
 

                    while ($script:x -lt $script:tasimasayisi)
                        {

                        $script:identity=$script:TASstd_Params[$script:tasstd_0].Identity
                        Write-Host "işlem yapılan $script:identity " -ForegroundColor Blue
                        New-MoveRequest -Identity $script:identity -PrimaryOnly -TargetDatabase $script:tasinacakdb -BadItemLimit 100
                        $script:x++
                        $script:tasstd_0++
                        $script:kalan_tasstd--

                        if($script:kalan_tasstd -eq 0 ){
                            
                            Write-Host "Break Statement executed $script:kalan_tasstd " -ForegroundColor Red
                                break
                                         }
                        }
                
                }
                # TAS-STJ #
                elseif ($script:dbname -like "tas-stj*" -and $script:dbcount -le "100" -and $script:kalan_tasstj -gt "0"){

                     $script:tasinacakdb=$script:dbname
                        Write-Host "işlem yapılan db $script:dbname" -ForegroundColor Yellow
                        $script:tasimasayisi=101-$script:dbcount
                        $script:x=1
 

                    while ($script:x -lt $script:tasimasayisi)
                        {

                        $script:identity=$script:TASstj_Params[$script:tasstj_0].Identity
                        Write-Host "işlem yapılan $script:identity " -ForegroundColor Blue
                        New-MoveRequest -Identity $script:identity -PrimaryOnly -TargetDatabase $script:tasinacakdb -BadItemLimit 100
                        $script:x++
                        $script:tasstj_0++
                        $script:kalan_tasstj--

                        if($script:kalan_tasstj -eq 0 ){
                            
                            Write-Host "Break Statement executed $script:kalan_tasstj" -ForegroundColor Red
                                break
                                         }
                        }
                
                }
                # TAS-TSR #
                elseif ($script:dbname -like "tas-tsr*" -and $script:dbcount -le "200" -and $script:kalan_tastsr -gt "0"){

                     $script:tasinacakdb=$script:dbname
                        Write-Host "işlem yapılan db $script:dbname" -ForegroundColor Yellow
                        $script:tasimasayisi=201-$script:dbcount
                        $script:x=1
 

                    while ($script:x -lt $script:tasimasayisi)
                        {

                        $script:identity=$script:TAStsr_Params[$script:tastsr_0].Identity
                        Write-Host "işlem yapılan $script:identity " -ForegroundColor Blue
                        New-MoveRequest -Identity $script:identity -PrimaryOnly -TargetDatabase $script:tasinacakdb -BadItemLimit 100
                        $script:x++
                        $script:tastsr_0++
                        $script:kalan_tastsr--

                       
                        if($script:kalan_tastsr -eq 0 ){
                            
                            Write-Host "Break Statement executed $script:kalan_tastsr" -ForegroundColor Red
                                break
                                         }
                        }
                
                }

        }

}

MoveIDMIterations

function MoveIDMStatistics {
        
  
  $script:MoveStatistics = @{

        "TKbaskan"	= $script:tkbaskan_0
        "TKmudur"	= $script:tkmudur_0
        "TKsef"		= $script:tksef_0
        "TKstd"		= $script:tkstd_0
        "TKkgbt"	= $script:tkkgbt_0
        "TKtsr"     = $script:tktsr_0
        "TKservis" 	= $script:tkservis_0
        "TKfirmalar"= $script:tkfirmalar_0
        "TKortak"	= $script:tkortak_0
        "TKucucu"	= $script:tkucucuidm_0
        "TKstj"		= $script:tkstj_0
        "TASbaskan"	= $script:tasbaskan_0
        "TASmudur"	= $script:tasmudur_0
        "TASsef"	= $script:tassef_0
        "TASstd"	= $script:tasstd_0
        "TAStsr"	= $script:tastsr_0
        "TASstj"	= $script:tasstj_0
        "Hatali"	= $script:tasinacak_hatali

    }

  $script:MoveStatistics = $script:MoveStatistics.Keys | select @{l='Database'; e={$_}}, @{l='Value';e={$script:MoveStatistics.$_}}

}

MoveIDMStatistics

$script:endtime = Get-Date
$script:totaltime = $script:endtime - $script:starttime

function MoveReport {

$script:header = @"
<style>

    h1 {

        font-family: Arial, Helvetica, sans-serif;
        color: #e68a00;
        font-size: 28px;

    }

    
    h2 {

        font-family: Arial, Helvetica, sans-serif;
        color: #000099;
        font-size: 16px;

    }

    
    
   table {
		font-size: 12px;
		border: 0px; 
		font-family: Arial, Helvetica, sans-serif;
	} 
	
    td {
		padding: 4px;
		margin: 0px;
		border: 0;
	}
	
    th {
        background: #395870;
        background: linear-gradient(#49708f, #293f50);
        color: #fff;
        font-size: 11px;
        text-transform: uppercase;
        padding: 10px 15px;
        vertical-align: middle;
	}

    tbody tr:nth-child(even) {
        background: #f0f0f2;
    }
    
    #CreationDate {

        font-family: Arial, Helvetica, sans-serif;
        color: #ff3300;
        font-size: 12px;

    }

</style>
"@

$script:head = "<h1>IDM Database Move Results</h1>"

$script:ExecuteTime = $script:totaltime | ConvertTo-Html -As List -Property Hours,Minutes,Seconds -Fragment -PreContent "<h2>Execution Time</h2>"

$script:MoveInfo = $script:MoveStatistics |ConvertTo-Html -Fragment -PreContent "<h2>Number of Moved Users</h2>"

$script:Report = ConvertTo-HTML -Body "$script:head $script:ExecuteTime $script:MoveInfo" -Head $script:header -PostContent "<p id='CreationDate'>Creation Date: $(Get-Date)</p>"

$script:Report | Out-File c:\sil\IDM-DB-Move-Report.html

}

MoveReport

function SendMail {

    $script:message = @{
    
    to = "msy@thy.com"
    from = "MSYDATABASEMOVE@THY.COM"
    subject = "IDM Database Move Results"
    smtpserver = "flrexcsrv1.thynet.thy.com"
    bodyashtml = $true
    body = $script:Report | Out-String
    
    }

    Send-MailMessage @script:message

}

SendMail           