<script lang="ts">
  import MainPage from "./components/MainPage.svelte";
  import AddNewPage from "./components/AddNewPage.svelte";

  const app = $state({
    showMainPage: true,
    showAddNewPage: false,
    mainPageButton: mainPageButton,
    addNewButton: addNewButton,
    textAreaProps: {
      placeholder: "Enter description...",
      rows: 4,
      id: "textarea",
    },

    dataArray: JSON.parse(localStorage.getItem("WAYPOINT_DATA") || "[]")
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
</script>

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
