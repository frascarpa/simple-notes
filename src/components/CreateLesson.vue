<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" persistent max-width="600px">
      <template v-slot:activator="{ on }">
        <v-btn color="primary" dark v-on="on">
          <v-icon>mdi-plus</v-icon>Add Lesson
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
              <v-col cols="12" lg="5" md="5">
                <v-menu
                  ref="dateMenu"
                  v-model="dateMenu"
                  :close-on-content-click="false"
                  :return-value.sync="date"
                  transition="scale-transition"
                  offset-y
                  min-width="290px"
                >
                  <template v-slot:activator="{ on }">
                    <v-text-field
                      v-model="dateFormatted"
                      label="Date of Lesson *"
                      prepend-inner-icon="event"
                      readonly
                      v-on="on"
                    ></v-text-field>
                  </template>
                  <v-date-picker @input="selectDate" v-model="date" no-title scrollable></v-date-picker>
                </v-menu>
              </v-col>
              <v-col cols="12" lg="7" md="7">
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
          <v-btn color="blue darken-1" text @click="create" :disabled="!selectedCourse || !name">Save</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
import { createLesson, getCourses } from "@/api.js";
import { dateFormattedFromISO } from "@/utils.js";

export default {
  name: "create-lesson",

  data() {
    return {
      dialog: false,
      name: null,
      description: null,
      courses: [],
      selectedCourse: null,
      date: new Date().toISOString().substr(0, 10),
      dateMenu: false
    };
  },

  watch: {
    dialog(newValue) {
      if (newValue === true) {
        getCourses().then(({ data }) => (this.courses = data.data));
      }
    }
  },

  computed: {
    dateFormatted() {
      return dateFormattedFromISO(this.date);
    }
  },

  methods: {
    selectDate() {
      this.$refs.dateMenu.save(this.date);
      this.dateMenu = false;
    },
    create() {
      createLesson(this.name, this.description, this.selectedCourse, this.date)
        .then(() => {
          this.dialog = false;
          this.$emit("created");
          this.notifyEntityCreated();
        })
        .catch(err => {
          this.$notify({
            type: "error",
            group: "info",
            title: "Error",
            text: "Cannot create Group: " + err
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
  }
};
</script>

<style>
</style>