<template>
    <v-container
        class="py-10 px-6"
        fluid>
        <v-row>
            <v-col cols="12">
                <h1 class="text-h4 font-weight-bold text-primary mb-2">Advanced Encryption Standard (AES)</h1>
                <p class="text-subtitle-1 text-grey-darken-1">Criptografia Simétrica de Blocos - Padrão Mundial</p>
            </v-col>
        </v-row>

        <v-row>
            <v-col cols="12">
                <v-card
                    border
                    elevation="2">
                    <v-tabs
                        v-model="tabOperacao"
                        bg-color="primary-200">
                        <v-tab
                            value="cifrar"
                            prepend-icon="mdi-shield-lock"
                            >Encriptar (AES-128)</v-tab
                        >
                        <v-tab
                            value="decifrar"
                            prepend-icon="mdi-lock-open-variant"
                            >Desencriptar (AES-128)</v-tab
                        >
                    </v-tabs>

                    <v-card-text class="pa-6">
                        <v-row>
                            <v-col
                                cols="12"
                                md="6">
                                <h3 class="text-h6 mb-4 text-grey-darken-3">Entrada e Configuração</h3>

                                <v-text-field
                                    v-model="chaveAES"
                                    label="Chave Secreta (16 caracteres = 128 bits)"
                                    variant="outlined"
                                    color="primary"
                                    counter="16"
                                    persistent-hint
                                    hint="A segurança depende da confidencialidade desta chave."
                                    class="mb-4"></v-text-field>

                                <v-textarea
                                    v-model="inputTexto"
                                    :label="tabOperacao === 'cifrar' ? 'Texto em Claro (Mensagem)' : 'Criptograma (Base64)'"
                                    variant="outlined"
                                    color="primary"
                                    rows="5"
                                    placeholder="Escreve aqui..."></v-textarea>

                                <v-btn
                                    block
                                    color="primary"
                                    variant="tonal"
                                    prepend-icon="mdi-refresh"
                                    @click="inputTexto = ''"
                                    class="mt-4">
                                    Limpar Campos
                                </v-btn>
                            </v-col>

                            <v-col
                                cols="12"
                                md="6">
                                <v-card
                                    color="grey-darken-4"
                                    class="pa-6 h-100 border shadow-lg">
                                    <div class="d-flex justify-space-between align-center mb-4">
                                        <h3 class="text-h6 text-primary">Resultado</h3>
                                        <v-chip
                                            size="small"
                                            color="primary"
                                            variant="flat"
                                            >Modo ECB (Electronic Code Block)</v-chip
                                        >
                                    </div>

                                    <div class="result-box mb-6">
                                        <code class="text-white break-all text-body-1">
                                            {{ processarAES || 'Aguardando entrada...' }}
                                        </code>
                                    </div>

                                    <v-btn
                                        v-if="processarAES"
                                        variant="outlined"
                                        color="primary"
                                        prepend-icon="mdi-content-copy"
                                        @click="copiar(processarAES)">
                                        Copiar Resultado
                                    </v-btn>
                                </v-card>
                            </v-col>
                        </v-row>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>

        <v-row class="mt-10">
            <v-col cols="12">
                <v-card
                    theme="dark"
                    variant="flat"
                    border>
                    <v-tabs
                        v-model="tabDoc"
                        color="primary">
                        <v-tab value="python">Código Python (PyCryptodome)</v-tab>
                        <v-tab value="math">Processo Interno</v-tab>
                    </v-tabs>

                    <v-window
                        v-model="tabDoc"
                        class="pa-6 bg-grey-darken-4">
                        <v-window-item value="python">
                            <pre class="language-python"><code>{{ codigoPython }}</code></pre>
                        </v-window-item>

                        <v-window-item value="math">
                            <h3 class="text-h6 text-primary mb-4">Estrutura Matemática do AES</h3>
                            <p class="text-body-2 mb-4">
                                O AES opera numa matriz <span v-html="termMatrix"></span> de bytes. As operações são realizadas no corpo finito <span v-html="termGF"></span> definido pelo polinómio
                                redutível <span v-html="termPoly"></span>.
                            </p>

                            <v-list
                                density="compact"
                                bg-color="transparent">
                                <v-list-item class="mb-4">
                                    <template v-slot:prepend><v-icon color="primary">mdi-numeric-1-circle</v-icon></template>
                                    <div>
                                        <strong>SubBytes:</strong> Substituição não-linear.
                                        <div
                                            class="pa-3 bg-grey-darken-4 rounded my-2"
                                            v-html="formulaSubBytes"></div>
                                    </div>
                                </v-list-item>

                                <v-list-item class="mb-4">
                                    <template v-slot:prepend><v-icon color="primary">mdi-numeric-2-circle</v-icon></template>
                                    <div>
                                        <strong>ShiftRows:</strong> Permutação cíclica das linhas.
                                        <div
                                            class="pa-3 bg-grey-darken-4 rounded my-2"
                                            v-html="formulaShiftRows"></div>
                                    </div>
                                </v-list-item>

                                <v-list-item class="mb-4">
                                    <template v-slot:prepend><v-icon color="primary">mdi-numeric-3-circle</v-icon></template>
                                    <div>
                                        <strong>MixColumns:</strong> Multiplicação matricial.
                                        <div
                                            class="pa-3 bg-grey-darken-4 rounded my-2"
                                            v-html="formulaMixColumns"></div>
                                    </div>
                                </v-list-item>

                                <v-list-item class="mb-4">
                                    <template v-slot:prepend><v-icon color="primary">mdi-numeric-4-circle</v-icon></template>
                                    <div>
                                        <strong>AddRoundKey:</strong> Operação XOR com a chave.
                                        <div
                                            class="pa-3 bg-grey-darken-4 rounded my-2"
                                            v-html="formulaAddRoundKey"></div>
                                    </div>
                                </v-list-item>
                            </v-list>
                        </v-window-item>
                    </v-window>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>

<script setup lang="ts">
    import { ref, computed, onMounted } from 'vue';
    import CryptoJS from 'crypto-js';
    import Prism from 'prismjs';
    import katex from 'katex';

    const tabOperacao = ref('cifrar');
    const tabDoc = ref('python');
    const inputTexto = ref('');
    const chaveAES = ref('ChaveSecretaAES!'); // Exatamente 16 bytes

    const processarAES = computed(() => {
        if (!inputTexto.value || chaveAES.value.length < 1) return '';

        try {
            if (tabOperacao.value === 'cifrar') {
                // Cifração AES modo ECB (conforme o teu exemplo Python)
                const cifrado = CryptoJS.AES.encrypt(inputTexto.value, CryptoJS.enc.Utf8.parse(chaveAES.value), {
                    mode: CryptoJS.mode.ECB,
                    padding: CryptoJS.pad.Pkcs7,
                });
                return cifrado.toString(); // Retorna em Base64
            } else {
                // Decifração
                const decifrado = CryptoJS.AES.decrypt(inputTexto.value, CryptoJS.enc.Utf8.parse(chaveAES.value), {
                    mode: CryptoJS.mode.ECB,
                    padding: CryptoJS.pad.Pkcs7,
                });
                return decifrado.toString(CryptoJS.enc.Utf8);
            }
        } catch (e) {
            return 'Erro: Chave ou formato inválido.';
        }
    });

    const copiar = (txt: string) => navigator.clipboard.writeText(txt);

    const codigoPython = `
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad

# Chave de 16 bytes (128 bits)
key = b'ChaveSecretaAES!'
cipher = AES.new(key, AES.MODE_ECB)

# Encriptação com Padding
mensagem = b'Ola UMinho'
ct = cipher.encrypt(pad(mensagem, 16))

# Desencriptação
pt = unpad(cipher.decrypt(ct), 16)
`;

    const formulaSubBytes = computed(() => katex.renderToString("s_{i,j}^{'} = M \\cdot s_{i,j}^{-1} + b", { throwOnError: false }));

    const formulaShiftRows = computed(() => katex.renderToString("s_{i,j}^{'} = s_{i,(j+i) \\pmod 4}", { throwOnError: false }));

    const formulaMixColumns = computed(() =>
        katex.renderToString(
            "\\begin{bmatrix} s_{0,j}^{'} \\\\ s_{1,j}^{'} \\\\ s_{2,j}^{'} \\\\ s_{3,j}^{'} \\end{bmatrix} = " +
                '\\begin{bmatrix} 2 & 3 & 1 & 1 \\\\ 1 & 2 & 3 & 1 \\\\ 1 & 1 & 2 & 3 \\\\ 3 & 1 & 1 & 2 \\end{bmatrix} ' +
                '\\begin{bmatrix} s_{0,j} \\\\ s_{1,j} \\\\ s_{2,j} \\\\ s_{3,j} \\end{bmatrix}',
            { throwOnError: false },
        ),
    );

    const formulaAddRoundKey = computed(() => katex.renderToString("s_{i,j}^{'} = s_{i,j} \\oplus k_{i,j}", { throwOnError: false }));

    // Fórmulas menores para o corpo do texto
    const termMatrix = katex.renderToString('4 \\times 4', { throwOnError: false });
    const termGF = katex.renderToString('GF(2^8)', { throwOnError: false });
    const termPoly = katex.renderToString('P(x) = x^8 + x^4 + x^3 + x + 1', { throwOnError: false });

    onMounted(() => Prism.highlightAll());
</script>

<style scoped>
    .result-box {
        background: rgba(0, 0, 0, 0.3);
        padding: 15px;
        border-radius: 4px;
        min-height: 100px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .break-all {
        word-break: break-all;
    }
    pre {
        font-family: 'Fira Code', monospace;
        font-size: 0.85rem;
    }
</style>
