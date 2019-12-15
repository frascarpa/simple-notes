<template>
<div>
        <v-subheader v-if="courses.length" >COURSES</v-subheader>
        <v-expansion-panels class="mb-12"
        accordion >
        <v-expansion-panel v-for="course in courses" :key="course.id">
          <v-expansion-panel-header expand-icon="mdi-menu-down">
              {{course.name}}
            <div class="font-weight-light  pl-4">{{course.description}}</div>
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
import { getLessons } from '@/api.js';
import { groupBy } from '@/utils.js';
import LessonList from '@/components/LessonList.vue'

export default {
 name: 'course-list',

components: {
    LessonList,
},

props: {
     courses: {
         type: Array,
         default: () => []
     },
 },

 data() {
     return {
         lessons: []
     }
 },

computed: {
    recordLessons() {
        return groupBy(this.lessons, 'course_id');
    }
},

mounted() {
    getLessons()
        .then(({ data }) => (this.lessons = data.data));
}

}
</script>

<style>

</style>