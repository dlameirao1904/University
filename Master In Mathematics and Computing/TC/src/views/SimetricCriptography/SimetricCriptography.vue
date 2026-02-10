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
                        >mdi-key-variant</v-icon
                    >
                    <h1 class="text-h3 font-weight-bold text-grey-darken-4">Criptografia de Chave Privada</h1>
                </div>
                <v-chip
                    color="primary"
                    variant="tonal"
                    size="small"
                    class="font-weight-bold">
                    CRIPTOGRAFIA SIMÉTRICA
                </v-chip>
                <v-divider
                    class="mt-4 mb-8"
                    thickness="2"
                    color="primary"></v-divider>
            </v-col>
        </v-row>

        <v-row justify="space-between">
            <v-col
                cols="12"
                md="7">
                <p class="text-body-1 text-justify mb-6">
                    A criptografia de chave privada, também designada por <strong>criptografia simétrica</strong>, é um dos modelos mais antigos de proteção da informação. Neste tipo de criptografia,
                    o emissor e o receptor partilham uma <strong>chave secreta comum</strong>, que é utilizada tanto no processo de encriptação como no de desencriptação da mensagem.
                </p>

                <v-card
                    variant="flat"
                    color="grey-lighten-4"
                    class="pa-6 border-s-lg border-primary">
                    <p class="text-body-1 italic">"A segurança do sistema depende inteiramente do facto de esta chave permanecer desconhecida para terceiros."</p>
                </v-card>
            </v-col>

            <v-col
                cols="12"
                md="4">
                <v-img
                    src="https://cdn-icons-png.flaticon.com/512/2502/2502573.png"
                    height="200"
                    class="opacity-80"></v-img>
            </v-col>
        </v-row>

        <v-row class="mt-10">
            <v-col cols="12">
                <h2 class="text-h4 font-weight-bold text-grey-darken-3 mb-6">O Cenário de Segurança</h2>
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
                        >mdi-incognito</v-icon
                    >
                    <h3 class="text-h6 mb-3">Resistência a Interceptação</h3>
                    <p class="text-body-2 text-grey-darken-1 text-justify">
                        Num cenário de ataque, o terceiro que intercepta a comunicação tem acesso apenas à informação cifrada. Sem o conhecimento da chave utilizada, recuperar a mensagem original
                        torna-se computacionalmente difícil, desde que a chave seja suficientemente aleatória.
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
                        >mdi-alert-decagram</v-icon
                    >
                    <h3 class="text-h6 mb-3">O Desafio da Distribuição</h3>
                    <p class="text-body-2 text-grey-darken-1 text-justify">
                        Apesar da sua eficiência, subsiste o desafio crítico da <strong>distribuição segura</strong>. Como as duas entidades devem possuir a mesma chave antes de iniciar a comunicação,
                        é necessário um canal prévio seguro para a troca deste segredo inicial.
                    </p>
                </v-card>
            </v-col>
        </v-row>

        <v-row class="mt-12">
            <v-col cols="12">
                <v-alert
                    variant="outlined"
                    color="primary"
                    prepend-icon="mdi-school"
                    title="Fundamentação Académica">
                    Este modelo serve como base para algoritmos modernos como o AES, focando-se na confidencialidade e na robustez algorítmica. No contexto de Teoria de Códigos, analisamos a
                    complexidade e a aleatoriedade destas chaves para garantir a proteção contra ataques de força bruta.
                </v-alert>
            </v-col>
        </v-row>
    </v-container>
</template>

<style scoped>
    .text-justify {
        text-align: justify;
    }
    .border-primary {
        border-color: #d32f2f !important;
    }
</style>

<script setup lang="ts">
    console.log('SimetricCriptography');
</script>
