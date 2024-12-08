<script lang="ts">
    import parseInput from "$lib/parser";
    import CodeMirror from "svelte-codemirror-editor";

    let entry = "";
    let output = "";

    function parse() {
        output = parseInput(entry);
    }
</script>

<div class="p-5 flex flex-col lg:flex-row gap-4 min-h-screen">
    <!-- Sección izquierda: CodeMirror -->
    <div class="flex-1 p-4 bg-gray-100 border rounded-lg shadow min-h-[50vh] overflow-auto">
        <CodeMirror
            bind:value={entry}
            on:change={parse}
            class="h-full"
        />
    </div>

    <!-- Sección derecha: Salida -->
    <div class="flex-1 p-4 bg-gray-200 border rounded-lg shadow min-h-[50vh] overflow-auto">
        <pre class="whitespace-pre-wrap">Salida: {output}</pre>
    </div>
</div>

