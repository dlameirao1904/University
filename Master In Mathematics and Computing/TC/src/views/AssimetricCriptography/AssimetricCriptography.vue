<template>
    <v-container
        class="py-10 px-6"
        fluid>
        <v-row>
            <v-col cols="12">
                <div class="d-flex align-center mb-2">
                    <v-icon
                        color="primary"
                        size="40"
                        class="me-4"
                        >mdi-key-chain</v-icon
                    >
                    <h1 class="text-h3 font-weight-bold text-grey-darken-4">Criptografia de Chave Pública</h1>
                </div>
                <v-chip
                    color="primary"
                    variant="tonal"
                    size="small"
                    class="font-weight-bold">
                    CRIPTOGRAFIA ASSIMÉTRICA
                </v-chip>
                <v-divider
                    class="mt-4 mb-8"
                    thickness="2"
                    color="primary"></v-divider>
            </v-col>
        </v-row>

        <v-row align="center">
            <v-col
                cols="12"
                md="7">
                <p class="text-body-1 text-justify mb-4">
                    A criptografia de chave pública, ou <strong>criptografia assimétrica</strong>, introduz uma abordagem inovadora ao utilizar duas chaves distintas para processar a informação, ao
                    contrário dos métodos tradicionais que dependem de uma única chave partilhada.
                </p>
                <p class="text-body-1 text-justify mb-6">
                    Neste sistema, cada utilizador gera um par de chaves matematicamente ligadas: uma <strong>chave pública</strong>, que pode ser distribuída livremente, e uma
                    <strong>chave privada</strong>, que deve permanecer sob controlo exclusivo do seu proprietário.
                </p>

                <v-card
                    variant="flat"
                    color="grey-lighten-4"
                    class="pa-6 border-s-lg border-primary">
                    <h3 class="text-h6 mb-2 text-primary">Princípio de Exclusividade</h3>
                    <p class="text-body-2 italic">
                        "A chave pública é utilizada para encriptar o conteúdo, mas, uma vez transformado, esse conteúdo só pode ser recuperado através da chave privada correspondente".
                    </p>
                </v-card>
            </v-col>

            <v-col
                cols="12"
                md="5"
                class="text-center">
                <v-icon
                    size="200"
                    color="grey"
                    >mdi-key</v-icon
                >
            </v-col>
        </v-row>

        <v-row class="mt-10">
            <v-col
                cols="12"
                md="6">
                <v-card
                    hover
                    class="pa-6 h-100"
                    border>
                    <v-icon
                        color="primary"
                        size="32"
                        class="mb-4"
                        >mdi-truck-delivery</v-icon
                    >
                    <h3 class="text-h6 mb-3">Distribuição de Chaves</h3>
                    <p class="text-body-2 text-grey-darken-1 text-justify">
                        Esta dinâmica elimina o problema logístico da distribuição segura de chaves, permitindo o envio de dados protegidos sem a necessidade de um canal prévio para troca de segredos.
                    </p>
                </v-card>
            </v-col>

            <v-col
                cols="12"
                md="6">
                <v-card
                    hover
                    class="pa-6 h-100"
                    border>
                    <v-icon
                        color="primary"
                        size="32"
                        class="mb-4"
                        >mdi-function-variant</v-icon
                    >
                    <h3 class="text-h6 mb-3">Complexidade Matemática</h3>
                    <p class="text-body-2 text-grey-darken-1 text-justify">
                        A segurança reside na relação entre as chaves: a derivação da chave privada a partir da pública é desenhada para ser um problema computacionalmente "difícil", exigindo recursos
                        impraticáveis para os padrões atuais.
                    </p>
                </v-card>
            </v-col>
        </v-row>

        <v-row class="mt-10">
            <v-col cols="12">
                <v-alert
                    variant="outlined"
                    color="primary"
                    prepend-icon="mdi-school"
                    title="Exemplo Prático: O Algoritmo RSA">
                    No algoritmo RSA, a chave pública é composta por um módulo <strong v-html="termN"></strong> (produto de dois grandes números primos) e um expoente público <span v-html="termE"></span>. A chave privada
                    inclui o mesmo módulo <strong v-html="termN"></strong> e um expoente privado <span v-html="termD"></span>. A cifragem de uma mensagem <strong v-html="termM"></strong> é realizada através da operação
                    <strong v-html="cModE"></strong>, enquanto a decifragem utiliza <strong v-html="mModD"></strong>. A segurança do RSA baseia-se na dificuldade de fatorizar o número <strong v-html="termN"></strong> em seus
                    fatores primos constituintes.
                </v-alert>
            </v-col>
        </v-row>
    </v-container>
</template>

<script setup lang="ts">
    import katex from 'katex';

    const termE = katex.renderToString('e', {
        throwOnError: false,
    });

    const termD = katex.renderToString('d', {
        throwOnError: false,
    });

    const termN = katex.renderToString('N', {
        throwOnError: false,
    });

    const termM = katex.renderToString('m', {
        throwOnError: false,
    });

    const cModE = katex.renderToString('c \\equiv m^{e} \\ (\\mathrm{mod} \\ N)', {
        throwOnError: false,
    });

    const mModD = katex.renderToString('m \\equiv c^{d} \\ (\\mathrm{mod} \\ N)', {
        throwOnError: false,
    });
</script>

<style scoped>
    .text-justify {
        text-align: justify;
    }
    .border-primary {
        border-color: #d32f2f !important;
    }
</style>
