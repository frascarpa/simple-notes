<template>
  <div>
    <div>Explore</div>
    <div>
      <create-course @created="fetchAllCourses" />
      <create-lesson  />
    </div>
    <div>
        <course-list :courses="courses" />
    </div>
  </div>
</template>

<script>
import { getCourses } from "@/api.js";
import CreateCourse from "@/components/CreateCourse.vue";
import CreateLesson from "@/components/CreateLesson.vue";
import CourseList from "@/components/CourseList.vue";

export default {
  nane: "Explore",

  components: {
    CreateCourse,
    CreateLesson,
    CourseList,
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