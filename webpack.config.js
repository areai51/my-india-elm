var CopyWebpackPlugin = require('copy-webpack-plugin');
var path = require("path");
var webpack = require("webpack");

module.exports = {
  entry: {
    app: [
      './src/index.js'
    ]
  },

  output: {
    path: path.resolve(__dirname + '/dist'),
    filename: '[name].js',
  },

  module: {
    rules: [
      {
        test: /\.(css|scss)$/,
        use: [{
                loader: "style-loader"
            }, {
                loader: "css-loader"
            }, {
                loader: "sass-loader",
                options: {
                    includePaths: [path.resolve(__dirname, 'node_modules/bootstrap/scss/')]
                }
            }]
      },
	  { 
		test: /\.js$/, 
		exclude: /node_modules/, 
		loader: "babel-loader" 
	  },
      {
        test:    /\.html$/,
        exclude: /node_modules/,
        loader:  'file-loader?name=[name].[ext]',
      },
      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader:  'elm-webpack-loader?verbose=true&warn=true',
      },
      {
        test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'url-loader?limit=10000&mimetype=application/font-woff',
      },
      {
	  test: /\.(ttf|eot|svg|ico)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'file-loader',
      }
    ],

    noParse: /\.elm$/,
  },

  plugins: [
        new webpack.ProvidePlugin({
           $: "jquery",
           jQuery: "jquery",
           'Tether': 'tether'
       }),
       new CopyWebpackPlugin([
            { from: './src/assets/img', to: path.resolve(__dirname + '/dist') }
        ])
    ],

  devServer: {
    inline: true,
    stats: { colors: true },
  },


};
