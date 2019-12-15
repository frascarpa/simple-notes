<template>
  <div>
    <div>Explore</div>
      <course-list :courses="courses" />
  </div>
</template>

<script>
import { getCourses } from "@/api.js";
import CourseList from "@/components/CourseList.vue";

export default {
  nane: "Explore",

  components: {
    CourseList
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