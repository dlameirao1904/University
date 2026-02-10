import { defineStore } from 'pinia';
import _ from 'lodash';
import { ioAlert } from "../components/components";

const defaultAlert: ioAlert = {
    show: false,
    timeout: 3000,
    closable: true,
};

export const useAlert = defineStore({
    id: 'alertStore',
    state: () => ({
        alert: {
            show: false,
            text: '',
            variant: 'outlined',
            color: 'success',
            timeout: 3000,
        } as ioAlert,
    }),
    getters: {
        getAlert: (state) => {
            return state.alert;
        },
    },
    actions: {
        setAlert(data: ioAlert) {
            // @ts-ignore
            this.alert = data;
        },
        showAlert(data: ioAlert) {
            data.show = true;
            this.alert = _.assign(_.clone(defaultAlert), data);
        },
        hideAlert() {
            this.alert = defaultAlert;
        },
    },
});
