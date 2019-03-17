import "phoenix_html";
import React, { Component } from "react";
import ReactDOM from "react-dom";

import ApolloClient from "apollo-boost";
import { InMemoryCache } from "apollo-cache-inmemory";
import { ApolloProvider } from "react-apollo";

import { withStyles } from "@material-ui/core/styles";
import Header from "./components/Header";
import TalkGroup from "./components/TalkGroup";

const cache = new InMemoryCache();
const client = new ApolloClient({
  uri: "/api",
  cache
});

cache.writeData({ data: { selectedTalks: [] } });

const styles = {
  root: {
    flexGrow: 1
  }
};

class App extends Component {
  render() {
    const { classes } = this.props;
    return (
      <div className={classes.root}>
        <ApolloProvider client={client}>
          <Header />
          <TalkGroup date="2019-03-15" title="Viernes" />
          <TalkGroup date="2019-03-16" title="Sábado" />
          <TalkGroup date="2019-03-17" title="Domingo" />
        </ApolloProvider>
      </div>
    );
  }
}

App = withStyles(styles)(App);

ReactDOM.render(<App />, document.getElementById("root"));
