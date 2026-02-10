<template>
    <v-dialog :model-value="modelValue" @update:model-value="$emit('update:modelValue', $event)" persistent :max-width="isMobile ? '95%' : '900'">
        <v-card class="tw-rounded-xl tw-flex tw-flex-col tw-max-h-[90vh]">
            <!-- Header -->
            <div class="tw-bg-primary tw-px-6 tw-py-8 tw-text-white tw-flex-shrink-0">
                <div class="tw-flex tw-items-center tw-gap-3 tw-mb-2">
                    <v-icon size="32" class="tw-text-white">mdi-hand-back-right</v-icon>
                    <h2 class="tw-text-2xl tw-font-bold">Bem-vindo à Plataforma AGROvila!</h2>
                </div>
                <p class="tw-text-green-50 tw-text-sm tw-ml-11">
                    Promovendo agricultura familiar e circuitos curtos
                </p>
            </div>

            <v-card-text class="tw-px-6 tw-py-6 tw-overflow-y-auto tw-flex-1 tw-min-h-0">
                <!-- Main description -->
                <div class="tw-mb-6">
                    <p class="tw-text-gray-700 tw-leading-relaxed">
                        Esta é uma plataforma que promove a agricultura familiar e os circuitos curtos de comercialização,
                        aproximando quem produz de quem consome de forma simples, local e colaborativa.
                        Aqui, os produtos são vendidos diretamente por pequenos agricultores e produtores familiares, e as
                        compras são organizadas em vilas – comunidades locais compostas por produtores, consumidores e
                        pontos de recolha.
                    </p>
                </div>

                <!-- Important notice -->
                <div class="tw-bg-yellow tw-bg-opacity-10 tw-border-l-4 tw-border-yellow-700 tw-rounded-r-lg tw-p-4 tw-mb-6">
                    <div class="tw-flex tw-gap-3">
                        <v-icon class="tw-text-yellow-700" size="24">mdi-bell-ring</v-icon>
                        <div>
                            <p class="tw-font-semibold tw-text-yellow-700 tw-mb-1">Importante</p>
                            <p class="tw-text-yellow-700 tw-text-sm tw-leading-relaxed">
                                Para comprar ou vender na plataforma, é necessário estar associado a uma vila.
                                Cada vila funciona com base na proximidade geográfica, o que facilita a logística e fortalece a produção local.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Steps section -->
                <div class="tw-mb-4">
                    <h3 class="tw-text-lg tw-font-semibold tw-text-gray-800 tw-mb-4">Como começar:</h3>

                    <div class="tw-space-y-3">
                        <template v-for="(step, index) in steps" :key="index">
                            <div class="tw-flex tw-gap-3 tw-items-start">
                                <div class="tw-flex-shrink-0 tw-w-8 tw-h-8 tw-bg-primary tw-rounded-full tw-flex tw-items-center tw-justify-center">
                                    <span class="tw-text-white tw-font-bold tw-text-sm">{{ index + 1 }}</span>
                                </div>
                                <p class="tw-text-gray-700 tw-pt-1">{{ step }}</p>
                            </div>
                        </template>
                    </div>
                </div>

                <!-- Call to action -->
                <div class="tw-mt-6 tw-pt-4 tw-border-t tw-border-gray-200">
                    <p class="tw-text-center tw-text-primary-900 tw-font-medium">
                        🌱 Participe no Agrovila e apoie diretamente a agricultura local!
                    </p>
                </div>
            </v-card-text>

            <v-card-actions class="tw-px-6 tw-pb-6 tw-pt-4 tw-flex-shrink-0">
                <v-spacer />
                <v-btn
                    variant="outlined"
                    color="dark"
                    class="tw-px-4 tw-py-2"
                    @click="handleFirstStepClick">
                    <v-icon start>{{ firstStepIcon }}</v-icon>
                    {{ firstStepButtonText }}
                </v-btn>
                <v-btn
                    class="tw-text-white tw-bg-primary tw-px-4 tw-py-2"
                    @click="handleVillagesClick">
                    <v-icon start>mdi-home-group</v-icon>
                    Ir para Vilas
                </v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { useRouter } from 'vue-router';
import { useDisplay } from 'vuetify';
import { useAuthStore } from '@/store/auth';

defineProps<{
    modelValue: boolean;
}>();

const emit = defineEmits<{
    'update:modelValue': [value: boolean];
}>();

const authStore = useAuthStore();
const user = computed(() => authStore.getUser);
const $router = useRouter();
const { lgAndUp } = useDisplay();

const isMobile = computed(() => !lgAndUp.value);

// Steps based on user role
const steps = computed(() => {
    const roleName = user.value?.role?.name;

    if (roleName === 'Supplier') {
        // For producers: first step is to create farms
        return [
            'Crie as suas explorações no perfil.',
            'Explore as vilas disponíveis na plataforma.',
            'Escolha e associe-se à vila mais próxima ou mais conveniente.',
            'Após a associação, terá acesso aos produtos disponíveis, podendo fazer compras ou anunciar os seus produtos.'
        ];
    } else if (roleName === 'Client' || roleName === 'PickupPoint') {
        // For consumers and collection points: first step is to define location
        return [
            'Defina a sua localização no perfil.',
            'Explore as vilas disponíveis na plataforma.',
            'Escolha e associe-se à vila mais próxima ou mais conveniente.',
            'Após a associação, terá acesso aos produtos disponíveis, podendo fazer compras ou, se for produtor, anunciar os seus produtos.'
        ];
    } else {
        // Default steps
        return [
            'Explore as vilas disponíveis na plataforma.',
            'Escolha e associe-se à vila mais próxima ou mais conveniente.',
            'Após a associação, terá acesso aos produtos disponíveis, podendo fazer compras ou, se for produtor, anunciar os seus produtos.'
        ];
    }
});

// First step button based on user role
const firstStepRoute = computed(() => {
    const roleName = user.value?.role?.name;
    if (roleName === 'Supplier') {
        return 'MyExplorations';
    }
    return 'ProfileInfo';
});

const firstStepIcon = computed(() => {
    const roleName = user.value?.role?.name;
    if (roleName === 'Supplier') {
        return 'mdi-land-plots';
    }
    return 'mdi-account';
});

const firstStepButtonText = computed(() => {
    const roleName = user.value?.role?.name;
    if (roleName === 'Supplier') {
        return 'Ir para Explorações';
    }
    return 'Ir para Perfil';
});

const handleFirstStepClick = () => {
    emit('update:modelValue', false);
    $router.push({ name: firstStepRoute.value });
};

const handleVillagesClick = () => {
    emit('update:modelValue', false);
    $router.push({ name: 'Villages' });
};
</script>

