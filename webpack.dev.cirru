
var
  fs $ require :fs
  path $ require :path
  webpack $ require :webpack
  settings $ require :./tasks/settings
  config $ settings.get :dev

= module.exports
  {}
    :entry $ {}
      :vendor $ []
        + :webpack-dev-server/client? config.host :: config.port
        , :webpack/hot/dev-server
      :main $ [] :./src/main

    :output $ {}
      :path $ path.join __dirname :../ :dist/
      :filename :[name].js
      :publicPath $ + config.host :: config.port :/

    :resolve $ {}
      :extensions $ [] :.js :.cirru

    :module $ {}
      :rules $ []
        {} (:test /\.cirru$) (:exclude /node_modules)
          :use :cirru-script-loader
        {} (:test "/\.(png|jpg|gif)$")
          :loader :url-loader
          :query $ {} (:limit 100)
        {} (:test /\.css$) $ :use
          []
            {} (:loader :style-loader)
            {} (:loader :css-loader)
        {} (:test /\.json$)
          :use $ [] $ {} (:loader :json-loader)

    :devServer $ {}
      :publicPath :/
      :hot true
      :compress true
      :clientLogLevel :info
      :disableHostCheck true
      :host :0.0.0.0
      :stats $ {}
        :all false
        :colors true
        :errors true
        :errorDetails true
        :performance true
        :reasons true
        :timings true
        :warnings true

    :plugins $ []
