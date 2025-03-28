<script lang="ts">
    import Waypoint from "./Waypoint.svelte";
    import MainPageInput from "./MainPageInput.svelte";
    import Header from "./Header.svelte";
    import Divider from "./Divider.svelte";

    import { nuiFetch } from "../lib/nuiFetch";
    import { dataArray } from "../stores/store";
    import { onDestroy } from "svelte";

    let { app } = $props();

    nuiFetch("getWaypoints");

    const handleData = (event: any) => {
        dataArray.update((items) => [...items, event.data.data]);
    };

    window.addEventListener("message", handleData);

    onDestroy(() => {
        window.removeEventListener("message", handleData);
        $dataArray = [];
    });
</script>

<div class="flex flex-col p-10 w-full">
    <Header {app} />
    <Divider />
    <MainPageInput />
    <br />

    <div class="grid grid-cols-2 gap-5 w-full overflow-auto no-scrollbar">
        {#if $dataArray && $dataArray.length > 0}
            {#each $dataArray as item}
                <Waypoint
                    {app}
                    waypointName={`Name: ${item.waypointName}`}
                    waypointCoords={`X:${item.x} Y:${item.y} Z:${item.z}`}
                />
            {/each}
        {:else}
            <div class="flex col-span-2 justify-center items-center h-full">
                <div class="text-center">
                    <h1 class="text-white font-semibold">No waypoints found</h1>
                    <p class="text-[#a1a1a7]">Add your first waypoint</p>
                </div>
            </div>
        {/if}
    </div>
</div>
