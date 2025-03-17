<script lang="ts">
    import { Button, Label, Input, Textarea, Toast } from "flowbite-svelte";
    import {
        CheckOutline,
        CirclePlusSolid,
        MapPinAltSolid,
    } from "flowbite-svelte-icons";

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

        let waypointId =
            existingData.length > 0
                ? Math.max(
                      ...existingData.map(
                          (w: { waypointId: number }) => w.waypointId,
                      ),
                  ) + 1
                : 1;

        const waypointData = {
            waypointId,
            name: waypointName,
            X: waypointCoordsX,
            Y: waypointCoordsY,
            Z: waypointCoordsZ,
            description: waypointDescription,
        };

        existingData.push(waypointData);
        localStorage.setItem("WAYPOINT_DATA", JSON.stringify(existingData));

        // Navigate back to the main page
        app.showAddNewPage = false;
        app.showMainPage = true;
    };

    const getCurrentPlayerCoords = () => {
        fetch("https://yorick-waypoints/coords", {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=UTF-8",
            },
            body: JSON.stringify({
                itemId: "playerCoords",
            }),
        }).then((response) =>
            response.json().then((obj) => {
                waypointCoordsX = obj.x;
                waypointCoordsY = obj.y;
                waypointCoordsZ = obj.z;
            }),
        );
    };
</script>

<div class="flex flex-col p-10 w-full">
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

    <hr class="border-t-2=1 !border-[#a1a1a7] my-4" />

    <div class="w-[55rem]">
        <Label class="block mb-2 !text-[#d1d5db]">Waypoint name</Label>
        <Input
            id="waypointname"
            name="waypointname"
            required
            placeholder="Name"
            autocomplete="off"
            bind:value={waypointName}
            class="!bg-[#374152] !border-[#4a5564] text-[#fff] !placeholder-[#99a1ae]"
        />
    </div>

    <div class="flex flex-row mt-5 gap-x-5">
        <div class="mb-6">
            <Label for="input-group-1" class="block mb-2 !text-[#d1d5db]"
                >X coord</Label
            >
            <Input
                bind:value={waypointCoordsX}
                class="w-[14rem] !bg-[#374152] !border-[#4a5564] !text-[#fff] !placeholder-[#99a1ae]"
                id="coord"
                type="text"
                autocomplete="off"
                placeholder="0"
            ></Input>
        </div>

        <div class="mb-6">
            <Label for="input-group-1" class="block mb-2 !text-[#d1d5db]"
                >Y coord</Label
            >
            <Input
                bind:value={waypointCoordsY}
                class="w-[14rem] !bg-[#374152] !border-[#4a5564] text-[#fff] !placeholder-[#99a1ae]"
                id="coord"
                type="text"
                autocomplete="off"
                placeholder="0"
            ></Input>
        </div>

        <div class="mb-6">
            <Label for="input-group-1" class="block mb-2 !text-[#d1d5db]"
                >Z coord</Label
            >
            <Input
                bind:value={waypointCoordsZ}
                class="w-[14rem] !bg-[#374152] !border-[#4a5564] !text-[#fff] !placeholder-[#99a1ae]"
                id="coord"
                type="text"
                autocomplete="off"
                placeholder="0"
            ></Input>
        </div>

        <div class="mt-7">
            <Button
                class="w-[9.2rem] bg-[#202937] cursor-pointer"
                on:click={getCurrentPlayerCoords}>Current coords</Button
            >
        </div>
    </div>

    <Label for="message" class="block mb-2 !text-[#d1d5db]">Description</Label>
    <Textarea
        placeholder="Short description"
        class="h-[12rem] resize-none !bg-[#374152] !border-[#4a5564] text-[#fff] !placeholder-[#99a1ae]"
        bind:value={waypointDescription}
        {...app.textareaprops}
    />

    <div class="mt-6">
        <Button
            on:click={saveToLocalStorage}
            class="w-full !bg-[#202937] cursor-pointer"
        >
            <CheckOutline class="w-5 h-5 me-2" /> Save waypoint
        </Button>
    </div>
</div>
