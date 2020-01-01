<template>
  <div>
    <v-subheader v-if="displayCourses.length">{{label}}</v-subheader>
    <v-expansion-panels class="mb-12" accordion>
      <v-expansion-panel v-for="course in displayCourses" :key="course.id">
        <v-expansion-panel-header expand-icon="mdi-menu-down">
          <v-col cols="4">{{course.name}}</v-col>
          <v-col class="font-weight-light pl-4">{{course.description}}</v-col>
          <v-tooltip bottom :disabled="!recordLessons[course.id]">
            <template v-slot:activator="{ on }">
              <div v-on="on">
                <v-btn
                  :disabled="!!recordLessons[course.id]"
                  v-if="user.id === course.user_id"
                  @click.stop="deleteCourse(course.id)"
                  icon
                >
                  <v-icon>mdi-trash-can</v-icon>
                </v-btn>
              </div>
            </template>
            <span>There are lessons in this course.</span>
          </v-tooltip>
        </v-expansion-panel-header>
        <v-expansion-panel-content>
          <lesson-list @deleted="fetchLessons" :lessons="recordLessons[course.id]" />
        </v-expansion-panel-content>
      </v-expansion-panel>
      <v-subheader v-if="!displayCourses.length">No courses found</v-subheader>
    </v-expansion-panels>
  </div>
</template>

<script>
import { getLessons, deleteCourse } from "@/api.js";
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
      lessons: [],
      deleted: []
    };
  },

  computed: {
    recordLessons() {
      return groupBy(this.lessons, "course_id");
    },
    user() {
      return this.$store.getters.getUser;
    },
    displayCourses() {
      return this.courses.filter(c => !this.deleted.includes(c.id));
    }
  },

  mounted() {
    this.fetchLessons();
  },

  methods: {
    fetchLessons() {
      getLessons().then(({ data }) => (this.lessons = data.data));
    },
    deleteCourse(id) {
      deleteCourse(id).then(() => {
        this.$emit("deleted");
        this.deleted.push(id);
        this.$notify({
          type: "success",
          group: "info",
          title: "Done!",
          text: "Course Deleted"
        });
      });
    }
  }
};
</script>

<style>
</style>