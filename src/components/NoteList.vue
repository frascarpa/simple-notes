<template>
  <div>
    <v-subheader v-if="notes.length">{{label}}</v-subheader>
    <v-subheader v-else>No notes found</v-subheader>
    <v-card v-if="notes.length" class="mx-auto" tile>
      <v-list dense>
        <v-list-item-group color="primary">
          <v-list-item link @click="openNote(note.id)" v-for="note in notes" :key="note.id">
            <v-list-item-avatar>
              <v-icon>mdi-note-text</v-icon>
            </v-list-item-avatar>
            <v-list-item-content>
              <v-list-item-title class="text-left" v-text="note.title"></v-list-item-title>
              <v-list-item-subtitle class="text-left" v-text="note.description"></v-list-item-subtitle>
            </v-list-item-content>
            <v-list-item-action>
              <v-btn v-if="user.id === note.user_id" @click.stop="deleteNote(lesson.id)" icon>
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
  computed: {
    user() {
      return this.$store.getters.getUser;
    }
  },

  methods: {
    openNote(id) {
      this.$router.push({ name: "notes", params: { id } });
    }
  }
};
</script>

<style>
</style>