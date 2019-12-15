<template>
<v-card
    class="mx-auto"
    tile>
    <v-list dense>
      <v-subheader v-if="notes.length" >NOTES</v-subheader>
      <v-subheader v-else >NO NOTES AVAILABLE</v-subheader>
      <v-list-item-group color="primary">
        <v-list-item
        link @click="$router.push({ name: 'notes', params: { id: note.id }})"
          v-for="note in notes"
          :key="note.id">
          <v-list-item-icon>
              <v-icon>mdi-note-text</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title class="text-left" v-text="note.title"></v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list-item-group>
    </v-list>
  </v-card>
</template>

<script>

export default {
 name: 'note-list',

 props: {
     notes: {
         type: Array,
         default: () => []
     },
 },

}
</script>

<style>

</style>