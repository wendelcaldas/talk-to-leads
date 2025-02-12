<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class WhatsAppController extends Controller
{
    public function send(Request $request)
    {
        $request->validate([
            'phone' => 'required|string',
            'message' => 'required|string'
        ]);

        $phone = preg_replace('/\D/', '', $request->phone);
        $message = urlencode($request->message);

        $whatsappUrl = "https://wa.me/{$phone}?text={$message}";

        return response()->json(['url' => $whatsappUrl]);
    }
}
