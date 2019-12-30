<template>
  <div>
    <v-subheader v-if="courses.length">{{label}}</v-subheader>
    <v-expansion-panels class="mb-12" accordion>
      <v-expansion-panel v-for="course in courses" :key="course.id">
        <v-expansion-panel-header expand-icon="mdi-menu-down">
        <v-col cols="4">
            {{course.name}}
        </v-col>
          <v-col class="font-weight-light pl-4">{{course.description}}</v-col>
        <v-tooltip bottom :disabled="!recordLessons[course.id]">
            <template v-slot:activator="{ on }">
                    <div v-on="on">

                <v-btn
                :disabled="!!recordLessons[course.id]"
                v-if="user.id === course.user_id"
                @click.stop="deleteCourse(course.id)"
                icon>
                    <v-icon>mdi-trash-can</v-icon>
                </v-btn>
                    </div>
            </template>
            <span>There are lessons in this course.</span>
            </v-tooltip>
        </v-expansion-panel-header>
        <v-expansion-panel-content>
          <lesson-list :lessons="recordLessons[course.id]" />
        </v-expansion-panel-content>
      </v-expansion-panel>
      <v-subheader v-if="!courses.length">No courses found</v-subheader>
    </v-expansion-panels>
  </div>
</template>

<script>
import { getLessons } from "@/api.js";
import { groupBy } from "@/utils.js";
import LessonList from "@/components/LessonList.vue";

export default {
  name: "course-list",

  components: {
    LessonList
  },

  props: {
    courses: {
      type: Array,
      default: () => []
    },
    label: {
      type: String,
      default: () => "COURSES"
    }
  },

  data() {
    return {
      lessons: []
    };
  },

  computed: {
    recordLessons() {
      return groupBy(this.lessons, "course_id");
    },
    user() {
      return this.$store.getters.getUser;
    }
  },

  mounted() {
    getLessons().then(({ data }) => (this.lessons = data.data));
  },

  methods: {
      deleteCourse(id) {
          // eslint-disable-next-line 
          console.log('delete', id);
      }
  },
};
</script>

<style>
</style>