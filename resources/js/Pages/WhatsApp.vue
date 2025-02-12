<script setup>
import { ref } from "vue";
import axios from "axios";

// Dados do telefone
const phone = ref("");
const message = ref("");
const loading = ref(false);
const countryCode = ref("+55"); // Padrão Brasil

// Lista de países e seus códigos
const countries = [
  { name: "Brasil", code: "BR", dial_code: "+55" },
  { name: "Estados Unidos", code: "US", dial_code: "+1" },
  { name: "Portugal", code: "PT", dial_code: "+351" },
  { name: "Argentina", code: "AR", dial_code: "+54" },
  { name: "México", code: "MX", dial_code: "+52" },
  // Adicione outros países conforme necessário
];

// Enviar mensagem pelo WhatsApp
const sendWhatsApp = async () => {
  if (!phone.value || !message.value) {
    alert("Preencha todos os campos!");
    return;
  }

  loading.value = true;
  try {
    const response = await axios.post("/api/send-whatsapp", {
      phone: phone.value,
      message: message.value,
      countryCode: countryCode.value, // Enviando o código do país
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
      <label class="block mb-2">Código do País:</label>
      <!-- Select para escolher o código do país -->
      <select v-model="countryCode" class="w-full p-2 border rounded mb-4">
        <option v-for="country in countries" :key="country.code" :value="country.dial_code">
          {{ country.name }} ({{ country.dial_code }})
        </option>
      </select>

      <label class="block mb-2">Número de Telefone:</label>
      <!-- Input para o número do telefone -->
      <input
        v-model="phone"
        type="text"
        placeholder="Ex: 11999999999"
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
        class="w-full p-2 bg-green-600 text-white rounded hover:bg-green-600"
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
