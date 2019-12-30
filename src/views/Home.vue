<template>
  <div>
      <v-progress-circular indeterminate />
  </div>
</template>

<script>

import { getMe } from '@/api.js'

export default {
  name: 'Home',
  
  computed: {
    user() {
      return this.$store.getters.getUser;
    }
  },

  created () {
    if (this.user) {
      getMe(this.user.email)
      .then(() => {
        this.$router.push('explore')
      });
    } else {
      this.$router.push('login')
    }
  },

}
</script>