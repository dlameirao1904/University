import { RouteRecordRaw, createRouter, createWebHistory } from 'vue-router';

import Home from "@/views/Home.vue";
import Homepage from "@/views/Homepage/Homepage.vue";
import SimetricCriptography from '@/views/SimetricCriptography/SimetricCriptography.vue';
import CesarCriptography from '@/views/SimetricCriptography/CesarCriptography.vue';
import AESCriptography from '@/views/SimetricCriptography/AESCriptography.vue';
import AssimetricCriptography from '@/views/AssimetricCriptography/AssimetricCriptography.vue';
import RSACriptography from '@/views/AssimetricCriptography/RSACriptography.vue';
import McElieceCriptossystem from '@/views/AssimetricCriptography/McElieceCriptossystem.vue';
import PointOfView from '@/views/PointOfView/PointOfView.vue';

const routes = [
    {
        path: "/",
        name: "Home",
        redirect: { name: "Homepage" },
        component: Home,
        children: [
            {
                path: "homepage",
                name: "Homepage",
                component: Homepage,
            },
            {
                path: "simetric-criptography",
                name: "SimetricCriptography",
                component: SimetricCriptography,
            },
            {
                path: "cifra-cesar",
                name: "CesarCriptography",
                component: CesarCriptography
            },
            {
                path: "aes",
                name: "AESCriptography",
                component: AESCriptography,
            },
            {
                path: "assimetric-criptography",
                name: "AssimetricCriptography",
                component: AssimetricCriptography,
            },
            {
                path: "rsa",
                name: "RSACriptography",
                component: RSACriptography,
            },
            {
                path: "mceliece",
                name: "McElieceCriptossystem",
                component: McElieceCriptossystem
            },
            {
                path: 'point-of-view',
                name: 'PointOfView',
                component: PointOfView,
            }
        ]

    }
]

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes,
    scrollBehavior(to, from, savedPosition) {
        if (savedPosition) {
            return savedPosition;
        } else {
            return { top: 0 };
        }
    },
});

export default router;