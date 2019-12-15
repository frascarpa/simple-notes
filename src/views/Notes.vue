<template>
  <div>
    <note-list v-if="!id" :notes="notes" />
    <div v-else>
      <v-switch v-if="isMyNote" v-model="editMode" :label="'Edit mode'"></v-switch>
      <v-card v-if="editMode" class="mx-auto create-group mb-12" outlined>
        <v-row>
          <v-col cols="5">
            <v-text-field v-model="detailedNote.title" label="Title *" :disabled="!isMyNote"></v-text-field>
          </v-col>
          <v-col cols="7">
            <v-text-field
              v-model="detailedNote.description"
              label="Description"
              :disabled="!isMyNote"
            ></v-text-field>
          </v-col>
        </v-row>
      </v-card>
      <v-card class="mx-auto create-group" outlined>
        <div v-if="editMode">
          <vue-editor v-model="detailedNote.content"></vue-editor>
        </div>
        <div v-else v-html="detailedNote.content"></div>
      </v-card>
      <v-btn v-if="editMode" color="primary" :disabled="!detailedNote.title" @click="editNote">
        <v-icon>mdi-pencil</v-icon>Create Note
      </v-btn>
    </div>
  </div>
</template>

<script>
import { getMyNotes, getNoteDetails, editNote } from "@/api.js";
import NoteList from "@/components/NoteList.vue";
import { VueEditor } from "vue2-editor";

export default {
  name: "Notes",

  components: {
    NoteList,
    VueEditor
  },

  props: {
    id: {
      type: Number
    }
  },

  data: () => ({
    notes: [],
    detailedNote: {
      id: null,
      title: null,
      description: null,
      content: null,
    },
    editMode: false
  }),
  computed: {
    isMyNote() {
      if (!this.detailedNote.id) {
        return false;
      } else {
        return this.notes.some(n => n.id === this.detailedNote.id);
      }
    }
  },

  watch: {
    id:{
      handler(newId) {
        if (newId) {
          getNoteDetails(this.id).then(({ data }) => {
            this.detailedNote = data.data;
          });
        }
      },
      immediate:true,
    },
    isMyNote(newVal, oldVal) {
      if (newVal !== oldVal && newVal) {
        this.editMode = true;
      }
    }
  },

  mounted() {
    getMyNotes().then(({ data }) => {
      this.notes = data.data;
    });
  },

  methods: {
    fetchCurrentNote(){
        getNoteDetails(this.id).then(({ data }) => {
          this.detailedNote = data.data;
        });
    },
    editNote() {
      const { id, title, description, content } = this.detailedNote;
      editNote(id, title, description, content)
      .then(() => this.fetchCurrentNote())
      .then(()=>{
        this.$notify({
            type: "success",
            group: "info",
            title: "Error",
            text: "Note saved",
          })
          this.editMode = false;
      });
    }
  }
};
</script>