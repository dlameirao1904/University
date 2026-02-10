import { defineStore } from 'pinia';
import { computed } from 'vue';
import _ from 'lodash';

// export interface ILoader {
//     show?: boolean;
// }

// const defaultLoader: ILoader = {
//     show: false,
// };

export const loaderStore = defineStore({
    id: 'loadingStore',
    state: () => ({
        loader: false,
    }),
    getters: {
        getLoader: (state) => {
            return state.loader;
        },
    },
    actions: {
        setLoader(data: boolean) {
            this.loader = data;
        },
    },
});

export const useLoader = () => {
    const store = loaderStore();

    function showLoader() {
        store.setLoader(true);
    }

    function hideLoader() {
        store.setLoader(false);
    }

    const getLoader = computed(() => {
        return store.getLoader;
    });

    return {
        showLoader,
        getLoader,
        hideLoader,
    };
};
