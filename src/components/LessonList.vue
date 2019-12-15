<template>
<div>
        <v-subheader v-if="lessons.length" >LESSONS</v-subheader>
        <v-expansion-panels class="mb-4" accordion>
        <v-expansion-panel v-for="lesson in lessons" :key="lesson.id">
          <v-expansion-panel-header expand-icon="mdi-menu-down">
            {{lesson.name}}
            <div class="font-weight-light pl-4">{{lesson.description}}</div>
            </v-expansion-panel-header>
          <v-expansion-panel-content>
              <note-list :notes="recordNotes[lesson.id]"/>
          </v-expansion-panel-content>
        </v-expansion-panel>
      <v-subheader v-if="!lessons.length">No lessons found</v-subheader>
      </v-expansion-panels>
</div>
</template>

<script>
import { getNotes } from '@/api.js';
import { groupBy } from '@/utils.js';
import NoteList from '@/components/NoteList.vue'

export default {
 name: 'lesson-list',

 components:{
   NoteList,
 },

 props: {
     lessons: {
         type: Array,
         default: () => []
     },
 },
 data() {
   return {
     notes: []
   }
 },

 computed: {
    recordNotes() {
        return groupBy(this.notes, 'lesson_id');
    }
},

 mounted() {
    getNotes()
        .then(({ data }) => (this.notes = data.data));
}

}
</script>

<style>

</style>