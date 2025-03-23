<script lang="ts">
    // Custom components
    import Waypoint from "./Waypoint.svelte";

    // Flowbite components
    import { Button, Input } from "flowbite-svelte";
    import {
        CirclePlusSolid,
        MapPinAltSolid,
        SearchOutline,
    } from "flowbite-svelte-icons";

    import { onNuiMessage } from "../lib/nuiListen";

    let { app } = $props();

    onNuiMessage("getWaypoints", (data: any) => {
        const jsonObject = data;
        const array = Object.values(jsonObject);
        array.forEach((value) => {
            console.log(value);
        });
    });
</script>

<div class="flex flex-col p-10 w-full">
    <div class="flex gap-5">
        <h1 class="text-white font-semibold text-2xl">Waypoint manager</h1>

        <div class="flex flex-row gap-x-3 ml-auto mt-1">
            <Button
                on:click={app.mainPageButton}
                class="w-[8rem] bg-[#202937] cursor-pointer"
                id="MainPageButton"
            >
                Waypoints
                <MapPinAltSolid class="w-5 h-5 ms-2" />
            </Button>
            <Button
                on:click={app.addNewButton}
                class="w-[8rem] bg-[#202937] cursor-pointer"
                id="AddNewButton"
            >
                Add new
                <CirclePlusSolid class="w-5 h-5 ms-2" />
            </Button>
        </div>
    </div>

    <h1 class="text-[#a1a1a7]">Save and manage your waypoints</h1>

    <hr class="border-t-2=1 border-[#a1a1a7] my-4" />

    <div class="flex gap-x-2">
        <Input
            type="text"
            placeholder="Search..."
            class="w-[55rem] !bg-[#384151] !border-[#4a5564] !placeholder-[#99a1ae]"
        >
            <SearchOutline slot="left" color="#858d99" />
        </Input>
    </div>
    <br />

    <div class="grid grid-cols-2 gap-5 w-full overflow-auto no-scrollbar">
        {#if app.waypoints && app.waypoints.length > 0}
            {#each app.waypoints as waypoint}
                <Waypoint
                    {app}
                    waypointName={waypoint.name}
                    waypointCoords={`X:${waypoint.x} Y:${waypoint.y} Z:${waypoint.z}`}
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
