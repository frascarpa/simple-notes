<template>
      <v-container
        class="fill-height"
        fluid
      >
        <v-row
          align="center"
          justify="center"
        >
          <v-col
            cols="12"
            sm="8"
            md="4"
          >
            <v-card class="elevation-12">
              <v-toolbar
                color="primary"
                dark
                flat
              >
                <v-toolbar-title>Register form</v-toolbar-title>
                <v-spacer />
              </v-toolbar>
              <v-card-text>
                <v-form>
                  <v-text-field
                    v-model="email"
                    label="Email"
                    name="email"
                    prepend-icon="email"
                    type="text"
                  />

                  <v-text-field
                    v-model="nickname"
                    label="Nickname"
                    name="nickname"
                    prepend-icon="user"
                    type="text"
                  />

                  <v-text-field
                    v-model="password"
                    id="password"
                    label="Password"
                    name="password"
                    prepend-icon="lock"
                    type="password"
                  />
                </v-form>
              </v-card-text>
              <v-card-actions>
                <v-spacer />
                <v-btn color="primary" @click="register" :disabled="!isFormValid">Register</v-btn>
              </v-card-actions>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
</template>

<script>

import {register} from '@/api.js'
export default {
  name: 'Register',


  data: () => ({
      email: null,
      password: null,
      nickname: null,
  }),

  computed: {
    isFormValid() {
      return this.email && this.password && this.nickname; 
    }
  },

  methods: {
      register() {
          return register(this.email, this.nickname, this.password)
            .then(()=>{
                this.$notify({
                  type: 'success',
                  group: 'info',
                  title: 'User Created',
                  text: 'The requested user has been created. Please Login.',
                });
                this.$router.push('login')
              }).catch((err)=>{
                // eslint-disable-next-line
                console.log(err);
                this.$notify({
                  type: 'error',
                  group: 'info',
                  title: 'Error',
                  text: 'This user already exist, change email/nickname',
                });
              })
      },
  },
}
</script>