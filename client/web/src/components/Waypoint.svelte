<script lang="ts">
    import {
        FileCopySolid,
        InfoCircleSolid,
        MapPinAltSolid,
        TrashBinSolid,
        StarOutline,
        StarSolid,
    } from "flowbite-svelte-icons";
    import Tooltip from "../components/Tooltip.svelte";
    import { nuiFetch } from "../lib/nuiFetch";
    import { setVisible } from "../lib/nuiVisibility";
    import { copyText } from "../utils/copyText";

    let {
        app,
        waypointName,
        waypointCoords,
        waypointDescription,
        waypointId,
        favourite = 0,
    } = $props();

    let isFavourite = $state(favourite === 1);

    $effect(() => {
        isFavourite = favourite === 1;
    });

    const teleportPlayer = (id: number) => {
        const waypoint = app.waypoints.find((item: any) => item.id === id);
        fetch(`https://yorick-waypoints/teleportPlayer`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=UTF-8",
            },
            body: JSON.stringify({
                coordX: waypoint.x,
                coordY: waypoint.y,
                coordZ: waypoint.z,
            }),
        });
        nuiFetch("closeMenu");
        setVisible(false);
    };

    const deleteRecord = (id: number) => {
        app.waypoints = app.waypoints.filter(
            (item: any) => item.id !== id
        );
        fetch("https://yorick-waypoints/deleteWaypoint", {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=UTF-8",
            },
            body: JSON.stringify({
                itemId: id,
            }),
        });
    };

    const toggleFavourite = async () => {
        isFavourite = !isFavourite;
        await nuiFetch("toggleFavourite", {
            waypointId: waypointId,
            favourite: isFavourite ? 1 : 0,
        });
    };
</script>

<div>
    <div class="border-1 border-[#374152] bg-[#1e2939] p-8 rounded-lg relative">
        <div class="absolute right-12 h-full w-px bg-[#374152] top-0"></div>

        <!-- Favourite Star Button -->
        <div class="absolute right-13 top-2 flex items-center pr-2">
            {#if isFavourite}
                <StarSolid
                    color="#fff54e"
                    class="size-5.5 text-yellow-400 cursor-pointer transition-colors"
                    onclick={toggleFavourite}
                />
            {:else}
                <StarOutline
                    style="color: #99a1ad;"
                    class="size-5.5 text-gray-400 hover:text-gray-200 cursor-pointer transition-colors"
                    onclick={toggleFavourite}
                />
            {/if}
        </div>
        
        <div
            class="absolute right-1 top-0.5 gap-1.5 h-full items-center pr-2 flex flex-col justify-center"
        >
            <Tooltip text="Teleport">
                <MapPinAltSolid
                    color="#99a1ad"
                    class="size-5.5 text-gray-400 hover:text-gray-200 cursor-pointer transition-colors"
                    onclick={() => {
                        teleportPlayer(waypointId);
                    }}
                />
            </Tooltip>

            <Tooltip text="Copy coords">
                <FileCopySolid
                    color="#99a1ad"
                    class="size-5.5 text-gray-400 hover:text-gray-200 cursor-pointer transition-colors"
                    onclick={() => {
                        copyText(waypointCoords);
                    }}
                />
            </Tooltip>

            <Tooltip text={waypointDescription}>
                <InfoCircleSolid
                    color="#99a1ad"
                    class="size-5.5 text-gray-400 hover:text-gray-200 cursor-pointer transition-colors"
                />
            </Tooltip>

            <Tooltip text="Delete">
                <TrashBinSolid
                    color="#99a1ad"
                    class="size-5.5 text-gray-400 hover:text-gray-200 cursor-pointer transition-colors"
                    onclick={() => deleteRecord(waypointId)}
                />
            </Tooltip>
        </div>

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
