<template>
  <div>
    <v-subheader v-if="displayLessons.length">LESSONS</v-subheader>
    <v-expansion-panels class="mb-4" accordion>
      <v-expansion-panel v-for="lesson in displayLessons" :key="lesson.id">
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
          <note-list @deleted="fetchNotes" :notes="recordNotes[lesson.id]" />
        </v-expansion-panel-content>
      </v-expansion-panel>
      <v-subheader v-if="!displayLessons.length">No lessons found</v-subheader>
    </v-expansion-panels>
  </div>
</template>

<script>
import { getNotes, deleteLesson } from "@/api.js";
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
      notes: [],
      deleted:[],
    };
  },

  computed: {
    recordNotes() {
      return groupBy(this.notes, "lesson_id");
    },
    user() {
      return this.$store.getters.getUser;
    },
    displayLessons() {
        return this.lessons.filter((l) => !this.deleted.includes(l.id));
    }
  },

  mounted() {
    this.fetchNotes();
  },

  methods: {
    fetchNotes(){
      getNotes()
        .then(({ data }) => (this.notes = data.data));
    },
    humanDate(date) {
      return dateFormattedFromISO(date);
    },
    deleteLesson(id) {
      deleteLesson(id)
      .then(() => {
            this.deleted.push(id);
            this.$emit('deleted');
            this.$notify({
              type: "success",
              group: "info",
              title: "Done!",
              text: "Lesson Deleted"
            });
          })
      }
  }
};
</script>

<style>
</style>