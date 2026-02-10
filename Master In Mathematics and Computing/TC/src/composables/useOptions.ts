import { useI18n } from 'vue-i18n';

export function useOptions() {
    const { t } = useI18n();
    const _yesNoOptions = ['yes', 'no'];

    function yesNoOptions(includeAll = false) {
        const options = _yesNoOptions.map((option) => {
            return {
                value: option,
                text: t(`options.${option}`),
            };
        });

        if (includeAll) {
            options.unshift({
                value: '',
                text: t('options.all'),
            });
        }

        return options;
    }

    return {
        yesNoOptions,
    };
}
