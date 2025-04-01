<script lang="ts">
    import Waypoint from "./Waypoint.svelte";
    import MainPageInput from "./MainPageInput.svelte";
    import Header from "./Header.svelte";
    import Divider from "./Divider.svelte";
    import { onMount, onDestroy } from "svelte";
    import { nuiFetch } from "../lib/nuiFetch";
    import { dataArray } from "../stores/store";

    let { app } = $props();

    onMount(() => {
        dataArray.set([]);
        nuiFetch("getWaypoints");
    });

    const handleData = (event: any) => {
        if (event.data?.type !== "getWaypoints") return;
        
        dataArray.update(items => {
            const exists = items.some(item => item.waypointId === event.data.data.waypointId);
            return exists ? items : [...items, event.data.data];
        });
    };

    window.addEventListener("message", handleData);

    // Cleanup
    onDestroy(() => {
        window.removeEventListener("message", handleData);
        dataArray.set([]);
    });
</script>

<div class="flex flex-col p-10 w-full">
    <Header {app} />
    <Divider />
    <MainPageInput />
    <br />

    <div class="grid grid-cols-2 gap-5 w-full overflow-auto no-scrollbar">
        {#if $dataArray.length > 0}
            {#each $dataArray as waypoint (waypoint.waypointId)}
                <Waypoint
                    {app}
                    waypointId={waypoint.waypointId}
                    waypointName={waypoint.waypointName}
                    waypointCoords={`X: ${waypoint.x} Y: ${waypoint.y} Z: ${waypoint.z}`}
                    waypointDescription={waypoint.waypointDescription}
                    favourite={waypoint.isFavourite}
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