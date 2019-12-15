<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" persistent max-width="600px">
      <template v-slot:activator="{ on }">
        <v-btn color="primary" dark v-on="on">
            <v-icon>mdi-plus</v-icon> Add Course
        </v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="headline">User Profile</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12">
                <v-text-field v-model="name" label="Name *" required></v-text-field>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12">
                <v-text-field v-model="description" label="Description"></v-text-field>
              </v-col>
            </v-row>
          </v-container>
          <small>*indicates required field</small>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click="dialog = false">Close</v-btn>
          <v-btn color="blue darken-1" text @click="create">Save</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>

import { createCourse } from '@/api.js';

export default {
    name: 'create-course',

    data() {
        return {
            dialog: false,
            name: null,
            description: null,
        };
    },

    methods: {
        create() {
            createCourse(this.name, this.description)
                .then(() => {
                    this.dialog = false;
                    this.$emit('created');
                    this.notifyEntityCreated();
                    })
                    .catch((err) => {
                        this.$notify({
                            type: 'error',
                            group: 'info',
                            title: 'Error',
                            text: 'Cannot create Group: '+ err,
                        });
                    });

        },
        notifyEntityCreated() {
          this.$notify({
              type: "success",
              group: "info",
              title: "Done!",
              text: "New entity created"
            });
    }
    },
}
</script>

<style>

</style>