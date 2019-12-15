<template>
  <div>
      <v-text-field
          solo
          label="Search"
          prepend-inner-icon="search"
          v-model="query"
          @input="debouncedSearch($event)"
        ></v-text-field>
      <v-progress-circular indeterminate />
  </div>
</template>

<script>
import {search} from '@/api.js';

import debounce from 'lodash/debounce';

export default {
  name: 'Home',

  props: {
  },
data() {
  return {
    query: null,
    debouncedSearch: null,
  }
},

created(){
  this.debouncedSearch = debounce(this.search, 500);
},

methods: {
  search() {
    if (this.query && this.query.length > 0) {
      search(this.query);
    }
  }
},

}
</script>