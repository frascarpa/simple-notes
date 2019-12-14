<template>
  <div>
    <div>COURSES</div>
    <div>
      <create-course @created="fetchAllCourses" />
    </div>
    <div>{{courses}}</div>
  </div>
</template>

<script>
import { getCourses } from "@/api.js";
import CreateCourse from "@/components/CreateCourse.vue";

export default {
  nane: "Explore",

  components: {
    CreateCourse
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