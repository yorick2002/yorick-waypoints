<script lang="ts">
  import MainPage from "./components/MainPage.svelte";
  import AddNewPage from "./components/AddNewPage.svelte";

  import { nuiFetch } from "./lib/nuiFetch";
  import { visibility, setVisible } from "./lib/nuiVisibility";
  import { onDestroy } from "svelte";

  const app = $state({
    shouldDisplay: false,
    showMainPage: true,
    showAddNewPage: false,
    opacity: 0,
    mainPageButton: mainPageButton,
    addNewButton: addNewButton,
    textAreaProps: {
      placeholder: "Enter description...",
      rows: 4,
      id: "textarea",
    },

    dataArray: JSON.parse(localStorage.getItem("WAYPOINT_DATA") || "[]"),
  });

  // Functions to toggle pages
  function mainPageButton() {
    app.showMainPage = true;
    app.showAddNewPage = false;
  }

  function addNewButton() {
    app.showMainPage = false;
    app.showAddNewPage = true;
  }

  $effect(() => { // hehe we fade in, very meh!
    if ($visibility) {
      app.shouldDisplay = true;
      setTimeout(() => app.opacity = 1, 0);
    } else {
      app.opacity = 0;
      setTimeout(() => app.shouldDisplay = false, 200);
    }
  });

  $effect(() => {
    const mainPageButton = document.querySelector("#MainPageButton");
    const addNewButton = document.querySelector("#AddNewButton");

    if (app.showMainPage) {
      mainPageButton?.classList.add("waypointsPageIndicator");
    } else {
      addNewButton?.classList.add("addNewPageIndicator");
    }
  });

  const handleKeydown = (e: KeyboardEvent) => {
    if (e.key === "Escape" && $visibility) {
      nuiFetch("closeMenu")
      setVisible(false);
    }
  };
  window.addEventListener("keydown", handleKeydown);

  onDestroy(() => {
    window.removeEventListener("keydown", handleKeydown);
  });
</script>

{#if app.shouldDisplay}
  <div class="w-full relative h-dvh flex items-center justify-center">
    <div class="flex w-[60rem] h-[40rem] bg-[#333841] rounded-2xl">
      {#if app.showMainPage}
        <MainPage {app} />
      {/if}

      {#if app.showAddNewPage}
        <AddNewPage {app} />
      {/if}
    </div>
  </div>
{/if}
