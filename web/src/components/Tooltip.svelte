<script lang="ts">
    let { text = 'Tooltip text' } = $props(); // Destructure `text` with a default value
  </script>
  
  
  <!-- svelte-ignore slot_element_deprecated -->
  <div class="relative inline-block group">
    <!-- Slot for the trigger element -->
    <slot />
  
    <!-- Tooltip -->
    <div
      class="absolute z-10 px-3 py-2 text-sm text-white bg-[#364153] rounded-lg opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-opacity duration-200 -translate-y-1/2 top-1/2 right-full mr-2 whitespace-nowrap w-fit"
    >
      {text}
      <!-- Tooltip arrow -->
      <div
        class="absolute w-2 h-2 bg-[#364153] transform rotate-45 top-1/2 -translate-y-1/2 left-full -translate-x-1/2"
      ></div>
    </div>
  </div>