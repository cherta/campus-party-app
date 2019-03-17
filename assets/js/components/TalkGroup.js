import React from "react";

import gql from "graphql-tag";
import { Query } from "react-apollo";

import { withStyles } from "@material-ui/core/styles";
import GridList from "@material-ui/core/GridList";
import GridListTile from "@material-ui/core/GridListTile";
import ListSubheader from "@material-ui/core/ListSubheader";

import { GET_TALKS } from "../queries";

import Talk from "./Talk";
import Loadingcontainer from "./LoadingContainer";

const styles = {
  root: {
    display: "flex",
    flexWrap: "wrap",
    justifyContent: "space-around",
    overflow: "hidden",
    backgroundColor: "white"
  }
};

const TalkGroup = ({ classes, title, date }) => (
  <Query query={GET_TALKS} variables={{ date }}>
    {({ loading, data, error }) => (
      <div className={classes.root}>
        <GridList cellHeight={180}>
          <GridListTile key="Subheader" cols={2} style={{ height: "auto" }}>
            <ListSubheader component="div">{title}</ListSubheader>
          </GridListTile>
          <Loadingcontainer loading={loading}>
            {data.talks && data.talks.map(talk => <Talk key={talk.id} {...talk} />)}
          </Loadingcontainer>
        </GridList>
      </div>
    )}
  </Query>
);

export default withStyles(styles)(TalkGroup);
