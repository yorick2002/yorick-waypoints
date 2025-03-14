<script lang="ts">
    import {
        FileCopySolid,
        MapPinAltSolid,
        TrashBinSolid,
    } from "flowbite-svelte-icons";

    import Tooltip from "../components/Tooltip.svelte";

    let { app, waypointId, waypointName, waypointCoords } = $props();

    // Delete function
    const deleteRecord = (id: number) => {
        console.log("Deleting record with ID:", id);

        app.dataArray = app.dataArray.filter(
            (item: { waypointId: number }) => item.waypointId !== id,
        );
        localStorage.setItem("WAYPOINT_DATA", JSON.stringify(app.dataArray));
    };
</script>

<div>
    <div class="border-1 border-[#374152] bg-[#1e2939] p-7 rounded-lg relative">
        <!-- Vertical line -->
        <div class="absolute right-12 h-full w-px bg-[#374152] top-0"></div>

        <!-- Icons container -->
        <div
            class="absolute right-1 top-0.5 gap-2 h-full items-center pr-2 flex flex-col justify-center"
        >
            <Tooltip text="Teleport">
                <MapPinAltSolid
                    class="size-6 text-gray-400 hover:text-gray-200 cursor-pointer transition-colors"
                />
            </Tooltip>

            <Tooltip text="Copy coords">
                <FileCopySolid
                    class="size-6 text-gray-400 hover:text-gray-200 cursor-pointer transition-colors"
                />
            </Tooltip>

            <Tooltip text="Delete">
                <TrashBinSolid
                    class="size-6 text-gray-400 hover:text-gray-200 cursor-pointer transition-colors"
                    onclick={()=> deleteRecord(waypointId)}
                />
            </Tooltip>
        </div>

        <!-- Content -->
        <div class="flex items-end justify-end"></div>
        <div class="flex justify-between items-center">
            <h1
                class="text-lg font-semibold text-gray-900 dark:text-white mb-2"
            >
                {waypointName}
            </h1>
        </div>

        <p class="font-mono text-gray-700 dark:text-gray-400 leading-tight">
            {waypointCoords}
        </p>
    </div>
</div>
