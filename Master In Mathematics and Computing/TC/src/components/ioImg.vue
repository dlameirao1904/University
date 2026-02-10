<template>
    <v-img
        class="io-img"
        :class="{ 'io-img-error': isError }"
        :src="src"
        @error="onError"
        v-bind="vImgProps">
        <template #default>
            <slot></slot>
        </template>
        <template #placeholder>
            <slot name="placeholder"></slot>
        </template>
        <template #error>
            <slot name="error"></slot>
        </template>
        <template #sources>
            <slot name="sources"></slot>
        </template>
    </v-img>
</template>

<script setup lang="ts">
    import { getPlaceholderImage, useMedia } from '@/composables/useMedia';
    import { ioImg, ioImgSlots } from './components';
    import { computed, ref } from 'vue';
    import { omit } from 'lodash';
    import { watchEffect } from 'vue';

    const props = defineProps<ioImg>();
    const $slots = defineSlots<ioImgSlots>();

    const vImgProps = computed(() => omit(props, ['media', 'contentType', 'format', 'src']));

    const format = computed(() => {
        if (props.format) {
            return props.format;
        }

        return 'original';
    });

    const contentType = computed(() => {
        if (props.contentType) {
            return props.contentType;
        }

        return 'default';
    });

    const src = ref(useMedia(props.media, contentType.value)[format.value]);
    const isError = ref(false);

    function onError() {
        isError.value = true;
        src.value = getPlaceholderImage(contentType.value);
    }

    watchEffect(() => {
        src.value = useMedia(props.media, contentType.value)[format.value];
    });
</script>

<style>
    .io-img-error {
        .v-img__img {
            @apply tw-p-3;
        }
    }
</style>
