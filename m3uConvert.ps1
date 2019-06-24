$Dir = Get-ChildItem -Path .\ | where {$_.extension -eq ".m3u"}
if((Test-Path 'out') -eq 0) {
  New-Item -ItemType Directory -Path .\out | Out-Null
} else {
  Remove-Item .\out\* -Force -recurse
}
foreach($File in $Dir) {
  $fname = [System.IO.Path]::GetFilename($File)
  $dname = [System.IO.Path]::GetFilenameWithoutExtension($File)
  $outFile = '.\out\'+$fname
  $outDir = '.\out\'+$dname
  New-Item -ItemType Directory -Path $outDir | Out-Null
  $outFile
  $a = $File | Get-Content
  foreach ( $line in $a ) {
      if($line -match '^[#]') {
        $line | Out-File -filePath $outFile -encoding "UTF8" -append
      }
      else {
        Copy-Item $line $outDir
        '.\'+$dname+'\'+[System.IO.Path]::GetFilename($line) | Out-File -filePath $outFile -encoding "UTF8" -append
      }
    }
}
