<script lang="ts">
    import { Input } from "flowbite-svelte";
    import { SearchOutline } from "flowbite-svelte-icons";

</script>
<div class="flex gap-x-2">
    <Input
        type="text"
        placeholder="Search..."
        class="w-[55rem] !bg-[#384151] !border-[#4a5564] !placeholder-[#99a1ae]"
    >
        <SearchOutline slot="left" color="#858d99" />
    </Input>
</div>