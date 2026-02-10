<template>
    <v-container
        class="py-10 px-6"
        fluid>
        <v-row justify="center">
            <v-col
                cols="12"
                md="10"
                lg="8">
                <v-card
                    variant="flat"
                    color="transparent"
                    class="text-center mb-10">
                    <v-chip
                        color="primary"
                        variant="outlined"
                        class="mb-4">
                        Mestrado em Matemática e Computação | Teoria de Códigos
                    </v-chip>
                    <h1 class="text-h2 font-weight-bold mb-4">Criptografia: A Ciência da Escrita Oculta</h1>
                    <p class="text-body-1 text-medium-emphasis">
                        Do grego <em>kryptós</em> e <em>gráphein</em>. Uma jornada desde a substituição de letras até à resistência contra a computação quântica.
                    </p>
                </v-card>
            </v-col>
        </v-row>

        <v-row>
            <v-col
                cols="12"
                md="4">
                <v-card
                    hover
                    class="pa-4 h-100"
                    border>
                    <v-icon
                        color="primary"
                        size="40"
                        class="mb-4"
                        >mdi-shield-check</v-icon
                    >
                    <h3 class="text-h6 mb-2">Confidencialidade</h3>
                    <p class="text-body-2">O objetivo primário: garantir que a mensagem permaneça ilegível para terceiros não autorizados.</p>
                </v-card>
            </v-col>
            <v-col
                cols="12"
                md="4">
                <v-card
                    hover
                    class="pa-4 h-100"
                    border>
                    <v-icon
                        color="primary"
                        size="40"
                        class="mb-4"
                        >mdi-lock-open-variant</v-icon
                    >
                    <h3 class="text-h6 mb-2">Cifração e Decifração</h3>
                    <p class="text-body-2">A transformação de texto limpo em criptograma e o seu retorno ao estado original via chaves matemáticas.</p>
                </v-card>
            </v-col>
            <v-col
                cols="12"
                md="4">
                <v-card
                    hover
                    class="pa-4 h-100"
                    border>
                    <v-icon
                        color="error"
                        size="40"
                        class="mb-4"
                        >mdi-atom</v-icon
                    >
                    <h3 class="text-h6 mb-2">Ameaça Quântica</h3>
                    <p class="text-body-2">O Algoritmo de Shor coloca em risco os sistemas RSA e ECC, exigindo a transição para a era Pós-Quântica.</p>
                </v-card>
            </v-col>
        </v-row>

        <v-row class="mt-12">
            <v-col cols="12">
                <v-card
                    class="pa-8"
                    color="grey-lighten-4"
                    flat>
                    <v-row align="center">
                        <v-col
                            cols="12"
                            md="7">
                            <h2 class="text-h4 mb-4 font-weight-bold">A Transição para o Pós-Quântico</h2>
                            <p class="mb-4">
                                Atualmente, a confiança nas comunicações digitais depende da complexidade de problemas como a
                                <strong>fatorização de números inteiros</strong>. Contudo, a computação quântica de grande escala torna estes métodos tradicionais obsoletos.
                            </p>
                            <div class="d-flex gap-4">
                                <v-btn
                                color="primary"
                                variant="elevated"
                                prepend-icon="mdi-book-open-page-variant"
                                to="/simetric-criptography">
                                Criptografia Simétrica
                            </v-btn>
                            <v-btn
                                color="primary"
                                variant="elevated"
                                class="ml-2"
                                prepend-icon="mdi-book-open-page-variant-outline"
                                to="/assimetric-criptography">
                                Criptografia Assimétrica
                            </v-btn>
                            </div>
                        </v-col>
                        <v-col
                            cols="12"
                            md="5">
                            <v-icon
                                size="200"
                                color="primary"
                                class="d-flex mx-auto"
                                >mdi-shield-key-outline</v-icon
                            >
                        </v-col>
                    </v-row>
                </v-card>
            </v-col>
        </v-row>

        <v-divider class="mt-16"></v-divider>
        <v-footer class="bg-transparent mt-4">
            <v-row
                justify="center"
                no-gutters>
                <v-col
                    class="text-center text-caption text-medium-emphasis"
                    cols="12">
                    Universidade do Minho — {{ new Date().getFullYear() }}
                </v-col>
            </v-row>
        </v-footer>
    </v-container>
</template>

<script setup lang="ts">
    console.log('Homepage');
</script>

<style scoped>
.text-justify {
  text-align: justify;
}
</style>
