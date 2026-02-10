import { Media } from '@/contentTypes';
import axios from '@axios';
import { AxiosPromise } from 'axios';

const API_URL = '/upload';

/**
 * Uploads files to the server.
 *
 * @param {File[] | File} files - The files to be uploaded. Can be a single file or an array of files.
 * @param {string} [path] - The path where the files should be stored on the server (only supported on strapi-provider-upload-aws-s3).
 * @param {number} [refId] - The ID of the entry to associate the files.
 * @param {string} [ref] - The uid of the content type to associate the files.
 * @param {string} [field] - The field name to associate the files.
 * @returns {Promise<any>} A Promise that resolves to the response from the server.
 *
 * @example
 * // Upload a single file
 * uploadFiles({
 *   files: file,
 *   path: '/uploads',
 *   refId: 5,
 *   ref: 'api::restaurant.restaurant',
 *   field: 'picture'
 * });
 *
 * @example
 * // Upload multiple files
 * uploadFiles({
 *   files: [file1, file2],
 *   path: '/uploads',
 *   refId: 5,
 *   ref: 'api::restaurant.restaurant',
 *   field: 'pictures'
 * });
 */
export async function uploadFiles({ files, path, refId, ref, field }: { files: File[] | File; path?: string; refId?: number; ref?: string; field?: string }): AxiosPromise<Media[]> {
    const formData = new FormData();

    if (!Array.isArray(files)) files = [files];

    files.forEach((file) => {
        formData.append('files', file);
    });

    if (path) formData.append('path', path);
    if (refId) formData.append('refId', refId.toString());
    if (ref) formData.append('ref', ref);
    if (field) formData.append('field', field);

    return axios.post(API_URL, formData, {
        headers: {
            'Content-Type': 'multipart/form-data',
        },
    });
}


