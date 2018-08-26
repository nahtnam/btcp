<template>
  <div class="home">
    <div v-if="loading"><Spinner /></div>
    <Converter
      v-else
      :btc-to-usd="this.btc.USD"
      :btc-to-inr="this.btc.INR"
      :btc-to-gbp="this.btc.GBP"
      :eth-to-usd="this.eth.USD"
      :eth-to-inr="this.eth.INR"
      :eth-to-gbp="this.eth.GBP"
      :ltc-to-usd="this.ltc.USD"
      :ltc-to-inr="this.ltc.INR"
      :ltc-to-gbp="this.ltc.GBP"
    />
  </div>
</template>

<script>
// @ is an alias to /src
import Converter from '@/components/Converter.vue';
import Spinner from '@/components/Spinner.vue';

export default {
  name: 'home',

  data() {
    return {
      btc: {},
      eth: {},
      ltc: {},
      loading: true,
    };
  },

  components: {
    Converter,
    Spinner,
  },

  async created() {
    const currenciesFetch = await Promise.all([
      fetch('https://api.coinbase.com/v2/exchange-rates?currency=BTC'),
      fetch('https://api.coinbase.com/v2/exchange-rates?currency=ETH'),
      fetch('https://api.coinbase.com/v2/exchange-rates?currency=LTC'),
    ]);
    const currenciesJSONMap = currenciesFetch.map(currencyFetch => currencyFetch.json());
    const currenciesJSON = await Promise.all(currenciesJSONMap);
    this.btc = currenciesJSON[0].data.rates;
    this.eth = currenciesJSON[1].data.rates;
    this.ltc = currenciesJSON[2].data.rates;
    this.loading = false;
  },
};
</script>
