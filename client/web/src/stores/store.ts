// stores.ts
import { writable, derived } from 'svelte/store';

export const dataArray = writable<any[]>([]);