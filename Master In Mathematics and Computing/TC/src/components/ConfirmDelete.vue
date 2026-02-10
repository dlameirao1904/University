<template>
    <v-dialog
        v-model="isOpen"
        max-width="360">
        <v-card
            variant="flat"
            class="tw-py-1">
            <template v-slot:title>
                <div class="tw-flex tw-flex-col tw-items-center tw-gap-y-2 tw-text-center">
                    <v-icon class="tw-rounded-lg tw-bg-red tw-bg-opacity-15 tw-p-5 tw-text-center tw-text-2xl tw-text-red">mdi-alert</v-icon>
                    <span class="tw-text-lg tw-text-dark tw-font-bold">{{ title }}</span>
                </div>
            </template>
            <v-card-text class="tw-text-center tw-text-dark" v-html="text"></v-card-text>
            <template v-slot:actions>
                <div class="tw-flex tw-w-full tw-justify-between tw-px-3.5">
                    <v-btn
                        class="tw-w-5/12 tw-bg-gray tw-bg-opacity-15"
                        @click="onAction('no')"
                        >{{ $t('shared.no') }}</v-btn
                    >
                    <v-btn
                        class="tw-w-5/12 tw-bg-red tw-text-white"
                        @click="onAction('yes')"
                        >{{ $t('shared.yes') }}</v-btn
                    >
                </div>
            </template>
        </v-card>
    </v-dialog>
</template>

<script setup lang="ts">
    import { watch, computed } from 'vue';
    import { ref } from 'vue';
    import { useI18n } from 'vue-i18n';

    const { t: $t } = useI18n();

    const props = defineProps<{
        modelValue: boolean;
        title?: string;
        text?: string;
    }>();

    const emit = defineEmits<{
        (e: 'update:modelValue', value: boolean): void;
        (e: 'action', value: string): void;
    }>();

    const title = computed(() => props.title || $t('components.confirmDelete.title'));
    const text = computed(() => props.text || $t('components.confirmDelete.text'));

    const isOpen = ref(false);

    function onAction(value: string) {
        emit('action', value);
        isOpen.value = false;
    }

    watch(
        () => props.modelValue,
        (value) => {
            isOpen.value = value;
        },
        {
            immediate: true,
        },
    );

    watch(
        () => isOpen.value,
        (value) => {
            emit('update:modelValue', value);
        },
    );
</script>

<style scoped></style>
