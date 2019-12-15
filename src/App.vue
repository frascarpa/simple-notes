<template>
  <v-app >
    <v-navigation-drawer
      v-model="drawer"
      app
    >
      <v-list dense>
        <template v-if="!user.isLogged">
          <v-list-item link @click="$router.push({name:'login'})">
            <v-list-item-action>
              <v-icon>mdi-login</v-icon>
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>Login</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
          <v-list-item link @click="$router.push({name:'register'})">
            <v-list-item-action>
              <v-icon>mdi-account-multiple-plus</v-icon>
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>Register</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </template>
        <template v-else>
          <v-list-item link @click="$router.push({name:'login'})">
            <v-list-item-action>
              <v-icon>mdi-logout</v-icon>
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>Logout</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
          <v-list-item link @click="$router.push({name:'explore'})">
            <v-list-item-action>
              <v-icon>mdi-compass</v-icon>
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>Explore</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
          <v-list-item link @click="$router.push({name:'create'})">
            <v-list-item-action>
              <v-icon>mdi-creation</v-icon>
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>Create</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
          <v-list-item link @click="$router.push({name:'notes'})" >
            <v-list-item-action>
              <v-icon>mdi-pencil</v-icon>
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>Notes</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
          <v-list-item link @click="$router.push({name:'search'})" >
            <v-list-item-action>
              <v-icon>mdi-search</v-icon>
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>Search</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </template>

      </v-list>
    </v-navigation-drawer>

    <v-app-bar
      app
      color="indigo"
      dark
    >
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
      <v-toolbar-title>Simple Notes</v-toolbar-title>
    </v-app-bar>

    <v-content>
      <v-container
        class="fill-height"
        fluid
      >
        <v-row
          align="center"
          justify="center"
        >
          <v-col class="text-center">
              <router-view :user="user"  @logout="logout" @logged-in="setLoggedIn"></router-view>
          </v-col>
        </v-row>
      </v-container>
    </v-content>
    <v-footer
      color="indigo"
      app
    >
      <span class="white--text">&copy; 2019</span>
    </v-footer>
    <notifications position="bottom center" width="100%" group="info" />
  </v-app>
</template>

<script>

export default {
  name: 'App',


  data: () => ({
    drawer: false,
    user: {
        isLogged: false,
        email: null,
        nickname: null,
      },
  }),

  methods: {
    createEmptyUser(){
      return {
        isLogged: false,
        email: null,
        nickname: null,
      };
    },
    setLoggedIn(user) {
      this.user = user;
      this.$router.push('/');      
    },
    logout(){
      this.user = this.createEmptyUser();
    },
  },
};
</script>
