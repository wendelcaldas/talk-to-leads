<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class WhatsAppController extends Controller
{
    public function send(Request $request)
    {
        $request->validate([
            'phone' => 'required|string',
            'message' => 'required|string',
            'countryCode' => 'required|string|min:2', // Validação do código do país
        ]);

        $phone = preg_replace('/\D/', '', $request->phone);
        $fullPhoneNumber = $request->countryCode . $phone;
        $message = urlencode($request->message);

        $whatsappUrl = "https://wa.me/{$fullPhoneNumber}?text={$message}";

        return response()->json(['url' => $whatsappUrl]);
    }
}
