import React from "react";

import { Mutation } from "react-apollo";
import { TOGGLE_SELECTION } from "../queries";

import { withStyles } from "@material-ui/core/styles";
import GridListTile from "@material-ui/core/GridListTile";
import GridListTileBar from "@material-ui/core/GridListTileBar";
import IconButton from "@material-ui/core/IconButton";
import StarIcon from "@material-ui/icons/Star";

const styles = {
  gridItem: {
    width: "50%",
    padding: 2,
    height: 184
  },
  icon: {
    color: "rgba(255, 255, 255, 0.54)"
  },
  selectedIcon: {
    color: "yellow"
  }
};

const Talk = ({ classes, id, title, image, speakerName, selected }) => (
  <GridListTile key={title} className={classes.gridItem}>
    <img src={image} alt={title} />
    <GridListTileBar title={title} subtitle={<span>by: {speakerName}</span>} />
  </GridListTile>
);

export default withStyles(styles)(Talk);
