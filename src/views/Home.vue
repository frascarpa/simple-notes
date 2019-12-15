<template>
  <div>
      <v-progress-circular indeterminate />
  </div>
</template>

<script>

import { getMe } from '@/api.js'

export default {
  name: 'Home',

  props: {
    user: {
      type: Object,
      required: true,
    },
  },


  created () {
    if (this.user.email) {
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