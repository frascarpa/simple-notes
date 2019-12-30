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
                <v-toolbar-title>Login form</v-toolbar-title>
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
                    v-model="password"
                    id="password"
                    label="Password"
                    name="password"
                    prepend-icon="lock"
                    :append-icon="showPw ? 'mdi-eye' : 'mdi-eye-off'"
                    :type="showPw ? 'text' : 'password'"
                    @click:append="showPw = !showPw"
                  />
                </v-form>
              </v-card-text>
              <v-card-actions>
                <v-spacer />
                <v-btn color="primary" @click="doLogin">Login</v-btn>
              </v-card-actions>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
</template>

<script>

import {login} from '@/api.js'
export default {
  name: 'Login',

  data: () => ({
      email: null,
      password: null,
      error:false,
      showPw:false,
  }),

  created() {
    this.$store.commit('logout');
  },

  methods: {
      doLogin() {
          return login(this.email, this.password)
            .then(({data})=>{
              this.$store.commit('setUser', data.data);
              this.$router.push('/');
              }).catch((err)=>{
                this.$notify({
                  type: 'error',
                  group: 'info',
                  title: 'Error',
                  text: 'Credentials invalid'+ err,
                });
              })
      },
  },
}
</script>