[Reflection.Assembly]::LoadWithPartialName("System.Drawing")

#--

$filename = "c:\foo.png"
$res      = @{x = 1920; y = 1080}
$fontData = @{
    text = @"
This is a message from Houston Community College IT Department.

Your Windows 7 Computer needs to be upgraded IMMEDIATELY!
Please contact the HCC Service Desk at 713-718-8800.

This computer will be LOCKED if no communication is received by January 15, 2022.

(HCC will be closed for Winter Break from December 20, 2021 to January 2, 2022)
"@
size = 24
font = "Consolas"
}
$brushBg  = [System.Drawing.Brushes]::Orange 
$brushFg  = [System.Drawing.Brushes]::Black

if ( Test-Path $filename ) { Remove-Item $filename -Force }

$bmp      = new-object System.Drawing.Bitmap $res.x, $res.y 
$font     = new-object System.Drawing.Font $fontData.font, $fontData.size

$graphics = [System.Drawing.Graphics]::FromImage($bmp) 
    $graphics.FillRectangle($brushBg, 0, 0, $bmp.Width, $bmp.Height) 
    $graphics.DrawString($fontData.text, $font, $brushFg, $res.x * 0.12, $res.y * 0.3) 
    $graphics.Dispose()

$bmp.Save($filename)

Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $filename # Apply the wallpaper
rundll32.exe user32.dll, UpdatePerUserSystemParameters # Update user profile immediately