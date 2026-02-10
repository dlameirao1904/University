<template>
    <v-autocomplete :disabled="isDisabled" v-bind="VAutocompleteProps" v-model="modelValue" clearable
        :item-title="itemTitle" :item-value="itemValue" :items="items" :loading="isLoading" :multiple="isMultiple"
        no-filter @click:clear="onClear" @update:search="onSearch">
        <template #append-item>
            <div v-intersect.quiet="onScrollEnd" />
        </template>
    </v-autocomplete>
</template>

<script setup lang="ts">
import { computed, nextTick, ref, watch, watchEffect } from 'vue';
import _, { has, isArray, isEqual, omit } from 'lodash';
import { ioAutocomplete } from './components';

const props = defineProps<ioAutocomplete>();

const isMultiple = computed(() => isArray(modelValue.value));

const modelValue = defineModel<any>();

const $emit = defineEmits<{
    (e: 'change', value: number | number[] | null): void;
    (e: 'resetFunction', value: () => void): void;
}>();

const VAutocompleteProps = computed(() => omit(props, ['modelValue', 'fetchItems', 'query', 'extraData', 'selectFirst']));

const itemTitle = computed(() => (props.itemTitle as string) || 'name');
const itemValue = computed(() => (props.itemValue as string) || 'id');

const isDisabled = computed(() => !items.value.length);

const items = ref<any[]>([]);
const isLoading = ref(false);
const pageCount = ref(0);
const page = ref(1);
const pageSize = ref(100);
const search = ref('');
const timerId = ref<NodeJS.Timeout>();
const hasData = ref(false);

async function _fetchItems() {
    isLoading.value = true;
    try {
        const { data } = await props.fetchItems({ page: page.value, pageSize: pageSize.value, search: search.value, ids: isMultiple.value ? modelValue.value : [modelValue.value] });
        if (page.value == 1) {
            items.value = [];
            if (props.extraData) {
                items.value.push(...props.extraData);
            }
        }
        if (has(data, 'data')) {
            items.value.push(...data.data);
            if (data.data.length > 0) {
                hasData.value = true;
            } else {
                hasData.value = false;
            }
        }
    } catch (error: any) {
        console.error(error);
    } finally {
        isLoading.value = false;
    }
}

function onScrollEnd(isIntersecting: boolean) {
    if (isIntersecting) {
        if (page.value >= pageCount.value) return;
        page.value++;
        _fetchItems();
    }
}

function onClear() {
    page.value = 1;
    modelValue.value = isMultiple.value ? [] : undefined;
    items.value = [];
}

async function onSearch(_search: string) {
    await nextTick();
    if ((isMultiple.value && modelValue.value.length > 0) || (!isMultiple.value && modelValue.value)) {
        const a = isMultiple.value ? modelValue.value : [modelValue.value];
        if ((!isMultiple.value && !_search) || items.value.some((item) => a.includes(item[itemValue.value]) && item[itemTitle.value] == _search)) return;
    }

    if (timerId.value) clearTimeout(timerId.value);
    timerId.value = setTimeout(() => {
        page.value = 1;
        search.value = _search;
        _fetchItems();
    }, 500);
}

async function init() {
    if ((!isMultiple.value && modelValue.value) || (isMultiple.value && modelValue.value.length > 0)) {
        const { data } = await props.fetchItems({ ids: isMultiple.value ? modelValue.value : [modelValue.value] });
        items.value = data.data;
    } else await _fetchItems();

    if (props.selectFirst && props.extraData.length > 0 && !hasData.value) {
        modelValue.value = isMultiple.value ? [items.value[0][itemValue.value]] : items.value[0][itemValue.value];
    }
}

function changeItems(_items: any, action: 'create' | 'update' | 'delete') {
    if (!Array.isArray(_items)) _items = [_items];

    if (action == 'create') {
        items.value.unshift(..._items);
    } else if (action == 'update') {
        items.value = items.value.map((item) => {
            const index = _items.findIndex((i: any) => i[itemValue.value] == item[itemValue.value]);
            if (index > -1) return _.cloneDeep(_items[index]);
            return item;
        });
    } else if (action == 'delete') {
        items.value = items.value.filter((item) => !_items.some((i: any) => i[itemValue.value] == item[itemValue.value]));
        _fetchItems();
    }
}

function reset() {
    page.value = 1;
    items.value = [];
    search.value = '';
    hasData.value = false;
    _fetchItems();
}

const computedQuery = computed(() => _.cloneDeep(props.query));
const computedChangedItems = computed(() => _.cloneDeep(props.changedItems));

watch(
    computedChangedItems,
    (value) => {
        if (value) {
            changeItems(value.items, value.action);
        }
    },
    {
        deep: true,
    },
);

watch(
    computedQuery,
    async (a, b) => {
        if (isEqual(a, b)) return;
        onClear();
        await nextTick();
        _fetchItems();
    },
    {
        deep: true,
    },
);

watch(
    () => modelValue.value,
    (value) => {
        $emit('change', value);
    },
);

$emit('resetFunction', reset);

init();
</script>

<style scoped></style>
