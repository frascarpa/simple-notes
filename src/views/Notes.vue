<template>
  <div>notes!
    <note-list v-if="!id" :notes="notes"/>
    <div v-else >
      <div> you are in detail note </div>
      <div> {{detailedNote}}</div>
    </div>
  </div>
</template>

<script>

import { getMyNotes, getNoteDetails } from '@/api.js'
import NoteList from '@/components/NoteList.vue'


export default {
  name: 'Notes',

components: {
  NoteList
},

  props: {
    id: {
      type: Number,
    },
  },

  data: () => ({
    notes: [],
    detailedNote: null,
  }),

  watch: {
    id(newId) {
      if(newId) {
        getNoteDetails(this.id).then(({data})=>{this.detailedNote = data.data })
      }
    }
  },

  mounted () {
      getMyNotes().then(({data}) => { this.notes = data.data})
  },

}
</script>