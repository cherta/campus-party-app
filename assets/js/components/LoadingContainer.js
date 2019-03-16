import React, { Fragment } from "react";
import CircularProgress from "@material-ui/core/CircularProgress";
import { withStyles } from "@material-ui/core/styles";

const styles = {
  progress: {
    margin: 16
  }
};

const LoadingContainer = ({ classes, loading = true, children }) => (
  <Fragment>{loading ? <CircularProgress className={classes.progress} /> : children}</Fragment>
);

export default withStyles(styles)(LoadingContainer);
