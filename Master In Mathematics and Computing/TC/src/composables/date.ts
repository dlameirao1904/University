import moment from 'moment';

const STRAPI_DATE_FORMAT = 'YYYY-MM-DD';
const STRAPI_TIME_FORMAT = 'HH:mm:ss';

export function parseTime(time: string) {
    return moment(time, STRAPI_TIME_FORMAT);
}

export function parseDate(date: string) {
    return moment(date, STRAPI_DATE_FORMAT);
}
