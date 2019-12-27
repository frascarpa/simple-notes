module.exports = {
  "transpileDependencies": [
    "vuetify"
  ],
  devServer: {
    proxy: {
      '^/api': {
        target: 'http://localhost:8088/~francesco/api/',
        changeOrigin: true,
      },
    },
  },
}