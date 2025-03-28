<script lang="ts">
    import {
        FileCopySolid,
        InfoCircleSolid,
        MapPinAltSolid,
        TrashBinSolid,
    } from "flowbite-svelte-icons";
    import Tooltip from "../components/Tooltip.svelte";
    import { nuiFetch } from "../lib/nuiFetch";

    import { dataArray } from "../stores/store";

    let { app, waypointName, waypointCoords, waypointDescription, waypointId } =
        $props();

    const deleteRecord = (id: number) => {
        dataArray.update(
            (items) => items.filter((item) => item.waypointId !== id), // Remove the item with the matching id
        );

        fetch("https://yorick-waypoints/deleteWaypoint", {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=UTF-8",
            },
            body: JSON.stringify({
                itemId: id,
            }),
        })
    };
</script>

<div>
    <div class="border-1 border-[#374152] bg-[#1e2939] p-8 rounded-lg relative">
        <div class="absolute right-12 h-full w-px bg-[#374152] top-0"></div>

        <div
            class="absolute right-1 top-0.5 gap-1.5 h-full items-center pr-2 flex flex-col justify-center"
        >
            <Tooltip text="Teleport">
                <MapPinAltSolid
                    color="#99a1ad"
                    class="size-5.5 text-gray-400 hover:text-gray-200 cursor-pointer transition-colors"
                />
            </Tooltip>

            <Tooltip text="Copy coords">
                <FileCopySolid
                    color="#99a1ad"
                    class="size-5.5 text-gray-400 hover:text-gray-200 cursor-pointer transition-colors"
                />
            </Tooltip>

            <Tooltip text={waypointDescription}>
                <InfoCircleSolid
                    color="#99a1ad"
                    class="size-5.5 text-gray-400 hover:text-gray-200 cursor-pointer transition-colors"
                />
            </Tooltip>

            <Tooltip text="Delete">
                <!-- Updated to use on:click and passing waypointId -->
                <TrashBinSolid
                    color="#99a1ad"
                    class="size-5.5 text-gray-400 hover:text-gray-200 cursor-pointer transition-colors"
                    onclick={() => deleteRecord(waypointId)}
                />
            </Tooltip>
        </div>

        <div class="flex items-end justify-end"></div>
        <div class="flex justify-between items-center">
            <h1 class="text-lg font-semibold text-white mb-2">
                {waypointName}
            </h1>
        </div>

        <p class="font-mono text-[#99a1ae] leading-tight">
            {waypointCoords}
        </p>
    </div>
</div>
