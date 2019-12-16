<template>
  <div v-if="activity && activity.length">
    <v-expansion-panels class="mb-4" accordion>
      <v-expansion-panel>
        <v-expansion-panel-header expand-icon="mdi-menu-down">
          <div class="font-weight-light  pl-4">
            Recent Activity
          </div>
          </v-expansion-panel-header>
        <v-expansion-panel-content class="overflow-y-auto" style="max-height:200px">
          <v-list disabled dense>
            <v-list-item-group color="primary">
              <v-list-item v-for="act in activity" :key="act.id">
                <v-list-item-content>
                  <v-list-item-title
                    class="text-left"
                  >{{humanEntity(act.table)}} {{humanAction(act.action)}}</v-list-item-title>
                  <v-list-item-subtitle class="text-left">{{act.descr}}</v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </v-list-item-group>
          </v-list>
        </v-expansion-panel-content>
      </v-expansion-panel>
    </v-expansion-panels>
  </div>
</template>

<script>
import { getHistory } from "@/api.js";
export default {
  name: "history",

  data() {
    return {
      activity: []
    };
  },

  mounted() {
    getHistory().then(({ data }) => (this.activity = data.data));
  },
  methods: {
    humanEntity(str) {
      switch (str) {
        case "notes":
          return "note";
        case "lessons":
          return "lesson";
        case "users":
          return "user";
        case "courses":
          return "course";
        default:
          break;
      }
    },
    humanAction(str) {
      switch (str) {
        case "I":
          return "created";
        case "U":
          return "updated";
        case "D":
          return "deleted";
        default:
          break;
      }
    }
  }
};
</script>

<style>
</style>