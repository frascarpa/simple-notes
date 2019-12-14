<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" persistent max-width="600px">
      <template v-slot:activator="{ on }">
        <v-btn color="primary" dark v-on="on">
            <v-icon>mdi-plus</v-icon> Add Lesson
        </v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="headline">New Lesson</span>
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
            
            <v-row>
              <v-col cols="12">
                    <v-select
                      v-model="selectedCourse"
                      :items="courses"
                      label="Courses"
                      item-text="name"
                      item-value="id"
                  ></v-select>
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

import { createLesson, getCourses } from '@/api.js';

export default {
    name: 'create-lesson',

    data() {
        return {
            dialog: false,
            name: null,
            description: null,
            courses: [],
            selectedCourse: null,
        };
    },

    watch: {
      dialog(newValue) {
        if(newValue === true) {
          getCourses().then(({ data }) => (this.courses = data.data));
        }
        
      }
    },
    
    methods: {
        create() {
            createLesson(this.name, this.description, this.selectedCourse)
                .then(() => {
                    this.dialog = false;
                    this.$emit('created');
                    })
                    .catch((err) => {
                        this.$notify({
                            type: 'error',
                            group: 'info',
                            title: 'Error',
                            text: 'Cannot create Group: '+ err,
                        });
                    });

        }
    },
}
</script>

<style>

</style>