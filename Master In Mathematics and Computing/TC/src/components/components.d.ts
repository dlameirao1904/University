import { VImg, VAutocomplete, VAlert } from 'vuetify/lib/components/index.mjs';
import { ContentTypes, Media } from '@/contentTypes';
import { AxiosResponse } from 'axios';

type GetValue<T, K extends keyof T> = T[K];

export interface ioImg extends /* @vue-ignore */ GetValue<VImg, '$props'> {
    media: Media<true> | null | undefined;
    contentType?: keyof ContentTypes;
    format?: keyof Media['formats'];
}

export interface ioImgSlots extends /* @vue-ignore */ GetValue<VImg, '$slots'> {}

export interface ioAutocomplete extends /* @vue-ignore */ GetValue<VAutocomplete, '$props'> {
    query?: any;
    fetchItems: ({ page, search, ids }: { page?: number; search?: string; ids?: [number] }) => Promise<AxiosResponse>;
}

export interface ioAlert extends /* @vue-ignore */ GetValue<VAlert, '$props'> {
    show?: boolean;
    timeout?: number;
}
