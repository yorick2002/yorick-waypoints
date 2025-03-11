<script lang="ts">
    import { Button, Label, Input, Textarea } from "flowbite-svelte";
    import { CheckOutline } from "flowbite-svelte-icons";

    let { app } = $props();

    let waypointName = $state("");
    let waypointCoordsX = $state("");
    let waypointCoordsY = $state("");
    let waypointCoordsZ = $state("");
    let waypointDescription = $state("");

    const saveToLocalStorage = () => {
        const existingData = JSON.parse(
            localStorage.getItem("WAYPOINT_DATA") ?? "[]",
        );

        // Find the highest existing waypointId and increment it
        let waypointId =
            existingData.length > 0
                ? Math.max(
                      ...existingData.map(
                          (w: { waypointId: number }) => w.waypointId,
                      ),
                  ) + 1
                : 1;

        const waypointData = {
            waypointId, // Assign the unique ID
            name: waypointName,
            X: waypointCoordsX,
            Y: waypointCoordsY,
            Z: waypointCoordsZ,
            description: waypointDescription,
        };

        existingData.push(waypointData);
        localStorage.setItem("WAYPOINT_DATA", JSON.stringify(existingData));

        app.showAddNewPage = false;
        app.showMainPage = true;
    };
</script>

<div class="p-10 gap-2">
    <div>
        <h1 class="text-white font-semibold text-2xl">Waypoint manager</h1>
        <h1 class="text-[#a1a1a7]">Save and manage your waypoints</h1>
    </div>

    <!-- Button container -->
    <div class="flex flex-row gap-x-3 mt-3">
        <Button on:click={app.mainPageButton} class="w-[8rem]" color="light">
            Waypoints
        </Button>
        <Button on:click={app.addNewButton} class="w-[8rem]" color="light">
            Add new
        </Button>
    </div>

    <hr class="border-t-2=1 border-[#a1a1a7] my-6" />

    <div class="w-[55rem]">
        <Label class="block mb-2">Waypoint name</Label>
        <Input
            id="waypointname"
            name="waypointname"
            required
            placeholder="Name"
            autocomplete="off"
            bind:value={waypointName}
        />
    </div>

    <div class="flex flex-row mt-5 gap-x-5">
        <div class="mb-6">
            <Label for="input-group-1" class="block mb-2">X coord</Label>
            <Input
                bind:value={waypointCoordsX}
                class="w-[14rem]"
                id="coord"
                type="text"
                autocomplete="off"
                placeholder="0"
            ></Input>
        </div>

        <div class="mb-6">
            <Label for="input-group-1" class="block mb-2">Y coord</Label>
            <Input
                bind:value={waypointCoordsY}
                class="w-[14rem]"
                id="coord"
                type="text"
                autocomplete="off"
                placeholder="0"
            ></Input>
        </div>

        <div class="mb-6">
            <Label for="input-group-1" class="block mb-2">Z coord</Label>
            <Input
                bind:value={waypointCoordsZ}
                class="w-[14rem]"
                id="coord"
                type="text"
                autocomplete="off"
                placeholder="0"
            ></Input>
        </div>

        <div class="mt-7">
            <Button class="w-[9.2rem]" color="light">Current coords</Button>
        </div>
    </div>

    <Label for="message" class="block mb-2">Description (optional)</Label>
    <Textarea
        class="h-[8rem]"
        bind:value={waypointDescription}
        {...app.textareaprops}
    />

    <div class="mt-6">
        <Button on:click={saveToLocalStorage} color="light" class="w-full">
            <CheckOutline class="w-5 h-5 me-2" /> Save waypoint
        </Button>
    </div>
</div>
