<template>
  <div>
    <h1 class="title is-1">{{ leftCurrency.toLowerCase() }} to {{ rightCurrency.toLowerCase() }}</h1>
    <div class="columns">
      <div class="column is-one-half">
        <div class="field has-addons">
          <div class="control is-expanded">
            <input v-model="left" @keypress="strip" @keyup="updateLeft" type="text" class="input is-large has-text-centered" autofocus="true">
          </div>
          <div class="control">
            <div class="select is-large">
              <select v-model="leftCurrency" @change="updateLeft">
                <option value="BTC">BTC</option>
                <option value="ETH">ETH</option>
                <option value="LTC">LTC</option>
              </select>
            </div>
          </div>
        </div>
      </div>
      <div class="column is-one-half">
        <div class="field has-addons">
          <div class="control is-expanded">
            <input v-model="right" @keypress="strip" @keyup="updateRight" type="text" class="input is-large has-text-centered">
          </div>
          <div class="control">
            <div class="select is-large">
              <select class="browser-default" v-model="rightCurrency" @change="updateRight">
                <option value="USD">USD</option>
                <option value="INR">INR</option>
                <option value="GBP">GBP</option>
              </select>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
/* global window */
export default {
  name: 'converter',

  props: [
    'btcToUsd',
    'btcToInr',
    'btcToGbp',
    'ethToUsd',
    'ethToInr',
    'ethToGbp',
    'ltcToUsd',
    'ltcToInr',
    'ltcToGbp',
  ],

  data() {
    console.log('btc', this.btcToUsd);
    return {
      primary: 'left',
      left: 1,
      leftCurrency: 'BTC',
      right: parseFloat(this.btcToUsd).toFixed(2),
      rightCurrency: 'USD',
    };
  },

  created() {
    try {
      const leftCurrency = window.localStorage.getItem('leftCurrency');
      const rightCurrency = window.localStorage.getItem('rightCurrency');
      this.leftCurrency = leftCurrency || 'BTC';
      this.rightCurrency = rightCurrency || 'USD';
    } catch (_) {
      // do nothing
    }
  },

  methods: {
    updateLeft() {
      this.primary = 'left';
      this.update();
    },

    updateRight() {
      this.primary = 'right';
      this.update();
    },

    update() {
      try {
        window.localStorage.setItem('leftCurrency', this.leftCurrency);
        window.localStorage.setItem('rightCurrency', this.rightCurrency);
      } catch (_) {
        // do nothing
      }

      if (this.primary === 'left') {
        const base = parseFloat(this.left) || 0;
        const match = `${this.leftCurrency.toLowerCase()}To${this.rightCurrency.charAt(0)}${this.rightCurrency.slice(1).toLowerCase()}`;
        this.right = (base * this[match]).toFixed(2);
      } else {
        const base = parseFloat(this.right) || 0;
        const match = `${this.leftCurrency.toLowerCase()}To${this.rightCurrency.charAt(0)}${this.rightCurrency.slice(1).toLowerCase()}`;
        this.left = (base / this[match]).toFixed(8);
      }
    },

    strip() {
      const event = window.event;
      const charCode = (event.which) ? event.which : event.keyCode;
      if (
        (charCode > 31 && (charCode < 48 || charCode > 57)) &&
          charCode !== 46 && charCode !== 44 && charCode !== 35
      ) {
        event.preventDefault();
      }
    },
  },
};
</script>

<style scoped>
</style>
