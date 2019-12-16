<template>
  <div>
    <course-list v-if="courses.length" label="EXPLORE AND FIND YOUR NOTE" :courses="courses" />
    <v-subheader link v-else>First, you need to create a course, and possibly a lesson too.</v-subheader >
    <history/>
  </div>
</template>

<script>
import { getCourses } from "@/api.js";
import CourseList from "@/components/CourseList.vue";
import History from "@/components/History.vue";

export default {
  nane: "Explore",

  components: {
    CourseList,
    History,
  },

  data() {
    return {
      courses: []
    };
  },

  mounted() {
    getCourses().then(({ data }) => (this.courses = data.data));
  },

  methods: {
    fetchAllCourses() {
      getCourses()
        .then(({ data }) => (this.courses = data.data))
        .catch(err => {
          this.$notify({
            type: "error",
            group: "info",
            title: "Error",
            text: "Cannot retreive courses " + err
          });
        });
    }
  }
};
</script>

<style>
</style>