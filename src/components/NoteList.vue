<template>
  <div>
    <v-subheader v-if="displayNotes.length">{{label}}</v-subheader>
    <v-subheader v-else>No notes found</v-subheader>
    <v-card v-if="displayNotes.length" class="mx-auto" tile>
      <v-list dense>
        <v-list-item-group color="primary">
          <v-list-item link @click="openNote(note.id)" v-for="note in displayNotes" :key="note.id">
            <v-list-item-avatar>
              <v-icon>mdi-note-text</v-icon>
            </v-list-item-avatar>
            <v-list-item-content>
              <v-list-item-title class="text-left" v-text="note.title"></v-list-item-title>
              <v-list-item-subtitle class="text-left" v-text="note.description"></v-list-item-subtitle>
            </v-list-item-content>
            <v-list-item-action>
              <v-btn v-if="user.id === note.user_id" @click.stop="deleteNote(note.id)" icon>
                <v-icon>mdi-trash-can</v-icon>
              </v-btn>
            </v-list-item-action>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-card>
  </div>
</template>

<script>
import { deleteNote } from "@/api.js";

export default {
  name: "note-list",

  props: {
    notes: {
      type: Array,
      default: () => []
    },
    label: {
      type: String,
      default: () => "NOTES"
    }
  },

data() {
  return {
    deleted: [],
  }
},

  computed: {
    user() {
      return this.$store.getters.getUser;
    },
    displayNotes(){
        return this.notes.filter((n) => !this.deleted.includes(n.id));
    }
  },

  methods: {
    openNote(id) {
      this.$router.push({ name: "notes", params: { id } });
    },
    deleteNote(id) {
      deleteNote(id)
      .then(() => {
        this.deleted.push(id);
        this.$emit('deleted');
        this.$notify({
          type: "success",
          group: "info",
          title: "Done!",
          text: "Note Deleted"
        });
      })

    }
  }
};
</script>

<style>
</style>