import "phoenix_html";
import React, { Component } from "react";
import ReactDOM from "react-dom";

import ApolloClient from "apollo-boost";
import { InMemoryCache } from "apollo-cache-inmemory";
import { ApolloProvider } from "react-apollo";

import { GET_SELECTED_TALKS, GET_TALKS } from "./queries";

import { withStyles } from "@material-ui/core/styles";
import Header from "./components/Header";
import TalkGroup from "./components/TalkGroup";

const cache = new InMemoryCache();
const client = new ApolloClient({
  uri: "/api",
  cache,
  resolvers: {
    Mutation: {
      toggleTalkSelection: (_, { id, date }, { cache }) => {
        let { selectedTalks } = cache.readQuery({ query: GET_SELECTED_TALKS });
        selectedTalks = selectedTalks.includes(id)
          ? selectedTalks.filter(t => t !== id)
          : [...selectedTalks, id];
        cache.writeData({ data: { selectedTalks } });

        const { talks } = cache.readQuery({ query: GET_TALKS, variables: { date } });
        return talks.find(t => t.id === id);
      }
    },
    Talk: {
      selected: (talk, _args, { cache }) => {
        const { selectedTalks } = cache.readQuery({ query: GET_SELECTED_TALKS });
        return selectedTalks.includes(talk.id);
      }
    }
  }
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
          <TalkGroup date="2019-03-15" title="Viernes" talks={[]} />
          <TalkGroup date="2019-03-16" title="Sábado" talks={[]} />
          <TalkGroup date="2019-03-17" title="Domingo" talks={[]} />
        </ApolloProvider>
      </div>
    );
  }
}

App = withStyles(styles)(App);

ReactDOM.render(<App />, document.getElementById("root"));
