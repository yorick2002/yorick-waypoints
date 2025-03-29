// stores.ts
import { writable, derived } from 'svelte/store';

// Initialize as empty array - we'll populate from API
export const dataArray = writable<any[]>([]);

export const favorites = derived(
  dataArray,
  $dataArray => $dataArray.filter(item => item.favourite === 1)
);