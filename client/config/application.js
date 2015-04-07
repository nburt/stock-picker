module.exports = function (lineman) {
  return {
    server: {
      pushState: true,
      apiProxy: {
        enabled: true,
        host: 'localhost',
        port: 3000,
        prefix: 'api/v1'
      }
    },

    enableSass: true,

    enableAssetFingerprint: true,

    concat_sourcemap: {
      js: {
        src: [
          "<%= files.js.vendor %>",
          "<%= files.coffee.generated %>",
          "<%= files.js.app %>",
          "<%= files.ngtemplates.dest %>"
        ]
      }
    }
  };
};
