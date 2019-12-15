<template>
  <div>
      <v-text-field
          solo
          class="mb-4"
          label="Search"
          prepend-inner-icon="search"
          v-model="query"
          @input="handleInput"
          :loading="pendingRequest"
        ></v-text-field>
      <course-list v-if="results.courses.length > 0" :courses="results.courses" />
      <lesson-list v-if="results.lessons.length > 0" :lessons="results.lessons" class="mb-12" />
      <note-list v-if="results.notes.length > 0" :notes="results.notes" />
  </div>
</template>

<script>
import debounce from 'lodash/debounce';

import {search} from '@/api.js';
import CourseList from "@/components/CourseList.vue";
import LessonList from "@/components/LessonList.vue";
import NoteList from "@/components/NoteList.vue";


export default {
  name: 'Home',

  components: {
    CourseList,
    LessonList,
    NoteList,
  },

  props: {
  },
data() {
  return {
    query: null,
    debouncedSearch: null,
    pendingRequest: false,
    results: {
      courses: [],
      lessons: [],
      notes: [],
    }
  }
},

created(){
  this.debouncedSearch = debounce(this.search, 500);
},

methods: {
  handleInput(query){
    if (this.query && this.query.length > 0) {
    this.pendingRequest = true;
    this.debouncedSearch(query);
    } else {
      this.pendingRequest=false
    }
  },
  search() {
      search(this.query)
      .then(({data})=>{
        this.pendingRequest = false;
        this.results = data.data;
      });
    }
},

}
</script>