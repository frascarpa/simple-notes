<template>
  <div>
    <div v-if="user.isLogged">
      <div>
        Welcome back, {{user.nickname}}
      </div>
      <div>
        your email: {{user.email}}
      </div>
      <v-btn @click="getMe(user.email)">request Who Am I</v-btn>
    </div>
    <div v-else>
      <v-progress-circular indeterminate />
    </div>
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

  data: () => ({
    getMe
  }),

  created () {
    if (this.user.email) {
      this.getMe(this.user.email);
    } else {
      this.$router.push('login')
    }
  },

}
</script>