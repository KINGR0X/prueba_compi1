<script lang="ts">
    import parseInput from "$lib/parser";
    import CodeMirror from "svelte-codemirror-editor";
    import { oneDark } from "@codemirror/theme-one-dark";

    let entry = "";
    let output = "";

    function parse() {
        output = parseInput(entry);
    }
</script>

<div class="p-5 flex flex-col lg:flex-row gap-4 min-h-screen bg-gray-900 text-gray-200">

    <div class="flex-1 p-4 bg-gray-800 border border-gray-700 rounded-lg shadow min-h-[50vh] overflow-auto">
        <CodeMirror
            bind:value={entry}
            on:change={parse}
            class="h-full"
        />
    </div>

    <div class="flex-1 p-4 bg-gray-800 border border-gray-700 rounded-lg shadow min-h-[50vh] overflow-auto">
        <pre class="whitespace-pre-wrap">Salida: {output}</pre>
    </div>
</div>

