import { ContentTypes, Media } from '@/contentTypes';
import _ from 'lodash';
import _axios from 'axios';

type imageContentType = keyof ContentTypes | 'default';

function createFormats(url: string) {
    return {
        thumbnail: url,
        small: url,
        medium: url,
        large: url,
        original: url,
    };
}

export function useMedia(media: Media | null | undefined, contentType: imageContentType) {
    if (!media) {
        return createFormats(getPlaceholderImage(contentType));
    }

    function joinUrl(url: string) {
        if (url.startsWith('http')) {
            return url;
        }
        return import.meta.env.VITE_API_URL + url;
    }

    const defaultUrl = _.get(media, 'url', '');
    return {
        thumbnail: joinUrl(_.get(media, 'formats.thumbnail.url', defaultUrl)),
        small: joinUrl(_.get(media, 'formats.small.url', defaultUrl)),
        medium: joinUrl(_.get(media, 'formats.medium.url', defaultUrl)),
        large: joinUrl(_.get(media, 'formats.large.url', defaultUrl)),
        original: joinUrl(defaultUrl),
    };
}

export function getPlaceholderImage(contentType: imageContentType) {
    let placeholder = new URL(`../assets/images/placeholder/${contentType.toLowerCase()}.svg`, import.meta.url).href;

    if (placeholder.includes('undefined')) {
        placeholder = new URL(`../assets/images/placeholder/default.svg`, import.meta.url).href;
    }
    return placeholder;
}

export async function parseMediaToFile(media: Media): Promise<File> {
    const url = media.url.startsWith('http') ? media.url : import.meta.env.VITE_API_URL + media.url;
    const response = await _axios.get(url, { responseType: 'blob' });
    const blob = new Blob([response.data], { type: response.headers['content-type'] });
    const lastModified = media.updatedAt ? new Date(media.updatedAt).getTime() : Date.now();
    return new File([blob], media.name, { type: media.mime, lastModified });
}
