import slugify from 'slugify';
import _ from 'lodash';
import { useI18n } from 'vue-i18n';

export function useError() {
    const { t } = useI18n();
    function getErrorKey(error: unknown, localKey: string = ''): string {
        if (!localKey.endsWith('.')) localKey += '.';
        const slug = slugify(_.get(error, 'response.data.error.message', 'unknown_error'), {
            replacement: '_',
            trim: true,
            lower: true,
        });

        return slug == 'unknown_error' ? slug : `${localKey}${slug}`;
    }

    function getErrorMessage(error: unknown, localKey: string = ''): string {
        return t(getErrorKey(error, localKey), t('shared.unknown_error'));
    }

    return {
        getErrorKey,
        getErrorMessage,
    };
}
