New-SelfSignedCertificate -DnsName pc1.blanc.local -CertStoreLocation Cert:\CurrentUser\My -Type CodeSigningCert
Move-Item Cert:\CurrentUser\My\66AD64A3C6F1B060AFC6E8143EC64637CA9A4622 -Destination Cert:\CurrentUser\Root
$cert = Get-ChildItem Cert:\CurrentUser\Root\66AD64A3C6F1B060AFC6E8143EC64637CA9A4622 -CodeSigningCert
Set-AuthenticodeSignature -FilePath '.\Desktop\Script signé 2.ps1' -Certificate $cert