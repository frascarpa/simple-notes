<template>
  <div>
    <v-subheader v-if="lessons.length">LESSONS</v-subheader>
    <v-expansion-panels class="mb-4" accordion>
      <v-expansion-panel v-for="lesson in lessons" :key="lesson.id">
        <v-expansion-panel-header expand-icon="mdi-menu-down">
          <v-col cols="4">{{lesson.name}}</v-col>
          <v-col class="font-weight-light pl-4">{{humanDate(lesson.date)}} - {{lesson.description}}</v-col>
          <v-tooltip bottom :disabled="!recordNotes[lesson.id]">
            <template v-slot:activator="{ on }">
              <div v-on="on">
                <v-btn
                  :disabled="!!recordNotes[lesson.id]"
                  v-if="user.id === lesson.user_id"
                  @click.stop="deleteLesson(lesson.id)"
                  icon>
                  <v-icon>mdi-trash-can</v-icon>
                </v-btn>
              </div>
            </template>
            <span>There are notes in this lesson.</span>
          </v-tooltip>
        </v-expansion-panel-header>
        <v-expansion-panel-content>
          <note-list :notes="recordNotes[lesson.id]" />
        </v-expansion-panel-content>
      </v-expansion-panel>
      <v-subheader v-if="!lessons.length">No lessons found</v-subheader>
    </v-expansion-panels>
  </div>
</template>

<script>
import { getNotes } from "@/api.js";
import { groupBy, dateFormattedFromISO } from "@/utils.js";
import NoteList from "@/components/NoteList.vue";

export default {
  name: "lesson-list",

  components: {
    NoteList
  },

  props: {
    lessons: {
      type: Array,
      default: () => []
    }
  },
  data() {
    return {
      notes: []
    };
  },

  computed: {
    recordNotes() {
      return groupBy(this.notes, "lesson_id");
    },
    user() {
      return this.$store.getters.getUser;
    }
  },

  mounted() {
    getNotes().then(({ data }) => (this.notes = data.data));
  },

  methods: {
    humanDate(date) {
      return dateFormattedFromISO(date);
    }
  }
};
</script>

<style>
</style>