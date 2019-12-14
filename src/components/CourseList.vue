<template>
<div>
        <v-expansion-panels class="mb-12">
        <v-expansion-panel v-for="course in courses" :key="course.id">
          <v-expansion-panel-header expand-icon="mdi-menu-down">{{course.name}}</v-expansion-panel-header>
          <v-expansion-panel-content>
              <div> {{course.description}}</div>
              <lesson-list :lessons="recordLessons[course.id]" />

          </v-expansion-panel-content>
        </v-expansion-panel>
      <div v-if="!courses.length">No courses found</div>
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