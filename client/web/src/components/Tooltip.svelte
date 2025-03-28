<script lang="ts">
  let { text } = $props(); // Default tooltip text
  
  let isVisible = $state(false); // Correct reactivity in Svelte

  const showTooltip = () => isVisible = true;
  const hideTooltip = () => isVisible = false;
</script>

<div 
  class="relative inline-block" 
  role="tooltip" 
  on:mouseenter={showTooltip} 
  on:mouseleave={hideTooltip}
>
  <slot />

  {#if isVisible}
    <div
      class="absolute z-10 px-3 py-2 text-sm text-white bg-[#364153] rounded-lg transition-opacity duration-200 -translate-y-1/2 top-1/2 right-full mr-2 whitespace-nowrap w-fit"
      role="tooltip" 
      aria-hidden={!isVisible}
    >
      {text}
      <div
        class="absolute w-2 h-2 bg-[#364153] transform rotate-45 top-1/2 -translate-y-1/2 left-full -translate-x-1/2"
      ></div>
    </div>
  {/if}
</div>
