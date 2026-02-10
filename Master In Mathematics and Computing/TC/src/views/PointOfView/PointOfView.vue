<template>
    <v-container
        class="py-10 px-6"
        fluid>
        <v-row>
            <v-col cols="12">
                <h1 class="text-h4 font-weight-bold text-primary mb-2">Análise de Segurança e Performance</h1>
                <p class="text-subtitle-1 text-grey-darken-1">Comparativo entre Criptossistemas: Do Clássico ao Pós-Quântico</p>
            </v-col>
        </v-row>

        <v-row>
            <v-col
                v-for="cifra in analiseDados"
                :key="cifra.nome"
                cols="12"
                md="6"
                lg="3">
                <v-card
                    border
                    elevation="3"
                    class="h-100 d-flex flex-column"
                    @click="
                        selecionado = cifra;
                        drawer = true;
                    ">
                    <v-toolbar
                        :color="cifra.cor"
                        theme="dark"
                        density="compact">
                        <v-icon class="ml-3">{{ cifra.icone }}</v-icon>
                        <v-toolbar-title class="text-body-1 font-weight-bold">{{ cifra.nome }}</v-toolbar-title>
                    </v-toolbar>

                    <v-card-text class="flex-grow-1">
                        <div class="mb-4">
                            <div class="text-caption font-weight-bold text-success uppercase">Vantagens</div>
                            <v-list density="compact">
                                <v-list-item
                                    v-for="(v, i) in cifra.vantagens"
                                    :key="i"
                                    class="px-0">
                                    <template v-slot:prepend
                                        ><v-icon
                                            size="x-small"
                                            color="success"
                                            >mdi-check-circle</v-icon
                                        ></template
                                    >
                                    <v-list-item-subtitle class="text-body-2 text-high-emphasis">{{ v }}</v-list-item-subtitle>
                                </v-list-item>
                            </v-list>
                        </div>

                        <v-divider class="mb-4"></v-divider>

                        <div class="mb-4">
                            <div class="text-caption font-weight-bold text-warning uppercase">Desvantagens</div>
                            <v-list density="compact">
                                <v-list-item
                                    v-for="(d, i) in cifra.desvantagens"
                                    :key="i"
                                    class="px-0">
                                    <template v-slot:prepend
                                        ><v-icon
                                            size="x-small"
                                            color="warning"
                                            >mdi-alert-circle</v-icon
                                        ></template
                                    >
                                    <v-list-item-subtitle class="text-body-2 text-high-emphasis">{{ d }}</v-list-item-subtitle>
                                </v-list-item>
                            </v-list>
                        </div>
                    </v-card-text>

                    <v-divider></v-divider>
                    <v-card-actions class="bg-grey-lighten-4 pa-4">
                        <div class="w-100">
                            <div class="text-caption font-weight-bold text-error uppercase mb-1">Principais Ataques</div>
                            <v-chip-group>
                                <v-chip
                                    v-for="ataque in cifra.ataques"
                                    :key="ataque"
                                    size="x-small"
                                    color="error"
                                    variant="flat">
                                    {{ ataque }}
                                </v-chip>
                            </v-chip-group>
                        </div>
                    </v-card-actions>
                </v-card>
            </v-col>
        </v-row>

        <v-row class="mt-10">
            <v-col cols="12">
                <v-card border>
                    <v-card-title class="text-h6 pa-4">Resumo Técnico Comparativo</v-card-title>
                    <v-table>
                        <thead>
                            <tr>
                                <th class="text-left">Algoritmo</th>
                                <th class="text-left">Tipo</th>
                                <th class="text-left">Tamanho Típico de Chave</th>
                                <th class="text-left">Resistência Quântica</th>
                                <th class="text-left">Uso Comum</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr
                                v-for="item in tabelaComparativa"
                                :key="item.alg">
                                <td>
                                    <strong>{{ item.alg }}</strong>
                                </td>
                                <td>{{ item.tipo }}</td>
                                <td>{{ item.chave }}</td>
                                <td>
                                    <v-chip
                                        :color="item.quantum === 'Alta' ? 'success' : 'error'"
                                        size="x-small"
                                        label>
                                        {{ item.quantum }}
                                    </v-chip>
                                </td>
                                <td class="text-caption">{{ item.uso }}</td>
                            </tr>
                        </tbody>
                    </v-table>
                </v-card>
            </v-col>
        </v-row>

        <v-navigation-drawer
            v-model="drawer"
            location="right"
            temporary
            width="450"
            elevation="10">
            <template v-if="selecionado">
                <v-toolbar
                    :color="selecionado.cor"
                    theme="dark">
                    <v-toolbar-title>Vulnerabilidades: {{ selecionado.nome }}</v-toolbar-title>
                    <v-btn
                        icon="mdi-close"
                        @click="drawer = false"></v-btn>
                </v-toolbar>

                <div class="pa-6">
                    <div
                        v-for="(ataque, i) in selecionado.detalhesAtaques"
                        :key="i"
                        class="mb-8">
                        <div class="d-flex align-center mb-2">
                            <v-icon
                                color="error"
                                class="mr-2"
                                >mdi-shield-alert-outline</v-icon
                            >
                            <h3 class="text-h6 text-error">{{ ataque.titulo }}</h3>
                        </div>
                        <p class="text-body-2 text-justify mb-3">{{ ataque.explicacao }}</p>

                        <v-alert
                            variant="tonal"
                            color="info"
                            density="compact"
                            class="text-caption">
                            <strong>Como prevenir:</strong> {{ ataque.prevencao }}
                        </v-alert>
                        <v-divider class="mt-6"></v-divider>
                    </div>
                </div>
            </template>
        </v-navigation-drawer>
    </v-container>
</template>

<script setup lang="ts">
    const drawer = ref(false);
    const selecionado = ref<any>(null);

    const analiseDados = [
        {
            nome: 'Cifra de César',
            icone: 'mdi-alphabetical',
            cor: 'brown',
            resumo: 'Algoritmo de substituição simples onde cada letra é deslocada no alfabeto.',
            vantagens: ['Extrema simplicidade', 'Não requer tecnologia', 'Ideal para fins didáticos'],
            desvantagens: ['Espaço de chaves minúsculo (25)', 'Fácil de quebrar à mão', 'Não oferece segurança real'],
            ataques: ['Força Bruta', 'Análise de Frequência'],
            detalhesAtaques: [
                {
                    titulo: 'Análise de Frequência',
                    explicacao:
                        'Em qualquer língua, certas letras aparecem mais que outras (ex: "A" e "E" em Português). Um atacante conta a frequência das letras no criptograma e mapeia as mais comuns para as letras mais frequentes da língua.',
                    prevencao: 'Não utilizar cifras de substituição monoalfabética para dados reais.',
                },
                {
                    titulo: 'Ataque de Força Bruta',
                    explicacao: 'Como só existem 25 deslocamentos possíveis, um computador (ou humano) pode testar todas as combinações em segundos até encontrar um texto legível.',
                    prevencao: 'Aumentar o espaço de chaves (usar algoritmos modernos).',
                },
            ],
        },
        {
            nome: 'AES (Symmetric)',
            icone: 'mdi-shield-lock',
            cor: 'blue-darken-2',
            resumo: 'Padrão atual de criptografia simétrica. Extremamente seguro se a chave for protegida.',
            vantagens: ['Extremamente rápido', 'Padrão governamental mundial', 'Eficiente em hardware'],
            desvantagens: ['Gestão de chaves complexa', 'Ambas as partes devem ter a chave', 'Vulnerável a Side-channel'],
            ataques: ['Canais Laterais', 'Chave Relacionada'],
            detalhesAtaques: [
                {
                    titulo: 'Ataques de Canal Lateral (Side-channel)',
                    explicacao:
                        'O atacante não quebra a matemática do AES, mas mede o consumo de energia ou o tempo de processamento do hardware enquanto ele cifra. Essas variações revelam bits da chave.',
                    prevencao: 'Implementações de tempo constante e isolamento eletromagnético.',
                },
                {
                    titulo: 'Ataques de Dicionário em Chaves Fracas',
                    explicacao: 'Se o utilizador escolher uma password simples em vez de uma chave aleatória de 256 bits, o atacante testa passwords comuns.',
                    prevencao: 'Usar funções de derivação de chave (KDF) como Argon2 ou PBKDF2.',
                },
            ],
        },
        {
            nome: 'RSA (Asymmetric)',
            icone: 'mdi-math-log',
            cor: 'deep-purple',
            resumo: 'Baseado na dificuldade de fatorar grandes números primos. Essencial para a Web.',
            vantagens: ['Facilita troca de chaves', 'Suporta assinaturas digitais', 'Bem estabelecido'],
            desvantagens: ['Lento para dados grandes', 'Requer chaves longas (3072+ bits)', 'Vulnerável a computação quântica'],
            ataques: ['Algoritmo de Shor', 'Fatoração'],
            detalhesAtaques: [
                {
                    titulo: 'Algoritmo de Shor (Ameaça Quântica)',
                    explicacao: 'Um computador quântico de grande escala pode resolver o problema da fatoração em tempo polinomial, tornando o RSA obsoleto instantaneamente.',
                    prevencao: 'Migrar para algoritmos Pós-Quânticos (como o McEliece).',
                },
                {
                    titulo: 'Ataque de Wiener',
                    explicacao: 'Se o expoente de decifração (d) for muito pequeno (menos de 1/3 do módulo), ele pode ser recuperado usando frações contínuas.',
                    prevencao: 'Garantir que os parâmetros e e d sejam suficientemente grandes.',
                },
            ],
        },
        {
            nome: 'McEliece (PQ)',
            icone: 'mdi-matrix',
            cor: 'teal-darken-1',
            resumo: 'Criptossistema pós-quântico baseado em códigos corretores de erro com ruído.',
            vantagens: ['Resistente a ataques quânticos', 'Encriptação muito rápida', '45 anos sem ser quebrado'],
            desvantagens: ['Chaves públicas gigantes (MB)', 'Aumento no tamanho do ficheiro', 'Uso elevado de memória'],
            ataques: ['ISD', 'Ataques Estruturais'],
            detalhesAtaques: [
                {
                    titulo: 'Information Set Decoding (ISD)',
                    explicacao: 'Tenta encontrar o vetor de erro tentando adivinhar um conjunto de colunas da matriz pública que não contenha erros e resolver o sistema linear.',
                    prevencao: 'Utilizar matrizes de grandes dimensões (ex: n=2048, k=1024).',
                },
                {
                    titulo: 'Ataques Estruturais',
                    explicacao: 'Tentam distinguir a matriz pública de uma matriz puramente aleatória para encontrar a estrutura oculta do Código de Goppa.',
                    prevencao: 'Utilizar Códigos de Goppa binários, que têm provado ser resistentes a este tipo de distinção há décadas.',
                },
            ],
        },
    ];

    const tabelaComparativa = [
        { alg: 'César', tipo: 'Substituição', chave: '5 bits', quantum: 'Nula', uso: 'Educação / Jogos' },
        { alg: 'AES-256', tipo: 'Simétrico', chave: '256 bits', quantum: 'Média (Grover)', uso: 'Disco, Wi-Fi, VPN' },
        { alg: 'RSA-4096', tipo: 'Assimétrico', chave: '4096 bits', quantum: 'Nula (Shor)', uso: 'Certificados Web (SSL)' },
        { alg: 'McEliece', tipo: 'Baseado em Códigos', chave: '1+ Megabits', quantum: 'Alta', uso: 'Criptografia Pós-Quântica' },
    ];
</script>

<style scoped>
    .v-card {
        transition: transform 0.2s ease-in-out;
    }
    .v-card:hover {
        transform: translateY(-5px);
    }
    .uppercase {
        letter-spacing: 1px;
        font-size: 0.65rem !important;
    }
</style>
