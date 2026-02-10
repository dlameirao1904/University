<template>
    <v-main class="tw-bg-white">
        <Sidebar />
        <Suspense>
            <router-view />
        </Suspense>
    </v-main>
</template>

<script setup lang="ts">
import Sidebar from './Layout/Sidebar.vue';

</script>