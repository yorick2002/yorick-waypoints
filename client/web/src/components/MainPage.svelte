<script lang="ts">
    import Waypoint from "./Waypoint.svelte";
    import MainPageInput from "./MainPageInput.svelte";
    import Header from "./Header.svelte";
    import Divider from "./Divider.svelte";
    import { onNuiMessage } from "../lib/nuiListen";
    import { nuiFetch } from "../lib/nuiFetch";
    import { onMount } from "svelte";

    let { app } = $props();
    
    onMount(() => {
        // Fetch waypoints when the component mounts
        nuiFetch("getWaypoints").then((data) => {
            app.waypoints = data;
        });
    });
    
    onNuiMessage("getWaypoints", (data: any) => {
        console.log(data);
        app.waypoints = data;
    });
</script>

<div class="flex flex-col p-10 w-full">
    <Header {app} />
    <Divider />
    <MainPageInput />
    <br />

    <div class="grid grid-cols-2 gap-5 w-full overflow-auto no-scrollbar">
        {#if app.waypoints.length > 0}
            {#each app.waypoints as waypoint}
                <Waypoint
                    {app}
                    waypointId={waypoint.id}
                    waypointName={waypoint.name}
                    waypointCoords={`X: ${waypoint.x} Y: ${waypoint.y} Z: ${waypoint.z}`}
                    waypointDescription={waypoint.description}
                    favourite={waypoint.favourite}
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
