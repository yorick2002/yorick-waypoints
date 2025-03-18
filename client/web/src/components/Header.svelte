<script lang="ts">
    import { Button } from "flowbite-svelte";
    import { MapPinAltSolid, CirclePlusSolid } from "flowbite-svelte-icons";

    let { app } = $props();
</script>

<div class="flex gap-5">
    <h1 class="text-white font-semibold text-2xl">Waypoint manager</h1>

    <div class="flex flex-row gap-x-3 ml-auto mt-1">
        <Button
            on:click={app.mainPageButton}
            class="w-[8rem] !bg-[#202937] cursor-pointer"
            id="MainPageButton"
        >
            Waypoints
            <MapPinAltSolid class="w-5 h-5 ms-2" />
        </Button>
        <Button
            on:click={app.addNewButton}
            class="w-[8rem] !bg-[#202937] cursor-pointer"
            id="AddNewButton"
        >
            Add new
            <CirclePlusSolid class="w-5 h-5 ms-2" />
        </Button>
    </div>
</div>

<h1 class="text-[#a1a1a7]">Save and manage your waypoints</h1>
