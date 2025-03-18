<script lang="ts">
    import {
        FileCopySolid,
        InfoCircleSolid,
        MapPinAltSolid,
        TrashBinSolid,
    } from "flowbite-svelte-icons";

    import { visibility, setVisible } from "../lib/nuiVisibility";

    import Tooltip from "../components/Tooltip.svelte";
    import { nuiFetch } from "../lib/nuiFetch";

    let { app, waypointId, waypointName, waypointCoords } = $props();

    // Delete function
    const deleteRecord = (id: number) => {
        app.dataArray = app.dataArray.filter(
            (item: { waypointId: number }) => item.waypointId !== id,
        );
        localStorage.setItem("WAYPOINT_DATA", JSON.stringify(app.dataArray));
    };

    const getDescription = (id: number): string | undefined => {
        const waypoint = app.dataArray.find(
            (item: { waypointId: number }) => item.waypointId === id,
        );
        return waypoint?.description;
    };
    const description = getDescription(waypointId);

    const copyItem = async (textToCopy: string) => {
        const textArea = document.createElement("textarea");
        textArea.value = textToCopy;
        document.body.appendChild(textArea);
        textArea.select();
        document.execCommand("copy");
        document.body.removeChild(textArea);
    };

    const teleportPlayer = async (id: number) => {
        // Find the waypoint by ID
        const waypoint = app.dataArray.find(
            (item: any) => item.waypointId === id,
        );
        
        const x = waypoint?.X?.toString(); 
        const y = waypoint?.Y?.toString(); 
        const z = waypoint?.Z?.toString(); 

        console.log(x);
        console.log(y);
        console.log(z);

        fetch(`https://yorick-waypoints/teleportPlayer`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=UTF-8",
            },
            body: JSON.stringify({
                coordX: x,
                coordY: y,
                coordZ: z,
            }),
        });
        nuiFetch("closeMenu")
        setVisible(false);
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
                    onclick={() => teleportPlayer(waypointId)}
                />
            </Tooltip>

            <Tooltip text="Copy coords">
                <FileCopySolid
                    color="#99a1ad"
                    class="size-5.5 text-gray-400 hover:text-gray-200 cursor-pointer transition-colors"
                    onclick={() => copyItem(waypointCoords)}
                />
            </Tooltip>

            <Tooltip text={description}>
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
