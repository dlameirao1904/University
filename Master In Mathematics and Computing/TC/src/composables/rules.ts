import { useI18n } from 'vue-i18n';

export default function useRules() {
    const i18n = useI18n();
    return {
        required(value: string | number | boolean) {
            return !!value || i18n.t('rules.required');
        },
        email(value: string) {
            // eslint-disable-next-line
            const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@(([^<>()\[\]\\.,;:\s@"]+\.)+[^<>()\[\]\\.,;:\s@"]{2,})$/i;
            return re.test(value) || i18n.t('rules.email');
        },
        min(value: any, min: number) {
            if (value == null || typeof value.length !== 'number') {
                return i18n.t('rules.min', [min]);
            }
            return value?.length >= min || i18n.t('rules.min', [min]);
        },
        max(value: any, max: number) {
            if (value == null || typeof value.length !== 'number') {
                return i18n.t('rules.max', [max]);
            }
            return value.length <= max || i18n.t('rules.max', [max]);
        },
        between(value: any, min: number, max: number) {
            return (value.length >= min && value.length <= max) || i18n.t('rules.between', [min, max]);
        },
        comparePassword(value: string, other: string) {
            return value === other || i18n.t('rules.comparePassword');
        },
    };
}