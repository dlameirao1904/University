<template>
    <v-app-bar
        v-if="mobile"
        flat
        elevation="1">
        <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
        <v-app-bar-title>Teoria de Códigos</v-app-bar-title>
    </v-app-bar>

    <v-navigation-drawer
        v-model="drawer"
        :rail="!mobile && rail"
        :permanent="!mobile"
        :temporary="mobile"
        width="350"
        elevation="2"
        @click="!mobile ? (rail = false) : null">
        <v-list-item
            prepend-icon="mdi-shield-lock"
            title="Teoria de Códigos"
            subtitle="Exemplos de Criptografia"
            class="pa-4"
            nav
            :style="!mobile ? 'cursor: pointer' : ''"
            @click.stop="!mobile ? (rail = !rail) : null">
            <template
                v-slot:append
                v-if="!mobile">
                <v-btn
                    variant="text"
                    icon="mdi-chevron-left"
                    @click.stop="rail = !rail"></v-btn>
            </template>
        </v-list-item>

        <v-divider></v-divider>

        <v-list nav>
            <v-list-item
                prepend-icon="mdi-home"
                title="Homepage"
                value="homepage"
                to="/"></v-list-item>

            <v-list-group value="Privada">
                <template v-slot:activator="{ props }">
                    <v-list-item
                        v-bind="props"
                        prepend-icon="mdi-key"
                        title="Criptografia Chave Privada"></v-list-item>
                </template>

                <v-list-item
                    prepend-icon="mdi-key"
                    value="simetric"
                    title="Criptografia Simétrica"
                    to="/simetric-criptography"></v-list-item>

                <v-list-item
                    title="Cifra de César"
                    value="cesar"
                    prepend-icon="mdi-format-letter-case"
                    to="/cifra-cesar"></v-list-item>

                <v-list-item
                    title="AES (EAS)"
                    value="aes"
                    prepend-icon="mdi-matrix"
                    to="/aes"></v-list-item>
            </v-list-group>

            <v-list-group value="Publica">
                <template v-slot:activator="{ props }">
                    <v-list-item
                        v-bind="props"
                        prepend-icon="mdi-key-chain"
                        title="Criptografia Chave Pública"></v-list-item>
                </template>

                <v-list-item
                    prepend-icon="mdi-key"
                    value="assimetric"
                    title="Criptografia Assimétrica"
                    to="/assimetric-criptography"></v-list-item>

                <v-list-item
                    title="RSA"
                    value="rsa"
                    prepend-icon="mdi-math-log"
                    to="/rsa"></v-list-item>

                <v-list-item
                    title="McEliece"
                    value="mceliece"
                    prepend-icon="mdi-code-array"
                    to="/mceliece"></v-list-item>
            </v-list-group>

            <v-list-item
                prepend-icon="mdi-eye"
                title="Conclusões e Perspetivas"
                value="point-of-view"
                to="/point-of-view"
            ></v-list-item>
        </v-list>
    </v-navigation-drawer>
</template>

<script setup lang="ts">
    import { ref, watch, onMounted } from 'vue';
    import { useDisplay } from 'vuetify';

    // Hook do Vuetify para detectar tamanho de tela
    const { mobile } = useDisplay();

    // No Mobile, começa fechado (drawer = false)
    // No Desktop, começa aberto (drawer = true)
    const drawer = ref(true);
    const rail = ref(false);

    // Ajusta o estado inicial ao carregar o componente
    onMounted(() => {
        if (mobile.value) {
            drawer.value = false;
        }
    });

    // Fecha o drawer automaticamente se mudar de Desktop para Mobile
    watch(mobile, (isMobile) => {
        if (isMobile) {
            drawer.value = false;
        } else {
            drawer.value = true;
            rail.value = false;
        }
    });
</script>

<style scoped>
    /* Adicione estilos customizados aqui se necessário */
</style>
