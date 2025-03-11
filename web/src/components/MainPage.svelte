<script lang="ts">
    // Custom components
    import Waypoint from "./Waypoint.svelte";

    // Flowbite components
    import { Button, ButtonGroup, InputAddon, Input } from "flowbite-svelte";
    import { SearchOutline } from "flowbite-svelte-icons";

    let { app } = $props();

    let storedWaypointData = localStorage.getItem("WAYPOINT_DATA");

    if (storedWaypointData) {
        app.dataArray = JSON.parse(storedWaypointData);
    }
</script>

<div class="flex flex-col p-10 w-full gap-2">
    <div>
        <h1 class="text-white font-semibold text-2xl">Waypoint manager</h1>
        <h1 class="text-[#a1a1a7]">Save and manage your waypoints</h1>
    </div>
    <div class="flex flex-row gap-x-3 mt-1">
        <Button on:click={app.mainPageButton} class="w-[8rem]" color="light">
            Waypoints
        </Button>
        <Button on:click={app.addNewButton} class="w-[8rem]" color="light">
            Add new
        </Button>
    </div>
    <hr class="border-t-2=1 border-[#a1a1a7] my-4" />
    <div class="flex gap-x-2">
        <ButtonGroup class="w-full">
            <InputAddon>
                <SearchOutline class="text-gray-500 dark:text-gray-400" />
            </InputAddon>
            <Input id="input" placeholder="Search waypoints..." />
        </ButtonGroup>
    </div>
    <br />

    <div class="grid grid-cols-2 gap-5 w-full overflow-auto no-scrollbar">
        {#if app.dataArray.length > 0}
            {#each app.dataArray as waypointItem}
                <Waypoint
                    {app}
                    waypointId={waypointItem.waypointId}
                    waypointName={waypointItem.name}
                    waypointCoords={`X:${waypointItem.X} Y:${waypointItem.Y} Z:${waypointItem.Z}`}
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
