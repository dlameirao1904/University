<template>
    <v-banner v-if="needRefresh" color="primary" density="compact" position="fixed" location="bottom left" elevation="12" class="tw-z-[100]">
        <template #text> Nova versão disponível! Atualize a página para obter a versão mais recente. </template>
        <template #actions>
            <v-btn height="2rem" @click="close">Mais tarde</v-btn>
            <v-btn class="tw-ml-2" variant="flat" height="2rem" color="primary" @click="updateServiceWorker">Atualizar</v-btn>
        </template>
    </v-banner>
</template>

<script setup lang="ts">
    import { useRegisterSW } from 'virtual:pwa-register/vue';

    const reloadSW: any = true;

    const { offlineReady, needRefresh, updateServiceWorker } = useRegisterSW({
        immediate: true,
        async onRegisteredSW(r: any) {
            if (reloadSW && r) {
                await r?.update();
            }
        },
    });

    async function close() {
        offlineReady.value = false;
        needRefresh.value = false;
    }
</script>

<style scoped></style>