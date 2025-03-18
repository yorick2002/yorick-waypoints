<script lang="ts">
  let { text = 'Tooltip text' } = $props(); // Default tooltip text
  
  let isVisible = $state(false)

  const showTooltip = () => isVisible = true;
  const hideTooltip = () => isVisible = false;
</script>

<!-- svelte-ignore a11y_no_static_element_interactions -->
<!-- svelte-ignore event_directive_deprecated -->
<div 
  class="relative inline-block" 
  on:mouseenter={showTooltip} 
  on:mouseleave={hideTooltip}
>
  <!-- Slot for the trigger element -->
  <slot />

  <!-- Tooltip -->
  {#if isVisible}
    <div
      class="absolute z-10 px-3 py-2 text-sm text-white bg-[#364153] rounded-lg transition-opacity duration-200 -translate-y-1/2 top-1/2 right-full mr-2 whitespace-nowrap w-fit"
    >
      {text}
      <!-- Tooltip arrow -->
      <div
        class="absolute w-2 h-2 bg-[#364153] transform rotate-45 top-1/2 -translate-y-1/2 left-full -translate-x-1/2"
      ></div>
    </div>
  {/if}
</div>
