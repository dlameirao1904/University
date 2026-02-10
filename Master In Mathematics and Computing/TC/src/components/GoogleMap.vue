<template>
    <div class="tw-w-full">
        <div class="tw-mb-3">
            <v-autocomplete
                v-if="edit"
                v-model="searchQuery"
                :items="savedAddresses"
                item-title="address"
                item-value="address"
                bg-color="white"
                class="tw-grow"
                clearable
                density="compact"
                placeholder="Procurar ou selecionar morada guardada"
                @update:search="onSearchInput"
                @update:model-value="onAddressSelected">
                <template #prepend-inner>
                    <v-icon class="tw-text-gray-900">mdi-magnify</v-icon>
                </template>
            </v-autocomplete>
        </div>
        <div
            v-if="selectedLocation"
            :class="[
                'tw-relative tw-my-3 tw-rounded-md tw-p-3 tw-text-primary',
                isAddressConfirmed ? 'tw-border tw-border-green-600 tw-border-opacity-30 tw-bg-green-600 tw-bg-opacity-5' : 'tw-bg-gray tw-bg-opacity-5',
            ]">
            <!-- Confirmation Check -->
            <v-icon
                v-if="isAddressConfirmed"
                class="tw-absolute tw-right-2 tw-top-2"
                color="green-600"
                size="20">
                mdi-check-circle-outline
            </v-icon>

            <div class="tw-text-dark_green tw-flex tw-items-start tw-gap-3">
                <v-icon
                    class="tw-mt-0.5"
                    color="primary"
                    size="20"
                    >mdi-map-marker</v-icon
                >
                <div class="tw-flex tw-flex-1 tw-flex-col">
                    <span class="tw-text-sm tw-font-medium lg:tw-text-[15px]">{{ selectedLocation?.address || 'Sem Morada' }}</span>
                    <div
                        v-if="selectedLocation?.details"
                        class="tw-mt-1 tw-text-sm">
                        <div
                            v-if="selectedLocation?.details.zipCode"
                            class="tw-flex tw-gap-4">
                            <span><span class="tw-font-medium">Codigo Postal:</span> {{ selectedLocation?.details.zipCode }}</span>
                            <span v-if="selectedLocation?.details.city"><span class="tw-font-medium">Cidade:</span> {{ selectedLocation?.details.city }}</span>
                        </div>
                        <div
                            v-if="selectedLocation?.details.state || selectedLocation?.details.country"
                            class="tw-mt-1 tw-flex tw-gap-4">
                            <span v-if="selectedLocation?.details.state"><span class="tw-font-medium">Distrito:</span> {{ selectedLocation?.details.state }}</span>
                            <span v-if="selectedLocation?.details.country"><span class="tw-font-medium">País:</span> {{ selectedLocation?.details.country }}</span>
                        </div>
                    </div>
                    <div
                        v-if="!isAddressConfirmed"
                        class="tw-mt-3">
                        <v-btn
                            color="primary"
                            size="small"
                            variant="outlined"
                            @click="confirmAddress">
                            <v-icon
                                class="tw-mr-1"
                                size="16"
                                >mdi-check</v-icon
                            >
                            Confirme a localização
                        </v-btn>
                    </div>
                </div>
            </div>
        </div>

        <!-- Map -->
        <div
            v-if="!isLoading && !error"
            id="map-container"
            class="tw-h-96 tw-w-full tw-rounded-md tw-border tw-border-gray-300"
            :class="{ 'tw-border-red-500': hasError }"></div>
        <div
            v-else-if="isLoading"
            class="tw-flex tw-h-96 tw-w-full tw-items-center tw-justify-center tw-rounded-md tw-border tw-border-gray-300">
            <v-progress-circular
                color="primary"
                indeterminate
                size="24" />
        </div>
        <div
            v-else-if="error"
            class="tw-text-red-500 tw-flex tw-h-96 tw-w-full tw-items-center tw-justify-center tw-rounded-md tw-border tw-border-gray-300">
            <v-icon
                color="primary"
                size="24"
                >mdi-alert-circle-outline</v-icon
            >
            <span class="tw-ml-2 tw-text-sm tw-text-primary lg:tw-text-[15px]">{{ error }}</span>
        </div>
    </div>
</template>

<script setup lang="ts">
    import { nextTick, onMounted, onUnmounted, ref, watch } from 'vue';
    import loader from '@/services/googleMapsLoader';

    const props = defineProps<{
        modelValue?: {
            lat: number;
            lng: number;
            address?: string;
            details?: {
                full: string;
                street: string;
                city: string;
                state: string;
                zipCode: string;
                country: string;
            };
        } | null;
        hasError?: boolean;
        edit?: boolean;
        savedAddresses?: any[];
    }>();

    const emit = defineEmits<{
        'update:modelValue': [
            value: {
                lat: number;
                lng: number;
                address?: string;
                details?: {
                    full: string;
                    street: string;
                    city: string;
                    state: string;
                    zipCode: string;
                    country: string;
                };
            } | null,
        ];
        'update:is-confirmed': [confirmed: boolean];
    }>();

    const onAddressSelected = (val: any) => {
        if (!val) return;

        const saved = props.savedAddresses?.find((a) => a.address === val);
        if (saved && saved.latitude) {
            const pos = { lat: Number(saved.latitude), lng: Number(saved.longitude) };
            updateMarkerPosition(pos);
            emit('update:modelValue', {
                lat: pos.lat,
                lng: pos.lng,
                address: saved.address,
                details: {...saved.details},
            });
        } else {
            performSearch(val);
        }
    };

    const onSearchInput = (val: string) => {
        searchQuery.value = val;
        onSearch();
    };

    const isLoading = ref(true);
    const error = ref<string | null>(null);
    const selectedLocation = ref<{
        lat: number;
        lng: number;
        address?: string;
        details?: {
            full: string;
            street: string;
            city: string;
            state: string;
            zipCode: string;
            country: string;
        };
    } | null>(null);
    const searchQuery = ref('');
    const isAddressConfirmed = ref(false);

    const defaultCenter = { lat: 38.7223, lng: -9.1393 };

    let map: any = null;
    let marker: any = null;
    let geocoder: any = null;

    const initializeMap = async () => {
        try {
            isLoading.value = true;
            error.value = null;

            // Get API key from environment variables
            const apiKey = import.meta.env.VITE_GMAPS_KEY;

            if (!apiKey) {
                throw new Error('Google Maps API key not found. Please add VITE_GMAPS_KEY to your environment variables.');
            }

            const google = await loader.load();

            // Now that Google Maps is loaded, we can show the map container
            isLoading.value = false;

            // Wait for the map container to be rendered
            await nextTick();

            const mapContainer = document.getElementById('map-container') as HTMLDivElement;

            if (!mapContainer) {
                console.log('Map container not found');
                return;
            }

            // Use initial value if provided, otherwise use default center
            const initialCenter = props.modelValue ? { lat: props.modelValue.lat, lng: props.modelValue.lng } : defaultCenter;

            // Initialize map
            map = new google.maps.Map(mapContainer, {
                center: initialCenter,
                zoom: 13,
                mapTypeControl: false,
                streetViewControl: false,
                fullscreenControl: false,
                zoomControl: true,
                styles: [
                    {
                        featureType: 'poi',
                        elementType: 'labels',
                        stylers: [{ visibility: 'off' }],
                    },
                ],
            });

            // Initialize geocoder
            geocoder = new google.maps.Geocoder();

            // Create marker
            marker = new google.maps.Marker({
                position: initialCenter,
                map,
                draggable: !!props.edit,
                title: 'Arraste para selecionar a localização',
            });

            watch(
                () => props.edit,
                (newValue) => {
                    if (marker) {
                        marker.setDraggable(!!newValue);
                        marker.setTitle(newValue ? 'Arraste para selecionar a localização' : 'Localização fixa');
                    }
                },
            );

            // If we have saved location data, use it and set as confirmed
            if (props.modelValue) {
                selectedLocation.value = props.modelValue;
                isAddressConfirmed.value = true;
                emit('update:is-confirmed', true);
                // Don't geocode if we already have complete address data
                // Only geocode if we're missing address information
                if (!props.modelValue.address || !props.modelValue.details) {
                    await geocodePosition(initialCenter);
                }
            }

            // Add click listener to map
            map.addListener('click', (event: any) => {
                if (event.latLng) {
                    const position = {
                        lat: event.latLng.lat(),
                        lng: event.latLng.lng(),
                    };
                    updateMarkerPosition(position);
                }
            });

            // Add drag listener to marker
            if (props.edit) {
                marker.addListener('dragend', () => {
                    if (marker) {
                        const position = {
                            lat: marker.getPosition()?.lat() || 0,
                            lng: marker.getPosition()?.lng() || 0,
                        };
                        updateMarkerPosition(position);
                    }
                });
            }
        } catch (err) {
            console.log('Error initializing Google Maps:', err);
            error.value = err instanceof Error ? err.message : 'Failed to load map';
        }
    };

    const updateMarkerPosition = async (position: { lat: number; lng: number }) => {
        if (marker) {
            marker.setPosition(position);
        }

        if (map) {
            map.setCenter(position);
        }

        // Geocode the position to get address
        await geocodePosition(position);

        // Emit the updated value
        emit('update:modelValue', selectedLocation.value);
    };

    const geocodePosition = async (position: { lat: number; lng: number }) => {
        if (!geocoder) return;

        try {
            const results = await geocoder.geocode({ location: position });

            if (results.results[0]) {
                const result = results.results[0];
                const address = result.formatted_address;

                // Extract detailed address components
                const addressComponents = result.address_components;
                let zipCode = '';
                let city = '';
                let country = '';
                let state = '';
                let streetNumber = '';
                let route = '';

                // Parse address components
                addressComponents.forEach((component: any) => {
                    const types = component.types;

                    if (types.includes('postal_code')) {
                        zipCode = component.long_name;
                    } else if (types.includes('locality') || types.includes('administrative_area_level_2')) {
                        city = component.long_name;
                    } else if (types.includes('country')) {
                        country = component.long_name;
                    } else if (types.includes('administrative_area_level_1')) {
                        state = component.long_name;
                    } else if (types.includes('street_number')) {
                        streetNumber = component.long_name;
                    } else if (types.includes('route')) {
                        route = component.long_name;
                    }
                });

                // Build detailed address object
                const detailedAddress = {
                    full: address,
                    street: `${streetNumber} ${route}`.trim(),
                    city,
                    state,
                    zipCode,
                    country,
                };

                selectedLocation.value = {
                    lat: position.lat,
                    lng: position.lng,
                    address,
                    details: detailedAddress,
                };
            } else {
                selectedLocation.value = {
                    lat: position.lat,
                    lng: position.lng,
                };
            }
        } catch (err) {
            console.log('Geocoding error:', err);
            selectedLocation.value = {
                lat: position.lat,
                lng: position.lng,
            };
        }
    };

    const confirmAddress = () => {
        isAddressConfirmed.value = true;
        emit('update:is-confirmed', true);
    };

    // Search functionality
    const onSearch = () => {
        // Debounce search to avoid too many API calls
        if (searchTimeout) {
            clearTimeout(searchTimeout);
        }
        searchTimeout = setTimeout(() => {
            if (searchQuery.value.trim()) {
                performSearch(searchQuery.value);
            }
        }, 500);
    };

    let searchTimeout: any = null;

    const performSearch = async (query: string) => {
        if (!geocoder) return;

        try {
            const results = await geocoder.geocode({ address: query });
            if (results.results && results.results.length > 0) {
                const result = results.results[0];
                const position = {
                    lat: result.geometry.location.lat(),
                    lng: result.geometry.location.lng(),
                };

                // Update map and marker
                map.setCenter(position);
                marker.setPosition(position);

                // Update selected location with geocoded details
                await geocodePosition(position);
            }
        } catch (err) {
            console.log('Search error:', err);
        }
    };

    // Watch for prop changes
    watch(
        () => props.modelValue,
        (newValue) => {
            if (newValue && map && marker) {
                const position = { lat: newValue.lat, lng: newValue.lng };
                marker.setPosition(position);
                map.setCenter(position);
                selectedLocation.value = newValue;
            }
        },
        { deep: true },
    );

    // Emit changes when selectedLocation changes
    watch(
        selectedLocation,
        (newValue, oldValue) => {
            if (newValue) {
                emit('update:modelValue', newValue);
                // Only reset confirmation if this is a user-initiated change (not initial load)
                // Check if coordinates actually changed (user moved marker/clicked map)
                if (oldValue && (oldValue.lat !== newValue.lat || oldValue.lng !== newValue.lng)) {
                    isAddressConfirmed.value = false;
                    emit('update:is-confirmed', false);
                }
            }
        },
        { deep: true },
    );

    onMounted(async () => {
        await initializeMap();
    });

    onUnmounted(() => {
        if (marker) {
            marker.setMap(null);
        }
        if (map) {
            map = null;
        }
    });
</script>
