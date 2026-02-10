<template>
    <v-alert
        variant="tonal"
        v-bind="vAlertProps"
        position="fixed"
        location="top right"
        class="global-alert tw-ml-3 tw-mr-3 tw-mt-3 lg:tw-mt-32"
        max-width="75%"
        :model-value="showAlert"
        @update:model-value="alertStore.hideAlert">
    </v-alert>
</template>

<script setup lang="ts">
    import { useAlert } from '@/composables/useAlert';
    import { computed } from 'vue';
    import { omit } from 'lodash';
    import { watch } from 'vue';

    const alertStore = useAlert();

    // @ts-expect-error
    const vAlertProps = computed(() => omit(alertStore.getAlert, ['show', 'timeout']));

    const showAlert = computed(() => alertStore.getAlert.show);

    watch(
        () => alertStore.getAlert.show,
        (value) => {
            if (value && alertStore.getAlert.timeout && alertStore.getAlert.timeout > 0) {
                setTimeout(() => {
                    alertStore.hideAlert();
                }, alertStore.getAlert.timeout);
            }
        },
    );
</script>

<style>
    .global-alert {
        /* top: calc(var(--v-layout-top) + 1rem);
        right: calc(var(--v-layout-right) + 1rem); */
        @apply tw-z-50;
        background-color: rgba(255, 255, 255, 0.9) !important;
    }
    .global-alert .v-alert__close button {
        box-shadow: none !important;
    }
</style>
