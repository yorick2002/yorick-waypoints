<script lang="ts">
    let { app, waypointId, waypointName, waypointCoords } = $props();

    // Icons

    import { ArrowRightOutline } from "flowbite-svelte-icons";
    import { FileCopyOutline } from "flowbite-svelte-icons";
    import { TrashBinOutline } from "flowbite-svelte-icons";

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
        <div class="absolute right-0 top-2 h-full items-center pr-2">
            <div>
                
            </div>
        </div>

        <!-- Content -->
        <div class="flex items-end justify-end"></div>
        <div class="flex justify-between items-center">
            <h1 class="text-lg font-semibold text-gray-900 dark:text-white">
                {waypointName}
            </h1>
        </div>

        <p class="font-mono mb- text-gray-700 dark:text-gray-400 leading-tight">
            {waypointCoords}
        </p>
    </div>
</div>
