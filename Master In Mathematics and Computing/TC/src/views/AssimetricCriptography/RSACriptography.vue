<template>
    <v-container
        class="py-10 px-6"
        fluid>
        <v-row>
            <v-col cols="12">
                <h1 class="text-h4 font-weight-bold text-primary mb-2">Rivest–Shamir–Adleman (RSA)</h1>
                <p class="text-subtitle-1 text-grey-darken-1">Criptografia de Chave Pública - Baseada em Fatorização Prima</p>
            </v-col>
        </v-row>

        <v-row>
            <v-col
                cols="12"
                md="5">
                <v-card
                    border
                    elevation="2"
                    class="h-100">
                    <v-toolbar
                        color="primary-lighten-1"
                        density="compact">
                        <v-toolbar-title class="text-subtitle-1">Geração de Parâmetros</v-toolbar-title>
                    </v-toolbar>

                    <v-card-text class="pa-6">
                        <p class="text-body-2 mb-4">Escolha dois números primos ($p$ e $q$):</p>
                        <v-row dense>
                            <v-col cols="6">
                                <v-text-field
                                    v-model.number="p"
                                    label="Primo p"
                                    type="number"
                                    variant="outlined"
                                    density="comfortable"
                                    color="primary"></v-text-field>
                            </v-col>
                            <v-col cols="6">
                                <v-text-field
                                    v-model.number="q"
                                    label="Primo q"
                                    type="number"
                                    variant="outlined"
                                    density="comfortable"
                                    color="primary"></v-text-field>
                            </v-col>
                        </v-row>
                        <v-btn
                            block
                            class="mt-2"
                            color="primary"
                            variant="tonal"
                            prepend-icon="mdi-key-plus"
                            @click="gerarParametros"
                            >Gerar Novas Chaves</v-btn
                        >

                        <v-divider class="my-6"></v-divider>

                        <div
                            v-if="n"
                            class="d-flex flex-column gap-2">
                            <v-alert
                                border="start"
                                color="secondary"
                                variant="tonal"
                                class="mb-2"
                                density="compact">
                                <template v-slot:prepend
                                    ><v-chip
                                        size="x-small"
                                        color="secondary"
                                        >n</v-chip
                                    ></template
                                >
                                <strong>Módulo:</strong> {{ n }}
                            </v-alert>
                            <v-alert
                                border="start"
                                color="primary"
                                variant="tonal"
                                class="mb-2"
                                density="compact">
                                <template v-slot:prepend
                                    ><v-chip
                                        size="x-small"
                                        color="primary"
                                        >e</v-chip
                                    ></template
                                >
                                <strong>Púb:</strong> {{ e }}
                            </v-alert>
                            <v-alert
                                border="start"
                                color="error"
                                variant="tonal"
                                density="compact">
                                <template v-slot:prepend
                                    ><v-chip
                                        size="x-small"
                                        color="error"
                                        >d</v-chip
                                    ></template
                                >
                                <strong>Priv:</strong> {{ d }}
                            </v-alert>
                        </div>
                    </v-card-text>
                </v-card>
            </v-col>

            <v-col
                cols="12"
                md="7">
                <v-card
                    border
                    elevation="2">
                    <v-tabs
                        v-model="tab"
                        bg-color="grey-lighten-4"
                        color="primary">
                        <v-tab
                            value="encrypt"
                            prepend-icon="mdi-lock"
                            >Encriptar</v-tab
                        >
                        <v-tab
                            value="decrypt"
                            prepend-icon="mdi-lock-open"
                            >Desencriptar</v-tab
                        >
                    </v-tabs>

                    <v-card-text class="pa-6">
                        <v-window v-model="tab">
                            <v-window-item value="encrypt">
                                <v-textarea
                                    class="mt-2"
                                    v-model="inputText"
                                    label="Texto Original"
                                    variant="outlined"
                                    color="primary"
                                    rows="4"
                                    placeholder="Ex: Ola UMinho"></v-textarea>
                                <div class="result-container mt-4">
                                    <div class="text-caption text-primary font-weight-bold mb-1">Criptograma (Array de Inteiros):</div>
                                    <div class="result-box">{{ encryptedData.join(', ') || '...' }}</div>
                                </div>
                            </v-window-item>

                            <v-window-item value="decrypt">
                                <v-textarea
                                    class="mt-2"
                                    v-model="manualCipher"
                                    label="Criptograma (Números separados por vírgula)"
                                    variant="outlined"
                                    color="primary"
                                    rows="4"></v-textarea>
                                <div class="result-container mt-4">
                                    <div class="text-caption text-success font-weight-bold mb-1">Mensagem Decifrada:</div>
                                    <div class="result-box text-h6 text-success">{{ decryptedText || '...' }}</div>
                                </div>
                            </v-window-item>
                        </v-window>
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
                        <v-tab value="python">Exemplo Python</v-tab>
                        <v-tab value="math">Fundamentos Matemáticos</v-tab>
                    </v-tabs>

                    <v-window
                        v-model="tabDoc"
                        class="pa-6 bg-grey-darken-4">
                        <v-window-item value="python">
                            <pre class="language-python"><code>{{ codigoPython }}</code></pre>
                        </v-window-item>

                        <v-window-item value="math">
                            <h3 class="text-h6 text-primary mb-4">Fundamentos Matemáticos do RSA</h3>
                            <p class="text-body-2 mb-6">
                                A segurança do RSA baseia-se no <strong>Problema da Fatorização Inteira</strong>. Enquanto multiplicar dois primos é simples, reverter o processo para descobrir $p$ e
                                $q$ a partir de $n$ é computacionalmente inviável para números grandes.
                            </p>

                            <v-list
                                density="compact"
                                bg-color="transparent">
                                <v-list-item
                                    v-for="(step, i) in rsaSteps"
                                    :key="i"
                                    class="mb-4">
                                    <template v-slot:prepend>
                                        <v-icon color="primary">mdi-numeric-{{ i + 1 }}-circle</v-icon>
                                    </template>
                                    <div>
                                        <strong class="text-primary">{{ step.title }}</strong>
                                        <div class="text-body-2 text-grey-lighten-1">{{ step.desc }}</div>
                                        <div
                                            class="pa-3 bg-grey-darken-3 rounded my-2"
                                            v-html="step.formula"></div>
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
    import { ref, computed, watch, onMounted } from 'vue';
    import Prism from 'prismjs';
    import katex from 'katex';

    // Estados
    const p = ref(61);
    const q = ref(53);
    const n = ref(0);
    const e = ref(0);
    const d = ref(0);
    const tab = ref('encrypt');
    const tabDoc = ref('python');
    const inputText = ref('Olá');
    const manualCipher = ref('');

    // Funções Matemáticas
    const mdc = (a: number, b: number): number => {
        while (b !== 0) [a, b] = [b, a % b];
        return a;
    };

    const inversoModular = (e: number, phi: number): number => {
        let [x1, x2, y1, y2] = [0, 1, 1, 0];
        let [temp_phi, temp_e] = [phi, e];
        while (temp_e > 0) {
            let q_div = Math.floor(temp_phi / temp_e);
            let r = temp_phi - q_div * temp_e;
            temp_phi = temp_e;
            temp_e = r;
            let x = x2 - q_div * x1;
            let y = y2 - q_div * y1;
            [x2, x1, y2, y1] = [x1, x, y1, y];
        }
        return y2 < 0 ? y2 + phi : y2;
    };

    const powerMod = (base: number, exp: number, mod: number): number => {
        let res = 1;
        base = base % mod;
        while (exp > 0) {
            if (exp % 2 === 1) res = (res * base) % mod;
            base = (base * base) % mod;
            exp = Math.floor(exp / 2);
        }
        return res;
    };

    const gerarParametros = () => {
        n.value = p.value * q.value;
        const phi = (p.value - 1) * (q.value - 1);
        let tempE = 3;
        while (mdc(tempE, phi) !== 1 && tempE < phi) tempE += 2;
        e.value = tempE;
        d.value = inversoModular(e.value, phi);
    };

    // Computeds
    const encryptedData = computed(() => {
        if (!n.value || !e.value) return [];
        return inputText.value.split('').map((char) => powerMod(char.charCodeAt(0), e.value, n.value));
    });

    const decryptedText = computed(() => {
        if (!n.value || !d.value || !manualCipher.value) return '';
        try {
            const numbers = manualCipher.value
                .split(',')
                .filter((x) => x.trim() !== '')
                .map((n) => parseInt(n.trim()));
            return numbers.map((num) => String.fromCharCode(powerMod(num, d.value, n.value))).join('');
        } catch {
            return 'Erro nos dados';
        }
    });

    watch(
        encryptedData,
        (newVal) => {
            manualCipher.value = newVal.join(', ');
        },
        { immediate: true },
    );

    // Documentação
    const codigoPython = `
from Crypto.PublicKey import RSA
from Crypto.Cipher import PKCS1_OAEP

# Geração de chave (2048 bits é o padrão atual)
key = RSA.generate(2048)
private_key = key.export_key()
public_key = key.publickey().export_key()

# Cifração com a Chave Pública
cipher_rsa = PKCS1_OAEP.new(RSA.import_key(public_key))
mensagem = b"Ola UMinho"
ciphertext = cipher_rsa.encrypt(mensagem)

# Decifração com a Chave Privada
decrypt_rsa = PKCS1_OAEP.new(RSA.import_key(private_key))
plaintext = decrypt_rsa.decrypt(ciphertext)
`;

    const rsaSteps = [
        {
            title: '1. Cálculo do Módulo',
            desc: 'O módulo n é a base para ambas as chaves.',
            formula: katex.renderToString('n = p \\times q', { throwOnError: false }),
        },
        {
            title: '2. Função Totiente (phi)',
            desc: 'Calcula-se a quantidade de números coprimos a n.',
            formula: katex.renderToString('\\phi(n) = (p-1)(q-1)', { throwOnError: false }),
        },
        {
            title: '3. Escolha do Expoente Público (e)',
            desc: 'Deve ser coprimo de phi(n). Geralmente usa-se 65537.',
            formula: katex.renderToString('1 < e < \\phi(n) \\text{ tal que } \\text{gcd}(e, \\phi(n)) = 1', { throwOnError: false }),
        },
        {
            title: '4. Cálculo da Chave Privada (d)',
            desc: "O inverso modular de 'e'. É o segredo que permite decifrar.",
            formula: katex.renderToString('d \\cdot e \\equiv 1 \\pmod{\\phi(n)}', { throwOnError: false }),
        },
        {
            title: '5. Cifragem',
            desc: "Transforma a mensagem 'm' em criptograma 'c'.",
            formula: katex.renderToString('c = m^e \\pmod n', { throwOnError: false }),
        },
        {
            title: '6. Decifragem',
            desc: 'Recupera a mensagem original usando a chave privada.',
            formula: katex.renderToString('m = c^d \\pmod n', { throwOnError: false }),
        },
    ];

    onMounted(() => {
        gerarParametros();
        Prism.highlightAll();
    });
</script>

<style scoped>
    .result-box {
        background: rgba(var(--v-theme-surface-variant), 0.2);
        padding: 16px;
        border-radius: 8px;
        border: 1px dashed rgba(var(--v-border-color), 0.3);
        min-height: 80px;
        word-break: break-all;
        font-family: 'Fira Code', monospace;
        font-size: 0.9rem;
    }
    pre {
        font-family: 'Fira Code', monospace;
        font-size: 0.85rem;
        overflow-x: auto;
    }
    .gap-2 {
        gap: 8px;
    }
</style>
