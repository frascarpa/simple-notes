<template>
<div>
        <v-expansion-panels class="mb-12">
        <v-expansion-panel v-for="lesson in lessons" :key="lesson.id">
          <v-expansion-panel-header expand-icon="mdi-menu-down">{{lesson.name}}</v-expansion-panel-header>
          <v-expansion-panel-content>
              <div> {{lesson.description}}</div>
              <div>notes goes here</div>

          </v-expansion-panel-content>
        </v-expansion-panel>
      <div v-if="!lessons.length">No lessons found</div>
      </v-expansion-panels>
</div>
</template>

<script>
export default {
 name: 'lesson-list',

 props: {
     lessons: {
         type: Array,
         default: () => []
     },
 },
}
</script>

<style>

</style>