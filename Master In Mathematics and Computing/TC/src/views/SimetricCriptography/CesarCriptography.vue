<template>
    <v-container
        class="py-10 px-6"
        fluid>
        <v-row>
            <v-col cols="12">
                <h1 class="text-h4 font-weight-bold text-primary mb-2">Cifra de César: Ferramenta</h1>
                <p class="text-subtitle-1 text-grey-darken-1">Tratamento de mensagens no corpo $\mathbb{Z}_{26}$</p>
            </v-col>
        </v-row>

        <v-row>
            <v-col cols="12">
                <v-card border>
                    <v-tabs
                        v-model="tabOperacao"
                        bg-color="primary-200">
                        <v-tab
                            value="cifrar"
                            prepend-icon="mdi-lock"
                            >Encriptar Mensagem</v-tab
                        >
                        <v-tab
                            value="decifrar"
                            prepend-icon="mdi-lock-open"
                            >Desencriptar Criptograma</v-tab
                        >
                    </v-tabs>

                    <v-card-text class="pa-6">
                        <v-row>
                            <v-col
                                cols="12"
                                md="6">
                                <h3 class="text-h6 mb-4">Entrada de Dados</h3>

                                <v-textarea
                                    v-model="inputUsuario"
                                    :label="tabOperacao === 'cifrar' ? 'Texto Original' : 'Criptograma para Desencriptar'"
                                    variant="outlined"
                                    color="primary"
                                    rows="5"
                                    :placeholder="tabOperacao === 'cifrar' ? 'Escreva a mensagem aqui...' : 'Cole o código cifrado aqui...'"></v-textarea>

                                <v-slider
                                    v-model="chave"
                                    min="0"
                                    max="25"
                                    step="1"
                                    label="Chave (k)"
                                    thumb-label="always"
                                    color="primary"
                                    class="mt-6"></v-slider>

                                <v-btn
                                    block
                                    variant="tonal"
                                    color="primary"
                                    prepend-icon="mdi-eraser"
                                    @click="inputUsuario = ''">
                                    Limpar Campo
                                </v-btn>
                            </v-col>

                            <v-col
                                cols="12"
                                md="6">
                                <v-card
                                    color="grey-darken-4"
                                    class="pa-6 h-100 text-center border">
                                    <h3 class="text-h6 mb-6 text-primary">Resultado Final</h3>

                                    <div class="text-h4 text-white font-family-monospace break-all mb-6">
                                        {{ processarTexto }}
                                    </div>

                                    <v-btn
                                        v-if="processarTexto"
                                        variant="outlined"
                                        color="primary"
                                        prepend-icon="mdi-content-copy"
                                        @click="copiarResultado">
                                        Copiar Resultado
                                    </v-btn>

                                    <v-divider class="my-6 border-opacity-25"></v-divider>

                                    <div class="text-caption text-grey-lighten-1 mb-2">Mapeamento Atual:</div>
                                    <div
                                        class="d-flex flex-wrap justify-center overflow-auto"
                                        style="max-height: 120px">
                                        <div
                                            v-for="l in ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']"
                                            :key="l"
                                            class="mx-1 pa-2 border rounded">
                                            <span class="text-white">{{ l }}</span>
                                            <v-icon
                                                size="x-small"
                                                class="mx-1"
                                                >mdi-arrow-right</v-icon
                                            >
                                            <span class="text-primary">{{ converterLetra(l) }}</span>
                                        </div>
                                    </div>
                                </v-card>
                            </v-col>
                        </v-row>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>

        <v-row class="mt-8">
            <v-col cols="12">
                <v-card
                    theme="dark"
                    variant="outlined">
                    <v-tabs
                        v-model="tabInfo"
                        density="compact">
                        <v-tab value="code">Código Sage/Python</v-tab>
                        <v-tab value="math">Fundamento Matemático</v-tab>
                    </v-tabs>
                    <v-window
                        v-model="tabInfo"
                        class="pa-4 bg-grey-darken-3">
                        <v-window-item value="code">
                            <pre class="language-python"><code>{{ codigoPython }}</code></pre>
                        </v-window-item>
                        <v-window-item value="math">
                            <div class="text-center pa-4">
                                <div
                                    v-html="formulaC"
                                    class="mb-2"></div>
                                <div v-html="formulaP"></div>
                            </div>
                        </v-window-item>
                    </v-window>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>

<script setup lang="ts">
    import { ref, computed, onMounted } from 'vue';
    import Prism from 'prismjs';
    import 'prismjs/themes/prism-tomorrow.css';
    import 'prismjs/components/prism-python';
    import katex from 'katex';
    import 'katex/dist/katex.min.css';

    const tabOperacao = ref('cifrar');
    const tabInfo = ref('code');
    const inputUsuario = ref('');
    const chave = ref(3);

    const formulaC = computed(() => katex.renderToString('C \\equiv (P + K) \\pmod{26}', { displayMode: true }));
    const formulaP = computed(() => katex.renderToString('P \\equiv (C - K) \\pmod{26}', { displayMode: true }));

    const converterLetra = (letra: string) => {
        const kEfetivo = tabOperacao.value === 'cifrar' ? chave.value : -chave.value;
        const code = letra.charCodeAt(0);
        const base = 65; // Apenas para exemplo maiúsculo no mapeamento
        return String.fromCharCode(((code - base + (kEfetivo % 26) + 26) % 26) + base);
    };

    const processarTexto = computed(() => {
        if (!inputUsuario.value) return '';

        const kEfetivo = tabOperacao.value === 'cifrar' ? chave.value : -chave.value;

        return inputUsuario.value
            .split('')
            .map((char) => {
                if (char.match(/[a-z]/i)) {
                    const code = char.charCodeAt(0);
                    const base = code >= 65 && code <= 90 ? 65 : 97;
                    return String.fromCharCode(((code - base + (kEfetivo % 26) + 26) % 26) + base);
                }
                return char;
            })
            .join('');
    });

    const copiarResultado = () => {
        navigator.clipboard.writeText(processarTexto.value);
    };

    const codigoPython = `
# Implementação em SageMath
def cifra_cesar(mensagem, k):
    resultado = ""
    for c in mensagem:
        if c.isalpha():
            base = ord('A') if c.isupper() else ord('a')
            # C = (P + K) mod 26
            resultado += chr((ord(c) - base + k) % 26 + base)
        else:
            resultado += c
    return resultado

# Para decifrar, usamos a chave negativa:
# P = (C - K) mod 26
def decifra_cesar(criptograma, k):
    return cifra_cesar(criptograma, -k)
`;

    onMounted(() => {
        Prism.highlightAll();
    });
</script>

<style scoped>
    .break-all {
        word-break: break-all;
    }
    pre {
        background: transparent !important;
        margin: 0;
    }
    code {
        font-family: 'Fira Code', monospace !important;
    }
</style>
