<template>
  <div id="app">
    <section class="hero is-fullheight">
      <div class="hero-head">
        <Navigation />
      </div>
      <div class="hero-body">
        <div class="container has-text-centered">
          <router-view/>
        </div>
      </div>
      <!-- <search></search> -->
      <Footer />
    </section>
  </div>
</template>

<script>
import Navigation from '@/components/Navigation.vue';
import Footer from '@/components/Footer.vue';

export default {
  components: {
    Navigation,
    Footer,
  },
};
</script>


<style lang="scss">
@import '@/assets/css/app.scss';
</style>
