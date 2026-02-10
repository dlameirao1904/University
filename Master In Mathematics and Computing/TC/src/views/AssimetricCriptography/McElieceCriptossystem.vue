<template>
    <v-container
        class="py-10 px-6"
        fluid>
        <v-row>
            <v-col cols="12">
                <h1 class="text-h4 font-weight-bold text-primary mb-2">Simulador McEliece Configurável</h1>
                <p class="text-subtitle-1 text-grey-darken-1">Controlo total sobre as dimensões <span v-html="formulaK"></span> (mensagem) e <span v-html="formulaN"></span> (bloco)</p>
            </v-col>
        </v-row>

        <v-row>
            <v-col
                cols="12"
                md="4">
                <v-card
                    border
                    elevation="2"
                    class="mb-4">
                    <v-card-title class="bg-primary text-white text-subtitle-1">Configurações do Código</v-card-title>
                    <v-card-text class="pa-4">
                        <v-slider
                            v-model="k"
                            label="Tamanho da Mensagem (k)"
                            min="2"
                            max="5"
                            step="1"
                            thumb-label
                            color="primary"></v-slider>
                        <v-slider
                            v-model="n"
                            label="Tamanho do Bloco (n)"
                            :min="k + 1"
                            max="10"
                            step="1"
                            thumb-label
                            color="secondary"></v-slider>
                        <v-slider
                            v-model="t_errors"
                            label="Capacidade de Erro (t)"
                            min="1"
                            :max="Math.floor((n - k) / 2) || 1"
                            step="1"
                            thumb-label
                            color="error"></v-slider>

                        <v-btn
                            block
                            color="primary"
                            variant="elevated"
                            @click="resetSistema"
                            prepend-icon="mdi-refresh">
                            Regerar Matrizes
                        </v-btn>
                    </v-card-text>
                </v-card>

                <v-expansion-panels>
                    <v-expansion-panel title="Ver Matrizes da Chave Privada">
                        <v-expansion-panel-text>
                            <div class="mb-2 text-caption font-weight-bold text-primary">Matriz Geradora G ({{ k }}x{{ n }}):</div>
                            <div
                                class="matrix-scroll"
                                v-html="renderMatrix(G)"></div>
                            <v-divider class="my-2"></v-divider>
                            <div class="mb-2 text-caption font-weight-bold text-secondary">Matriz Scrambler S ({{ k }}x{{ k }}):</div>
                            <div
                                class="matrix-scroll"
                                v-html="renderMatrix(S)"></div>
                            <v-divider class="my-2"></v-divider>
                            <div class="mb-2 text-caption font-weight-bold text-error">Matriz Permutação P ({{ n }}x{{ n }}):</div>
                            <div
                                class="matrix-scroll"
                                v-html="renderMatrix(P)"></div>
                        </v-expansion-panel-text>
                    </v-expansion-panel>
                </v-expansion-panels>
            </v-col>

            <v-col
                cols="12"
                md="8">
                <v-card
                    border
                    elevation="2">
                    <v-toolbar
                        color="grey-lighten-4"
                        density="compact">
                        <v-toolbar-title class="text-body-2 font-weight-bold">Fluxo de Dados: m → c → y → m'</v-toolbar-title>
                    </v-toolbar>

                    <v-card-text class="pa-6">
                        <v-row>
                            <v-col
                                cols="12"
                                md="6">
                                <div class="text-subtitle-2 mb-2">1. Definir Mensagem <span v-html="formulaM"></span></div>
                                <div class="d-flex gap-1 mb-4">
                                    <v-btn
                                        v-for="(bit, idx) in m_bits"
                                        :key="idx"
                                        :color="bit === 1 ? 'primary' : 'grey'"
                                        size="small"
                                        @click="toggleBit(idx)">
                                        {{ bit }}
                                    </v-btn>
                                </div>
                                <div class="text-caption">
                                    Vetor <span v-html="formulaM"></span>: <code class="text-primary">[{{ m_bits.join(', ') }}]</code>
                                </div>
                            </v-col>

                            <v-col
                                cols="12"
                                md="6">
                                <div class="text-subtitle-2 mb-2">2. Injetar Ruído <span v-html="formulaE"></span></div>
                                <div class="d-flex flex-wrap gap-1 mb-2">
                                    <v-btn
                                        v-for="(bit, idx) in e_bits"
                                        :key="idx"
                                        :color="bit === 1 ? 'error' : 'grey-lighten-2'"
                                        icon
                                        size="x-small"
                                        @click="toggleErrorBit(idx)">
                                        <v-icon size="12">{{ bit === 1 ? 'mdi-close' : 'mdi-check' }}</v-icon>
                                    </v-btn>
                                </div>
                                <div class="text-caption">
                                    Peso de Hamming (<span v-html="formulaW"></span>):
                                    <v-chip
                                        :color="current_weight <= t_errors ? 'success' : 'error'"
                                        size="x-small">
                                        {{ current_weight }} / {{ t_errors }}
                                    </v-chip>
                                </div>
                            </v-col>
                        </v-row>

                        <v-divider class="my-6"></v-divider>

                        <v-row>
                            <v-col cols="12">
                                <div class="process-node highlight mb-4">
                                    <div class="node-label">Criptograma Enviado <span v-html="formulaCriptograma"></span></div>
                                    <div class="text-h5 text-mono">{{ y_vec.join('') }}</div>
                                </div>

                                <v-card
                                    variant="tonal"
                                    color="success"
                                    class="pa-4">
                                    <div class="d-flex justify-space-between align-center">
                                        <div>
                                            <div class="text-caption font-weight-bold">Mensagem Recuperada após Decodificação:</div>
                                            <div class="text-h4 text-mono">{{ decriptado.join('') }}</div>
                                        </div>
                                        <v-icon size="48">mdi-lock-check</v-icon>
                                    </div>
                                    <div
                                        class="text-caption mt-2"
                                        v-if="current_weight > t_errors">
                                        ⚠️ Atenção: Ruído > capacidade <span v-html="formulaT"></span>. A decodificação pode falhar.
                                    </div>
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
                        <v-tab value="math">Fundamentos da Álgebra Linear</v-tab>
                        <v-tab value="process">Fluxo de Matrizes</v-tab>
                        <v-tab value="live_math">Cálculos Atuais</v-tab>
                    </v-tabs>

                    <v-window
                        v-model="tabDoc"
                        class="pa-6 bg-grey-darken-4">
                        <v-window-item value="math">
                            <h3 class="text-h6 text-primary mb-4">Aritmética no Corpo Finito <span v-html="formulaGF2"></span></h3>
                            <p class="text-body-2 mb-4">Ao contrário do RSA que usa números inteiros grandes, o McEliece opera inteiramente em bits. As operações seguem a lógica binária:</p>
                            <v-row>
                                <v-col
                                    cols="12"
                                    md="6">
                                    <v-card
                                        variant="outlined"
                                        class="pa-4">
                                        <div class="text-subtitle-2 mb-2">Adição (XOR)</div>
                                        <div v-html="formulaXor"></div>
                                        <div class="text-caption mt-2">No simulador, isto é usado para injetar o ruído <span v-html="formulaE"></span>.</div>
                                    </v-card>
                                </v-col>
                                <v-col
                                    cols="12"
                                    md="6">
                                    <v-card
                                        variant="outlined"
                                        class="pa-4">
                                        <div class="text-subtitle-2 mb-2">Multiplicação (AND)</div>
                                        <div v-html="formulaAnd"></div>
                                        <div class="text-caption mt-2">Usado na multiplicação de matrizes <span v-html="formulaM"></span>.</div>
                                    </v-card>
                                </v-col>
                            </v-row>
                        </v-window-item>

                        <v-window-item value="process">
                            <h3 class="text-h6 text-primary mb-4">Construção da Chave Pública</h3>
                            <p class="text-body-2 mb-6">
                                O "disfarce" do código de Goppa é feito através de uma transformação linear que altera as propriedades visíveis da matriz sem mudar a sua capacidade de correção.
                            </p>

                            <v-list
                                density="compact"
                                bg-color="transparent">
                                <v-list-item
                                    v-for="(step, i) in rsaStepsMcEliece"
                                    :key="i"
                                    class="mb-4">
                                    <template v-slot:prepend>
                                        <v-icon color="primary">mdi-numeric-{{ i + 1 }}-circle</v-icon>
                                    </template>
                                    <div>
                                        <strong>{{ step.title }}:</strong> {{ step.desc }}
                                        <div
                                            class="pa-3 bg-grey-darken-3 rounded my-2 font-italic"
                                            v-html="step.formula"></div>
                                    </div>
                                </v-list-item>
                            </v-list>
                        </v-window-item>

                        <v-window-item value="live_math">
                            <h3 class="text-h6 text-primary mb-4">Demonstração Passo-a-Passo (Valores Atuais)</h3>
                            <p class="text-body-2 mb-6">
                                Abaixo podes ver como o sistema processa a tua mensagem <strong>m = [{{ m_bits.join(', ') }}]</strong> usando a aritmética de <span v-html="formulaGF2"></span>.
                            </p>

                            <v-row>
                                <v-col
                                    cols="12"
                                    md="7">
                                    <v-card
                                        variant="outlined"
                                        border
                                        class="pa-4 bg-black">
                                        <div class="text-overline text-primary mb-4">1. Codificação (m × Ĝ)</div>
                                        <div class="d-flex align-center justify-center flex-wrap gap-2">
                                            <span class="text-mono">[{{ m_bits.join(', ') }}]</span>
                                            <v-icon size="small">mdi-close</v-icon>
                                            <div v-html="renderMatrix(G_hat)"></div>
                                            <v-icon size="small">mdi-equal</v-icon>
                                            <span class="text-mono text-primary font-weight-bold">[{{ codificada_raw.join(', ') }}]</span>
                                        </div>
                                        <v-divider
                                            class="my-4"
                                            color="grey"></v-divider>
                                        <div
                                            class="text-caption"
                                            v-html="formulaCodificationOfG"></div>
                                    </v-card>
                                </v-col>

                                <v-col
                                    cols="12"
                                    md="5">
                                    <v-card
                                        variant="outlined"
                                        border
                                        class="pa-4 bg-black h-100">
                                        <div class="text-overline text-error mb-4">2. Injeção de Ruído (c ⊕ e)</div>
                                        <div class="d-flex flex-column align-center gap-2">
                                            <div class="d-flex justify-space-between w-100 px-4">
                                                <span>Vetor Limpo:</span>
                                                <code class="text-primary">{{ codificada_raw.join('') }}</code>
                                            </div>
                                            <div class="d-flex justify-space-between w-100 px-4">
                                                <span>Vetor Erro:</span>
                                                <code class="text-error">{{ e_bits.join('') }}</code>
                                            </div>
                                            <v-divider
                                                class="w-100"
                                                color="white"></v-divider>
                                            <div class="d-flex justify-space-between w-100 px-4">
                                                <strong>Criptograma (y):</strong>
                                                <strong class="text-white">{{ y_vec.join('') }}</strong>
                                            </div>
                                        </div>
                                        <p class="text-caption mt-6">Nota: Onde o erro é 1, o bit da mensagem é invertido (0→1 ou 1→0).</p>
                                    </v-card>
                                </v-col>
                            </v-row>
                        </v-window-item>
                    </v-window>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>

<script setup lang="ts">
    import { ref, computed, watch } from 'vue';
    import katex from 'katex';

    // Parâmetros do sistema
    const k = ref(3);
    const n = ref(7);
    const t_errors = ref(1);

    const m_bits = ref([1, 0, 1]);
    const e_bits = ref(Array(7).fill(0));

    // Matrizes
    const G = ref([]);
    const S = ref([]);
    const P = ref([]);

    // Gerar matrizes binárias aleatórias baseadas nos tamanhos k e n
    const gerarNovasMatrizes = () => {
        // Gerar G (k x n) - simplificado: Identity kxk + random k x (n-k)
        const newG = [];
        for (let i = 0; i < k.value; i++) {
            let row = Array(n.value).fill(0);
            row[i] = 1; // Parte Identidade
            for (let j = k.value; j < n.value; j++) {
                row[j] = Math.random() > 0.5 ? 1 : 0;
            }
            newG.push(row);
        }
        G.value = newG;

        // Gerar S (k x k) Invertível (simplificado)
        const newS = Array.from({ length: k.value }, (_, i) => Array.from({ length: k.value }, (_, j) => (i === j ? 1 : Math.random() > 0.8 ? 1 : 0)));
        S.value = newS;

        // Gerar P (n x n) Permutação
        const newP = Array.from({ length: n.value }, () => Array(n.value).fill(0));
        const indices = Array.from({ length: n.value }, (_, i) => i);
        indices.sort(() => Math.random() - 0.5);
        indices.forEach((val, idx) => {
            newP[idx][val] = 1;
        });
        P.value = newP;

        // Reset vetores
        m_bits.value = Array(k.value)
            .fill(0)
            .map(() => (Math.random() > 0.5 ? 1 : 0));
        e_bits.value = Array(n.value).fill(0);
    };

    // Álgebra Linear GF(2)
    const multiply = (A, B) => {
        const res = Array.from({ length: A.length }, () => Array(B[0].length).fill(0));
        for (let i = 0; i < A.length; i++) {
            for (let j = 0; j < B[0].length; j++) {
                let sum = 0;
                for (let l = 0; l < A[0].length; l++) {
                    sum = (sum + A[i][l] * B[l][j]) % 2;
                }
                res[i][j] = sum;
            }
        }
        return res;
    };

    // Chave Pública
    const G_hat = computed(() => {
        if (!G.value.length) return [];
        return multiply(multiply(S.value, G.value), P.value);
    });

    // Encriptação
    const y_vec = computed(() => {
        if (!G_hat.value.length) return [];
        const m_vec = [m_bits.value];
        const encoded = multiply(m_vec, G_hat.value)[0];
        return encoded.map((val, idx) => (val + e_bits.value[idx]) % 2);
    });

    // Simulação de Decriptação
    const decriptado = computed(() => {
        // Se o peso do erro for <= t, garantimos a recuperação da mensagem original
        return current_weight.value <= t_errors.value ? m_bits.value : m_bits.value.map((b) => (Math.random() > 0.5 ? b : 1 - b));
    });

    const current_weight = computed(() => e_bits.value.filter((b) => b === 1).length);

    // UI Handlers
    const toggleBit = (idx) => {
        m_bits.value[idx] = m_bits.value[idx] === 1 ? 0 : 1;
    };
    const toggleErrorBit = (idx) => {
        e_bits.value[idx] = e_bits.value[idx] === 1 ? 0 : 1;
    };

    const renderMatrix = (m) => {
        if (!m.length) return '';
        return `<table class="matrix-table">${m.map((row) => `<tr>${row.map((v) => `<td>${v}</td>`).join('')}</tr>`).join('')}</table>`;
    };

    const resetSistema = () => {
        gerarNovasMatrizes();
    };

    watch(
        [k, n],
        () => {
            resetSistema();
        },
        { immediate: true },
    );

    const tabDoc = ref('math');

    // Fórmulas KaTeX para a explicação
    const formulaXor = computed(() => katex.renderToString('0 \\oplus 0 = 0, \\quad 1 \\oplus 1 = 0, \\quad 1 \\oplus 0 = 1', { throwOnError: false }));

    const formulaAnd = computed(() => katex.renderToString('0 \\cdot 1 = 0, \\quad 1 \\cdot 1 = 1', { throwOnError: false }));

    const formulaK = computed(() => katex.renderToString('k', { throwOnError: false }));

    const formulaN = computed(() => katex.renderToString('n', { throwOnError: false }));    

    const formulaE = computed(() => katex.renderToString('e', { throwOnError: false }));

    const formulaM = computed(() => katex.renderToString('m \\times \\hat{G}', { throwOnError: false }));

    const formulaW = computed(() => katex.renderToString('w', { throwOnError: false }));

    const formulaCriptograma = computed(() => katex.renderToString('y = m \\times \\hat{G} \\oplus e', { throwOnError: false }));

    const formulaT = computed(() => katex.renderToString('t', { throwOnError: false }));

    const formulaGF2 = computed(() => katex.renderToString('GF(2)', { throwOnError: false }));

    const formulaCodificationOfG = computed(() => katex.renderToString('Cada\\ bit\\ c_j\\ é\\ calculado\\ como:\\ c_j = \\bigoplus_{i=0}^{k-1} (m_i \\cdot \\hat{G}_{i,j})', { throwOnError: false }));
    
    const rsaStepsMcEliece = [
        {
            title: 'Disfarce de Linhas (Scrambler S)',
            desc: 'Multiplicar por S combina as linhas de G. Um atacante não consegue saber quais eram as linhas originais do código.',
            formula: katex.renderToString('G_{temp} = S_{k \\times k} \\times G_{k \\times n}', { throwOnError: false }),
        },
        {
            title: 'Disfarce de Colunas (Permutação P)',
            desc: 'Multiplicar por P troca a ordem das colunas. Isto esconde a estrutura polinomial do código de Goppa.',
            formula: katex.renderToString('\\hat{G} = G_{temp} \\times P_{n \\times n}', { throwOnError: false }),
        },
        {
            title: 'Encriptação com Erro',
            desc: "A mensagem é codificada e 'sujada' com um vetor de erro aleatório de peso t.",
            formula: katex.renderToString('y = (m \\times \\hat{G}) \\oplus e', { throwOnError: false }),
        },
        {
            title: 'O Problema NP-Difícil',
            desc: "Para quem não tem a chave privada, recuperar m de y é o 'Problema da Decodificação Geral'.",
            formula: katex.renderToString('\\text{Achar } m \\text{ tal que } \\text{dist}_H(m\\hat{G}, y) \\le t', { throwOnError: false }),
        },
    ];

    const codificada_raw = computed(() => {
        if (!G_hat.value.length) return [];
        const m_vec = [m_bits.value];
        return multiply(m_vec, G_hat.value)[0];
    });
</script>

<style scoped>
    .matrix-scroll {
        overflow-x: auto;
        background: #1e1e1e;
        color: #4caf50;
        padding: 8px;
        border-radius: 4px;
    }
    .matrix-table {
        border-collapse: collapse;
        margin: 0 auto;
        font-family: monospace;
    }
    .matrix-table td {
        width: 18px;
        text-align: center;
        border: 1px solid #333;
        font-size: 0.75rem;
    }
    .gap-1 {
        gap: 4px;
    }
    .process-node {
        text-align: center;
        padding: 20px;
        border-radius: 12px;
        border: 2px dashed #ccc;
    }
    .process-node.highlight {
        background: #f5f5f5;
        border-color: #1976d2;
    }
    .text-mono {
        font-family: 'Fira Code', monospace;
        font-weight: bold;
    }
</style>
