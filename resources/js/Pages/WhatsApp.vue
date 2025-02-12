<script setup>
import { ref } from "vue";
import axios from "axios";

const phone = ref("");
const message = ref("");
const loading = ref(false);

const sendWhatsApp = async () => {
    if (!phone.value || !message.value) {
        alert("Preencha todos os campos!");
        return;
    }

    loading.value = true;
    try {
        const response = await axios.post("/api/send-whatsapp", {
            phone: phone.value,
            message: message.value
        });
        window.open(response.data.url, "_blank");
    } catch (error) {
        alert("Erro ao enviar mensagem!");
    } finally {
        loading.value = false;
    }
};
</script>

<template>
    <div class="flex flex-col items-center justify-center min-h-screen">
        <h1 class="text-2xl font-bold mb-4">Enviar WhatsApp</h1>
        <div class="w-full max-w-md p-4 bg-white shadow rounded">
            <label class="block mb-2">Número de Telefone:</label>
            <input
                v-model="phone"
                type="text"
                placeholder="Ex: 5511999999999"
                class="w-full p-2 border rounded mb-4"
            />

            <label class="block mb-2">Mensagem:</label>
            <textarea
                v-model="message"
                placeholder="Digite sua mensagem..."
                class="w-full p-2 border rounded mb-4"
            ></textarea>

            <button
                :disabled="loading"
                @click="sendWhatsApp"
                class="w-full p-2 bg-green text-black rounded hover:bg-green-600"
            >
                {{ loading ? "Enviando..." : "Enviar" }}
            </button>
        </div>
    </div>
</template>

<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
}
</style>
