<template>
    <v-banner
        v-if="show"
        color="primary"
        density="compact"
        position="fixed"
        location="top"
        class="blurred-banner tw-z-[100]">
        <template #text> Já tem a nossa aplicação? Instale aqui e descubra as nossas funcionalidades! </template>
        <template #actions>
            <v-btn
                class="close-btn text-white font-weight-semibold tw-py-1.5"
                variant="text"
                height="auto"
                elevation="0"
                @click="close"
                >Fechar</v-btn
            >
            <v-btn
                class="bg-primary text-white font-weight-semibold tw-ml-2 tw-py-1.5"
                variant="flat"
                height="auto"
                elevation="0"
                @click="install"
                >Instalar</v-btn
            >
        </template>
    </v-banner>
</template>

<script setup lang="ts">
    import { ref } from 'vue';
    import { useBannerStore } from '@/store/banner';

    const bannerStore = useBannerStore();

    // Add Event Listener To Show 'Install PWA' Banner
    const show = ref(false);

    let installPrompt: any = null;

    window.addEventListener('beforeinstallprompt', (event) => {
        // check if the app is already installed
        event.preventDefault();
        if (window.matchMedia('(display-mode: standalone)').matches) {
            return;
        }

        // isPwaBannerVisible is true by deafult
        // if the user already accepted or dismissed the banner, we don't show it again
        if (bannerStore.isPwaBannerVisible) {
            installPrompt = event;
            show.value = true;
        }
    });

    async function close() {
        show.value = false;
        bannerStore.setIsPwaBannerVisible(false);
    }

    async function install() {
        if (!installPrompt) {
            return;
        }
        const result = await installPrompt.prompt();

        const userChoice = result.outcome;

        if (userChoice === 'accepted' || userChoice === 'dismissed') {
            show.value = false;
            bannerStore.setIsPwaBannerVisible(false);
        }
    }
</script>

<style scoped>
    .blurred-banner {
        background-color: rgba(0, 0, 0, 0.4);
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        color: white;
    }
    .blurred-banner .close-btn {
        background-color: #f9f9f921 !important;
    }
</style>